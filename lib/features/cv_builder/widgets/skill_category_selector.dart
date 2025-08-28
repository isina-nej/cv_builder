// lib/features/cv_builder/widgets/skill_category_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../config/themes/colors.dart';
import '../models/skill.dart';

class SkillCategorySelector extends StatelessWidget {
  final SkillCategory selectedCategory;
  final Function(SkillCategory) onCategorySelected;

  const SkillCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skill Category',
          style: TextStyle(fontFamily: 'System',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Gap(12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 8.h,
          children: SkillCategory.values.map((category) {
            final isSelected = category == selectedCategory;
            return GestureDetector(
              onTap: () => onCategorySelected(category),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        )
                      : null,
                  color: isSelected ? null : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.grey.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _getCategoryIcon(category),
                      size: 18.sp,
                      color: isSelected ? Colors.white : AppColors.primary,
                    ),
                    Gap(8.w),
                    Text(
                      _getCategoryDisplayName(category),
                      style: TextStyle(fontFamily: 'System',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().scale(
              delay: Duration(
                milliseconds: SkillCategory.values.indexOf(category) * 100,
              ),
              duration: 400.ms,
              curve: Curves.elasticOut,
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _getCategoryIcon(SkillCategory category) {
    switch (category) {
      case SkillCategory.technical:
        return Icons.computer;
      case SkillCategory.language:
        return Icons.language;
      case SkillCategory.soft:
        return Icons.psychology;
      case SkillCategory.creative:
        return Icons.palette;
      case SkillCategory.analytical:
        return Icons.analytics;
      case SkillCategory.management:
        return Icons.manage_accounts;
      case SkillCategory.communication:
        return Icons.forum;
      case SkillCategory.other:
        return Icons.extension;
    }
  }

  String _getCategoryDisplayName(SkillCategory category) {
    switch (category) {
      case SkillCategory.technical:
        return 'Technical';
      case SkillCategory.language:
        return 'Language';
      case SkillCategory.soft:
        return 'Soft Skills';
      case SkillCategory.creative:
        return 'Creative';
      case SkillCategory.analytical:
        return 'Analytical';
      case SkillCategory.management:
        return 'Management';
      case SkillCategory.communication:
        return 'Communication';
      case SkillCategory.other:
        return 'Other';
    }
  }
}
