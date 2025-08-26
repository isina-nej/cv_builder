// lib/features/cv_builder/widgets/skill_form.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../core/providers/cv_provider.dart';
import '../models/skill.dart';
import '../../../config/themes/colors.dart';

class SkillForm extends StatefulWidget {
  const SkillForm({super.key});

  @override
  State<SkillForm> createState() => _SkillFormState();
}

class _SkillFormState extends State<SkillForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  int _selectedLevel = 3;

  final List<SkillCategory> _skillCategories = SkillCategory.values;

  SkillCategory _selectedCategory = SkillCategory.technical;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _addSkill() {
    if (_formKey.currentState!.validate()) {
      final skill = Skill(
        name: _nameController.text,
        level: _selectedLevel,
        category: _selectedCategory,
      );

      context.read<CVProvider>().addSkill(skill);
      _nameController.clear();
      _selectedLevel = 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cvProvider = context.watch<CVProvider>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Skills & Expertise',
            style: GoogleFonts.poppins(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onBackground,
            ),
          ),
          Gap(8.h),
          Text(
            'Add your technical and soft skills with proficiency levels',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          Gap(24.h),

          // Add new skill section
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.colorScheme.outline.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add New Skill',
                  style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(16.h),

                // Skill name
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Skill Name',
                    hintText: 'e.g., Flutter, Photoshop, Public Speaking',
                    prefixIcon: const Icon(Icons.star_outline),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a skill name';
                    }
                    return null;
                  },
                ),
                Gap(16.h),

                // Category dropdown
                DropdownButtonFormField<SkillCategory>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: _skillCategories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(_getCategoryDisplayName(category)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
                Gap(16.h),

                // Skill level
                Text(
                  'Proficiency Level: ${_getSkillLevelText(_selectedLevel)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gap(8.h),
                Slider(
                  value: _selectedLevel.toDouble(),
                  min: 1,
                  max: 5,
                  divisions: 4,
                  onChanged: (value) {
                    setState(() {
                      _selectedLevel = value.round();
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Beginner', style: GoogleFonts.inter(fontSize: 12.sp)),
                    Text('Expert', style: GoogleFonts.inter(fontSize: 12.sp)),
                  ],
                ),
                Gap(16.h),

                // Add button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _addSkill,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add),
                        Gap(8.w),
                        Text('Add Skill'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(24.h),

          // Skills list
          if (cvProvider.cv.skills.isNotEmpty) ...[
            Text(
              'Your Skills',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(16.h),

            AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cvProvider.cv.skills.length,
                itemBuilder: (context, index) {
                  final skill = cvProvider.cv.skills[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.h,
                      child: FadeInAnimation(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceVariant.withOpacity(
                              0.3,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: _getSkillLevelColor(
                                skill.level,
                              ).withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Skill level indicator
                              Container(
                                width: 4.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: _getSkillLevelColor(skill.level),
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                              Gap(12.w),

                              // Skill info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            skill.name,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8.w,
                                            vertical: 4.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: _getSkillLevelColor(
                                              skill.level,
                                            ).withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                          ),
                                          child: Text(
                                            _getCategoryDisplayName(
                                              skill.category,
                                            ),
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              color: _getSkillLevelColor(
                                                skill.level,
                                              ),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gap(4.h),
                                    Text(
                                      _getSkillLevelText(skill.level),
                                      style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    Gap(8.h),
                                    // Progress bar
                                    LinearProgressIndicator(
                                      value: skill.level / 5,
                                      backgroundColor:
                                          theme.colorScheme.surfaceVariant,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _getSkillLevelColor(skill.level),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Delete button
                              IconButton(
                                onPressed: () =>
                                    _showDeleteConfirmation(context, index),
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getSkillLevelText(int level) {
    switch (level) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Basic';
      case 3:
        return 'Intermediate';
      case 4:
        return 'Advanced';
      case 5:
        return 'Expert';
      default:
        return 'Intermediate';
    }
  }

  Color _getSkillLevelColor(int level) {
    switch (level) {
      case 1:
        return AppColors.skillBeginner;
      case 2:
        return AppColors.warning;
      case 3:
        return AppColors.info;
      case 4:
        return AppColors.skillAdvanced;
      case 5:
        return AppColors.skillExpert;
      default:
        return AppColors.info;
    }
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Skill'),
        content: const Text('Are you sure you want to delete this skill?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CVProvider>().removeSkill(index);
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
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
