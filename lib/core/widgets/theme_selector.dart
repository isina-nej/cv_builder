// lib/core/widgets/theme_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:gap/gap.dart';
import '../models/theme_config.dart';
import '../providers/app_theme_provider.dart';
import 'loading_widgets.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Gap(20.h),

              // Title
              Text(
                'Choose Theme',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(16.h),

              Text(
                'Select a color scheme that matches your style',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 16.sp),
              ),
              Gap(24.h),

              // Theme grid
              if (themeProvider.isLoading) ...[
                const LoadingWidget(message: 'Applying theme...'),
                Gap(20.h),
              ] else ...[
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: ThemeConfig.presets.length,
                  itemBuilder: (context, index) {
                    final preset = ThemeConfig.presets[index];
                    final isSelected = themeProvider.currentThemeIndex == index;

                    return GestureDetector(
                      onTap: () async {
                        await themeProvider.applyThemeWithAnimation();
                        themeProvider.setTheme(index);
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? preset.primaryColor
                                : Colors.grey.withValues(alpha: 0.3),
                            width: isSelected ? 3 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: preset.primaryColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : [],
                        ),
                        child: Stack(
                          children: [
                            // Color preview
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.r),
                                gradient: LinearGradient(
                                  colors: [
                                    preset.primaryColor,
                                    preset.secondaryColor,
                                    preset.accentColor,
                                  ],
                                ),
                              ),
                            ),

                            // Overlay with theme name
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11.r),
                                color: Colors.black.withValues(alpha: 0.4),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _getThemeName(index),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'System',
                                      ),
                                    ),
                                    if (isSelected) ...[
                                      Gap(4.h),
                                      Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],

              Gap(24.h),

              // Custom theme button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Implement custom theme creator
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Custom theme creator coming soon!'),
                      ),
                    );
                  },
                  icon: Icon(Icons.palette, size: 20.sp),
                  label: Text(
                    'Create Custom Theme',
                    style: TextStyle(fontSize: 16.sp),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),

              Gap(MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  String _getThemeName(int index) {
    switch (index) {
      case 0:
        return 'Modern Blue';
      case 1:
        return 'Dark Purple';
      case 2:
        return 'Green Nature';
      case 3:
        return 'Orange Sunset';
      default:
        return 'Theme ${index + 1}';
    }
  }
}
