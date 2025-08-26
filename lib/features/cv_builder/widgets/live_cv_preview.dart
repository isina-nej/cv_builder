// lib/features/cv_builder/widgets/live_cv_preview.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../config/themes/colors.dart';
import '../../../core/providers/cv_provider.dart';
import '../models/skill.dart';

class LiveCVPreview extends StatelessWidget {
  final double scale;

  const LiveCVPreview({super.key, this.scale = 0.5});

  @override
  Widget build(BuildContext context) {
    return Consumer<CVProvider>(
      builder: (context, cvProvider, child) {
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 595, // A4 width in points
            height: 842, // A4 height in points
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Header
                    _buildPreviewHeader(cvProvider),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Summary
                          if (cvProvider.cv.personalInfo.summary.isNotEmpty)
                            _buildPreviewSection(
                              'Professional Summary',
                              Text(
                                cvProvider.cv.personalInfo.summary,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                  height: 1.5,
                                ),
                              ),
                            ),

                          // Experience
                          if (cvProvider.cv.experiences.isNotEmpty)
                            _buildPreviewSection(
                              'Work Experience',
                              Column(
                                children: cvProvider.cv.experiences
                                    .map((exp) => _buildExperiencePreview(exp))
                                    .toList(),
                              ),
                            ),

                          // Education
                          if (cvProvider.cv.educations.isNotEmpty)
                            _buildPreviewSection(
                              'Education',
                              Column(
                                children: cvProvider.cv.educations
                                    .map((edu) => _buildEducationPreview(edu))
                                    .toList(),
                              ),
                            ),

                          // Skills
                          if (cvProvider.cv.skills.isNotEmpty)
                            _buildPreviewSection(
                              'Skills',
                              _buildSkillsPreview(cvProvider.cv.skills),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().scale(duration: 800.ms, curve: Curves.easeOut),
        );
      },
    );
  }

  Widget _buildPreviewHeader(CVProvider cvProvider) {
    final personal = cvProvider.cv.personalInfo;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            personal.name.isEmpty ? 'Your Name' : personal.name,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Professional',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 12),

          // Contact info
          Wrap(
            spacing: 20,
            runSpacing: 4,
            children: [
              if (personal.email.isNotEmpty)
                _buildContactInfo(Icons.email, personal.email),
              if (personal.phone.isNotEmpty)
                _buildContactInfo(Icons.phone, personal.phone),
              if (personal.address.isNotEmpty)
                _buildContactInfo(Icons.location_on, personal.address),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Colors.white.withOpacity(0.8)),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewSection(String title, Widget content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            height: 2,
            width: 50,
            color: AppColors.primary,
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildExperiencePreview(dynamic exp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exp.position ?? 'Position',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            exp.company ?? 'Company',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
          Text(
            '${exp.startDate ?? 'Start'} - ${exp.endDate ?? 'Present'}',
            style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[600]),
          ),
          if (exp.description?.isNotEmpty == true) ...[
            const SizedBox(height: 4),
            Text(
              exp.description!,
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEducationPreview(dynamic edu) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            edu.degree ?? 'Degree',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            edu.institution ?? 'Institution',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary,
            ),
          ),
          Text(
            '${edu.startDate ?? 'Start'} - ${edu.endDate ?? 'Present'}',
            style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsPreview(List<dynamic> skills) {
    // Group by category
    final Map<SkillCategory, List<dynamic>> grouped = {};
    for (final skill in skills) {
      if (!grouped.containsKey(skill.category)) {
        grouped[skill.category] = [];
      }
      grouped[skill.category]!.add(skill);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: grouped.entries.map((entry) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getCategoryName(entry.key),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: entry.value.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(skill.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: _getCategoryColor(
                          skill.category,
                        ).withOpacity(0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      '${skill.name} (${skill.level}/5)',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: _getCategoryColor(skill.category),
                      ),
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

  String _getCategoryName(SkillCategory category) {
    switch (category) {
      case SkillCategory.technical:
        return 'Technical';
      case SkillCategory.language:
        return 'Languages';
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
