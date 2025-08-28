// lib/features/cv_builder/screens/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import '../../../config/routes/app_router.dart';
import '../../../core/providers/app_theme_provider.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/widgets/loading_widgets.dart';
import '../../../core/widgets/theme_selector.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startIntroSequence();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );
  }

  Future<void> _startIntroSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      setState(() => _isLoading = false);
      _fadeController.forward();
      await Future.delayed(const Duration(milliseconds: 200));
      if (mounted) {
        _slideController.forward();
      }
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ],
          ),
        ),
        child: SafeArea(
          child: ResponsiveBuilder(
            builder: (context, isMobile, isTablet, isDesktop) {
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: ResponsiveUtils.getMaxWidth(context),
                  ),
                  child: Padding(
                    padding: ResponsiveUtils.getResponsivePadding(
                      context,
                      mobile: const EdgeInsets.all(24),
                      tablet: const EdgeInsets.all(40),
                      desktop: const EdgeInsets.all(60),
                    ),
                    child: _isLoading
                        ? const LoadingWidget(
                            message: 'Preparing your CV builder...',
                            color: Colors.white,
                          )
                        : _buildWelcomeContent(
                            context,
                            isMobile,
                            isTablet,
                            isDesktop,
                          ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showThemeSelector(context),
        backgroundColor: Colors.white,
        child: Icon(
          Icons.palette,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildWelcomeContent(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Section
              _buildLogoSection(context, isMobile, isTablet, isDesktop),

              Gap(
                ResponsiveUtils.getResponsiveFontSize(
                  context,
                  mobile: 32,
                  tablet: 40,
                  desktop: 48,
                ),
              ),

              // Title Section
              _buildTitleSection(context, isMobile, isTablet, isDesktop),

              Gap(
                ResponsiveUtils.getResponsiveFontSize(
                  context,
                  mobile: 32,
                  tablet: 40,
                  desktop: 48,
                ),
              ),

              // Features Section
              _buildFeaturesSection(context, isMobile, isTablet, isDesktop),

              Gap(
                ResponsiveUtils.getResponsiveFontSize(
                  context,
                  mobile: 40,
                  tablet: 50,
                  desktop: 60,
                ),
              ),

              // Action Buttons
              _buildActionButtons(context, isMobile, isTablet, isDesktop),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final logoSize = ResponsiveUtils.getResponsiveFontSize(
      context,
      mobile: 120,
      tablet: 150,
      desktop: 180,
    );

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            width: logoSize,
            height: logoSize,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Colors.white70],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.description_outlined,
              size: logoSize * 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitleSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    return Column(
      children: [
        Text(
          'CV Builder Pro',
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(
              context,
              mobile: 32,
              tablet: 40,
              desktop: 48,
            ),
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'System',
          ),
          textAlign: TextAlign.center,
        ),
        Gap(16.h),
        Text(
          'Create stunning professional CVs\nwith modern templates and seamless experience',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 20,
            ),
            color: Colors.white.withValues(alpha: 0.9),
            height: 1.5,
            fontFamily: 'System',
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final features = [
      {
        'icon': Icons.palette_outlined,
        'title': 'Professional Templates',
        'description': '12+ modern, ATS-friendly designs',
      },
      {
        'icon': Icons.auto_awesome_outlined,
        'title': 'Smart Builder',
        'description': 'AI-powered suggestions and tips',
      },
      {
        'icon': Icons.download_outlined,
        'title': 'Multiple Formats',
        'description': 'PDF, DOCX, and HTML exports',
      },
    ];

    return ResponsiveBuilder(
      builder: (context, isMobile, isTablet, isDesktop) {
        if (isMobile) {
          return Column(
            children: features
                .map((feature) => _buildFeatureItem(context, feature, true))
                .toList(),
          );
        } else {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: features
                .map(
                  (feature) => Expanded(
                    child: _buildFeatureItem(context, feature, false),
                  ),
                )
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildFeatureItem(
    BuildContext context,
    Map<String, dynamic> feature,
    bool isMobile,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isMobile ? 12.h : 0,
        horizontal: isMobile ? 0 : 8.w,
      ),
      padding: EdgeInsets.all(isMobile ? 16.w : 20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              feature['icon'] as IconData,
              size: 30.sp,
              color: Colors.white,
            ),
          ),
          Gap(12.h),
          Text(
            feature['title'] as String,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'System',
            ),
            textAlign: TextAlign.center,
          ),
          Gap(8.h),
          Text(
            feature['description'] as String,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
              fontFamily: 'System',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          children: [
            // Primary action button
            SizedBox(
              width: isMobile ? double.infinity : 300.w,
              child: PulsingLoadingButton(
                text: 'Get Started',
                isLoading: themeProvider.isLoading,
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.builder);
                },
              ),
            ),

            Gap(16.h),

            // Secondary action button
            SizedBox(
              width: isMobile ? double.infinity : 300.w,
              child: OutlinedButton.icon(
                onPressed: () {
                  _showTemplatePreview(context);
                },
                icon: Icon(Icons.preview, size: 20.sp),
                label: Text(
                  'Preview Templates',
                  style: TextStyle(fontSize: 16.sp),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showThemeSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ThemeSelector(),
    );
  }

  void _showTemplatePreview(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Template preview coming soon!'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
