// lib/features/cv_builder/widgets/simple_template_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../config/themes/colors.dart';
import '../models/cv_template.dart';

class SimpleTemplateSelector extends StatefulWidget {
  final Function(CVTemplate) onTemplateSelected;

  const SimpleTemplateSelector({super.key, required this.onTemplateSelected});

  @override
  State<SimpleTemplateSelector> createState() => _SimpleTemplateSelectorState();
}

class _SimpleTemplateSelectorState extends State<SimpleTemplateSelector> {
  CVTemplate? _selectedTemplate;
  CVTemplateType _selectedType = CVTemplateType.modern;

  @override
  Widget build(BuildContext context) {
    final templates = CVTemplateData.getTemplatesByType(_selectedType);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Your Template',
                style: TextStyle(
                  fontFamily: 'System',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Gap(8.h),
              Text(
                'Select a professional design that matches your style',
                style: TextStyle(
                  fontFamily: 'System',
                  fontSize: 16.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),

        // Type Filter
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Wrap(
            spacing: 8.w,
            children: CVTemplateType.values.map((type) {
              final isSelected = _selectedType == type;
              return FilterChip(
                label: Text(
                  type.toString().split('.').last.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'System',
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedType = type;
                  });
                },
                backgroundColor: Colors.grey[200],
                selectedColor: AppColors.primary,
              );
            }).toList(),
          ),
        ),

        Gap(16.h),

        // Templates Grid
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final template = templates[index];
              final isSelected = _selectedTemplate?.id == template.id;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTemplate = template;
                  });
                  widget.onTemplateSelected(template);
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? AppColors.primary : Colors.grey[300]!,
                      width: isSelected ? 3 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Template Preview
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.description,
                                  size: 48.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                              if (template.isPremium)
                                Positioned(
                                  top: 8.h,
                                  right: 8.w,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                    child: Text(
                                      'PRO',
                                      style: TextStyle(
                                        fontFamily: 'System',
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                      // Template Info
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                template.name,
                                style: TextStyle(
                                  fontFamily: 'System',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(4.h),
                              Text(
                                template.description,
                                style: TextStyle(
                                  fontFamily: 'System',
                                  fontSize: 11.sp,
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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
        ),

        // Selected Template Info
        if (_selectedTemplate != null)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              border: Border(
                top: BorderSide(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.primary, size: 20.sp),
                Gap(8.w),
                Expanded(
                  child: Text(
                    'Selected: ${_selectedTemplate!.name}',
                    style: TextStyle(
                      fontFamily: 'System',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
