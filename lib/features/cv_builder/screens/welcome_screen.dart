// lib/features/cv_builder/screens/welcome_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../../config/themes/colors.dart';
import '../../../config/routes/app_router.dart';
import '../widgets/animated_gradient_container.dart';
import '../widgets/floating_action_button_animated.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedGradientContainer(
            gradientColors: const [
              AppColors.primary,
              AppColors.secondary,
              AppColors.accent,
            ],
            child: Container(),
          ),

          // Glass morphism overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  const Spacer(),

                  // Animated Logo Section
                  AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 1000),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          horizontalOffset: 50.w,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [
                          // Logo with pulse animation
                          Container(
                                width: 120.w,
                                height: 120.w,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.white, Colors.white70],
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 30,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.description_outlined,
                                  size: 60.sp,
                                  color: AppColors.primary,
                                ),
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .scale(
                                begin: const Offset(1.0, 1.0),
                                end: const Offset(1.1, 1.1),
                                duration: 2000.ms,
                                curve: Curves.easeInOut,
                              )
                              .then()
                              .scale(
                                begin: const Offset(1.1, 1.1),
                                end: const Offset(1.0, 1.0),
                                duration: 2000.ms,
                                curve: Curves.easeInOut,
                              ),

                          Gap(32.h),

                          // Animated Title
                          AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return FadeTransition(
                                opacity: _fadeAnimation,
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: Column(
                                    children: [
                                      DefaultTextStyle(
                                        style: GoogleFonts.poppins(
                                          fontSize: 32.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TyperAnimatedText(
                                              'CV Builder Pro',
                                              speed: const Duration(
                                                milliseconds: 100,
                                              ),
                                            ),
                                          ],
                                          isRepeatingAnimation: false,
                                        ),
                                      ),

                                      Gap(16.h),

                                      Text(
                                        'Create stunning professional CVs\\nwith modern templates and animations',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.inter(
                                          fontSize: 16.sp,
                                          color: Colors.white.withOpacity(0.9),
                                          height: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Feature highlights with staggered animations
                  AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 1000),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 50.h,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [
                          _buildFeatureItem(
                            icon: Icons.palette_outlined,
                            title: 'Professional Templates',
                            description: 'Choose from 12+ modern designs',
                          ),
                          Gap(20.h),
                          _buildFeatureItem(
                            icon: Icons.auto_awesome_outlined,
                            title: 'Smart Animations',
                            description: 'Engaging transitions and effects',
                          ),
                          Gap(20.h),
                          _buildFeatureItem(
                            icon: Icons.download_outlined,
                            title: 'Export Options',
                            description: 'PDF, DOCX, and HTML formats',
                          ),
                        ],
                      ),
                    ),
                  ),

                  Gap(40.h),

                  // Action buttons with animated entrance
                  AnimationLimiter(
                    child: Column(
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 1500),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset: 30.h,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [
                          FloatingActionButtonAnimated(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRouter.builder,
                              (route) => false,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 56.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.9),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.rocket_launch_outlined,
                                    color: AppColors.primary,
                                    size: 24.sp,
                                  ),
                                  Gap(12.w),
                                  Text(
                                    'Get Started',
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Gap(16.h),

                          TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              AppRouter.builder,
                              (route) => false,
                            ),
                            child: Text(
                              'Skip Introduction',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: Colors.white.withOpacity(0.8),
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Gap(24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, size: 24.sp, color: Colors.white),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Gap(4.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
