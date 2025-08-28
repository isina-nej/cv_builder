// lib/features/cv_builder/widgets/skill_level_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../config/themes/colors.dart';

class SkillLevelSelector extends StatelessWidget {
  final int selectedLevel;
  final Function(int) onLevelSelected;

  const SkillLevelSelector({
    super.key,
    required this.selectedLevel,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skill Level',
          style: TextStyle(fontFamily: 'System',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Gap(12.h),

        // Skill level indicator
        Row(
          children: [
            Expanded(
              child: Text(
                _getLevelText(selectedLevel),
                style: TextStyle(fontFamily: 'System',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Text(
              '$selectedLevel/5',
              style: TextStyle(fontFamily: 'System',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ],
        ),

        Gap(16.h),

        // Interactive skill bars
        Row(
          children: List.generate(5, (index) {
            final level = index + 1;
            final isActive = level <= selectedLevel;

            return Expanded(
              child:
                  GestureDetector(
                    onTap: () => onLevelSelected(level),
                    child: Container(
                      margin: EdgeInsets.only(right: index < 4 ? 8.w : 0),
                      height: 12.h,
                      decoration: BoxDecoration(
                        gradient: isActive
                            ? LinearGradient(
                                colors: [
                                  _getLevelColor(level).withOpacity(0.7),
                                  _getLevelColor(level),
                                ],
                              )
                            : null,
                        color: isActive ? null : Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ).animate().scale(
                    delay: Duration(milliseconds: index * 100),
                    duration: 400.ms,
                    curve: Curves.elasticOut,
                  ),
            );
          }),
        ),

        Gap(16.h),

        // Level buttons
        Wrap(
          spacing: 8.w,
          children: List.generate(5, (index) {
            final level = index + 1;
            final isSelected = level == selectedLevel;

            return GestureDetector(
              onTap: () => onLevelSelected(level),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            _getLevelColor(level).withOpacity(0.8),
                            _getLevelColor(level),
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Text(
                  level.toString(),
                  style: TextStyle(fontFamily: 'System',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ).animate().scale(
              delay: Duration(milliseconds: index * 50),
              duration: 300.ms,
              curve: Curves.elasticOut,
            );
          }),
        ),
      ],
    );
  }

  String _getLevelText(int level) {
    switch (level) {
      case 1:
        return 'Beginner - Basic knowledge';
      case 2:
        return 'Novice - Limited experience';
      case 3:
        return 'Intermediate - Some experience';
      case 4:
        return 'Advanced - Extensive experience';
      case 5:
        return 'Expert - Highly experienced';
      default:
        return 'Select level';
    }
  }

  Color _getLevelColor(int level) {
    switch (level) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
