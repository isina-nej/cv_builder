// lib/features/cv_builder/widgets/cv_template_preview.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../config/themes/colors.dart';
import '../../../core/providers/cv_provider.dart';
import '../models/skill.dart';

class CVTemplatePreview extends StatelessWidget {
  const CVTemplatePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CVProvider>(
      builder: (context, cvProvider, child) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  _buildHeader(cvProvider),
                  Gap(24.h),
                  
                  // Professional Summary
                  if (cvProvider.cv.personalInfo.summary.isNotEmpty) ...[
                    _buildSection(
                      'Professional Summary',
                      Icons.person_outline,
                      child: Text(
                        cvProvider.cv.personalInfo.summary,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.grey[700],
                          height: 1.6,
                        ),
                      ),
                    ),
                    Gap(24.h),
                  ],

                  // Experience Section
                  if (cvProvider.cv.experiences.isNotEmpty) ...[
                    _buildSection(
                      'Work Experience',
                      Icons.work_outline,
                      child: Column(
                        children: cvProvider.cv.experiences.map((exp) {
                          return _buildExperienceItem(exp);
                        }).toList(),
                      ),
                    ),
                    Gap(24.h),
                  ],

                  // Education Section
                  if (cvProvider.cv.educations.isNotEmpty) ...[
                    _buildSection(
                      'Education',
                      Icons.school_outlined,
                      child: Column(
                        children: cvProvider.cv.educations.map((edu) {
                          return _buildEducationItem(edu);
                        }).toList(),
                      ),
                    ),
                    Gap(24.h),
                  ],

                  // Skills Section
                  if (cvProvider.cv.skills.isNotEmpty) ...[
                    _buildSection(
                      'Skills & Expertise',
                      Icons.star_outline,
                      child: _buildSkillsGrid(cvProvider.cv.skills),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ).animate().slideY(
          begin: 0.3,
          duration: 800.ms,
          curve: Curves.easeOut,
        );
      },
    );
  }

  Widget _buildHeader(CVProvider cvProvider) {
    final personal = cvProvider.cv.personalInfo;
    
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            personal.name.isNotEmpty ? personal.name : 'Your Name',
            style: GoogleFonts.inter(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Gap(8.h),
          Text(
            'Professional',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          Gap(16.h),
          
          // Contact Info
          Wrap(
            spacing: 20.w,
            runSpacing: 8.h,
            children: [
              if (personal.email.isNotEmpty)
                _buildContactItem(Icons.email_outlined, personal.email),
              if (personal.phone.isNotEmpty)
                _buildContactItem(Icons.phone_outlined, personal.phone),
              if (personal.address.isNotEmpty)
                _buildContactItem(Icons.location_on_outlined, personal.address),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: Colors.white.withOpacity(0.9),
        ),
        Gap(6.w),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, IconData icon, {required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: AppColors.primary,
            ),
            Gap(8.w),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Container(
                height: 1,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
          ],
        ),
        Gap(16.h),
        child,
      ],
    );
  }

  Widget _buildExperienceItem(dynamic exp) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot
          Container(
            margin: EdgeInsets.only(top: 8.h, right: 16.w),
            width: 12.w,
            height: 12.w,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
          ),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.position ?? 'Position',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Gap(4.h),
                Text(
                  exp.company ?? 'Company',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primary,
                  ),
                ),
                Gap(4.h),
                Text(
                  '${exp.startDate ?? 'Start'} - ${exp.endDate ?? 'Present'}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                if (exp.description?.isNotEmpty == true) ...[
                  Gap(8.h),
                  Text(
                    exp.description!,
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem(dynamic edu) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline dot
          Container(
            margin: EdgeInsets.only(top: 8.h, right: 16.w),
            width: 12.w,
            height: 12.w,
            decoration: const BoxDecoration(
              color: AppColors.secondary,
              shape: BoxShape.circle,
            ),
          ),
          
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  edu.degree ?? 'Degree',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Gap(4.h),
                Text(
                  edu.institution ?? 'Institution',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondary,
                  ),
                ),
                Gap(4.h),
                Text(
                  '${edu.startDate ?? 'Start'} - ${edu.endDate ?? 'Present'}',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                if (edu.grade?.isNotEmpty == true) ...[
                  Gap(4.h),
                  Text(
                    'Grade: ${edu.grade}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsGrid(List<dynamic> skills) {
    // Group skills by category
    final Map<SkillCategory, List<dynamic>> groupedSkills = {};
    for (final skill in skills) {
      if (!groupedSkills.containsKey(skill.category)) {
        groupedSkills[skill.category] = [];
      }
      groupedSkills[skill.category]!.add(skill);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: groupedSkills.entries.map((entry) {
        return Container(
          margin: EdgeInsets.only(bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getCategoryDisplayName(entry.key),
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              Gap(12.h),
              Wrap(
                spacing: 12.w,
                runSpacing: 8.h,
                children: entry.value.map((skill) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(skill.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: _getCategoryColor(skill.category).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          skill.name,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: _getCategoryColor(skill.category),
                          ),
                        ),
                        Gap(6.w),
                        ...List.generate(skill.level, (index) {
                          return Icon(
                            Icons.circle,
                            size: 6.sp,
                            color: _getCategoryColor(skill.category),
                          );
                        }),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _getCategoryDisplayName(SkillCategory category) {
    switch (category) {
      case SkillCategory.technical:
        return 'Technical Skills';
      case SkillCategory.language:
        return 'Languages';
      case SkillCategory.soft:
        return 'Soft Skills';
      case SkillCategory.creative:
        return 'Creative Skills';
      case SkillCategory.analytical:
        return 'Analytical Skills';
      case SkillCategory.management:
        return 'Management Skills';
      case SkillCategory.communication:
        return 'Communication Skills';
      case SkillCategory.other:
        return 'Other Skills';
    }
  }

  Color _getCategoryColor(SkillCategory category) {
    switch (category) {
      case SkillCategory.technical:
        return Colors.blue;
      case SkillCategory.language:
        return Colors.green;
      case SkillCategory.soft:
        return Colors.purple;
      case SkillCategory.creative:
        return Colors.orange;
      case SkillCategory.analytical:
        return Colors.teal;
      case SkillCategory.management:
        return Colors.indigo;
      case SkillCategory.communication:
        return Colors.pink;
      case SkillCategory.other:
        return Colors.grey;
    }
  }
}
