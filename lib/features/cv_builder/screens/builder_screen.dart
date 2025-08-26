// lib/features/cv_builder/screens/builder_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../config/themes/colors.dart';
import '../../../core/providers/cv_provider.dart';
import '../../../core/providers/theme_provider.dart';
import '../widgets/animated_card.dart';
import '../widgets/step_indicator.dart';
import '../widgets/personal_form.dart';
import '../widgets/education_form.dart';
import '../widgets/experience_form.dart';
import '../widgets/skill_form.dart';
import '../widgets/template_selector.dart';

class BuilderScreen extends StatefulWidget {
  const BuilderScreen({super.key});

  @override
  State<BuilderScreen> createState() => _BuilderScreenState();
}

class _BuilderScreenState extends State<BuilderScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentStep = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<BuilderStep> _steps = [
    BuilderStep(
      title: 'Personal Info',
      icon: Icons.person_outline,
      description: 'Add your basic information',
    ),
    BuilderStep(
      title: 'Experience',
      icon: Icons.work_outline,
      description: 'Share your work experience',
    ),
    BuilderStep(
      title: 'Education',
      icon: Icons.school_outlined,
      description: 'Add your educational background',
    ),
    BuilderStep(
      title: 'Skills',
      icon: Icons.star_outline,
      description: 'Highlight your skills',
    ),
    BuilderStep(
      title: 'Template',
      icon: Icons.palette_outlined,
      description: 'Choose your design',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToStep(int step) {
    setState(() {
      _currentStep = step;
    });
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(
          'CV Builder',
          style: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        actions: [
          IconButton(
            onPressed: () => themeProvider.toggleTheme(),
            icon: Icon(
              themeProvider.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          Gap(8.w),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Step Indicator
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: StepIndicator(
                steps: _steps,
                currentStep: _currentStep,
                onStepTapped: _goToStep,
              ),
            ),

            // Content Area
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentStep = index;
                    });
                  },
                  children: [
                    _buildStepContent(const PersonalForm()),
                    _buildStepContent(const ExperienceForm()),
                    _buildStepContent(const EducationForm()),
                    _buildStepContent(const SkillForm()),
                    _buildStepContent(const TemplateSelector()),
                  ],
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: theme.shadowColor.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousStep,
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back_ios, size: 18.sp),
                            Gap(8.w),
                            Text(
                              'Previous',
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  if (_currentStep > 0 && _currentStep < _steps.length - 1)
                    Gap(16.w),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: _currentStep < _steps.length - 1
                          ? _nextStep
                          : () => Navigator.pushNamed(context, '/preview'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentStep < _steps.length - 1
                                ? 'Next'
                                : 'Preview CV',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(8.w),
                          Icon(
                            _currentStep < _steps.length - 1
                                ? Icons.arrow_forward_ios
                                : Icons.preview_outlined,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent(Widget child) {
    return AnimationLimiter(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: AnimationConfiguration.staggeredList(
          position: 0,
          duration: const Duration(milliseconds: 600),
          child: SlideAnimation(
            verticalOffset: 30.h,
            child: FadeInAnimation(child: AnimatedCard(child: child)),
          ),
        ),
      ),
    );
  }
}

class BuilderStep {
  final String title;
  final IconData icon;
  final String description;

  BuilderStep({
    required this.title,
    required this.icon,
    required this.description,
  });
}
