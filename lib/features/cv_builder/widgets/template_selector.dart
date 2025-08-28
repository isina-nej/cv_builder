// lib/features/cv_builder/widgets/template_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import '../../../config/themes/colors.dart';
import '../../../core/providers/cv_provider.dart';
import '../models/cv_template.dart';

class TemplateSelector extends StatefulWidget {
  const TemplateSelector({super.key});

  @override
  State<TemplateSelector> createState() => _TemplateSelectorState();
}

class _TemplateSelectorState extends State<TemplateSelector>
    with TickerProviderStateMixin {
  CVTemplateType _selectedType = CVTemplateType.modern;
  CVTemplate? _selectedTemplate;
  bool _showPremiumOnly = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final templates = _showPremiumOnly
        ? CVTemplateData.getPremiumTemplates()
              .where((t) => t.type == _selectedType)
              .toList()
        : CVTemplateData.getTemplatesByType(_selectedType);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header Section
        _buildHeader(),
        Gap(24.h),

        // Filter Section
        _buildFilters(),
        Gap(24.h),

        // Templates Grid
        Expanded(child: _buildTemplatesGrid(templates)),

        // Selected Template Info
        if (_selectedTemplate != null) ...[
          Gap(16.h),
          _buildSelectedTemplateInfo(),
        ],
      ],
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animationController,
          child: SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(-0.3, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Curves.elasticOut,
                  ),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Template',
                  style: TextStyle(
                    fontFamily: 'System',
                    fontSize: 28.sp,
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
        );
      },
    );
  }

  Widget _buildFilters() {
    return Column(
      children: [
        // Template Type Filter
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: CVTemplateType.values.map((type) {
              final isSelected = type == _selectedType;
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child:
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedType = type;
                          _selectedTemplate = null;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 12.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? const LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    AppColors.secondary,
                                  ],
                                )
                              : null,
                          color: isSelected
                              ? null
                              : Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(25.r),
                          border: Border.all(
                            color: isSelected
                                ? Colors.transparent
                                : Colors.grey.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          _getTypeDisplayName(type),
                          style: TextStyle(
                            fontFamily: 'System',
                            fontSize: 14.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ).animate().scale(
                      delay: Duration(
                        milliseconds: CVTemplateType.values.indexOf(type) * 100,
                      ),
                      duration: 400.ms,
                      curve: Curves.elasticOut,
                    ),
              );
            }).toList(),
          ),
        ),

        Gap(16.h),

        // Premium Filter
        Row(
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _showPremiumOnly = !_showPremiumOnly;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: _showPremiumOnly
                      ? const LinearGradient(
                          colors: [Colors.amber, Colors.orange],
                        )
                      : null,
                  color: _showPremiumOnly
                      ? null
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: _showPremiumOnly
                        ? Colors.transparent
                        : Colors.grey.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16.sp,
                      color: _showPremiumOnly ? Colors.white : Colors.amber,
                    ),
                    Gap(6.w),
                    Text(
                      'Premium Only',
                      style: TextStyle(
                        fontFamily: 'System',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: _showPremiumOnly
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTemplatesGrid(List<CVTemplate> templates) {
    if (templates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64.sp,
              color: Colors.grey.withValues(alpha: 0.5),
            ),
            Gap(16.h),
            Text(
              'No templates found',
              style: TextStyle(
                fontFamily: 'System',
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return AnimationLimiter(
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _getCrossAxisCount(context),
          childAspectRatio: 0.75,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 16.h,
        ),
        itemCount: templates.length,
        itemBuilder: (context, index) {
          final template = templates[index];
          final isSelected = template.id == _selectedTemplate?.id;

          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 800),
            columnCount: _getCrossAxisCount(context),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildTemplateCard(template, isSelected, index),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTemplateCard(CVTemplate template, bool isSelected, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTemplate = template;
        });
        // Update the CV provider with the selected template
        context.read<CVProvider>().changeTemplate(template.id);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.grey.withValues(alpha: 0.2),
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: isSelected ? 20 : 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Template Preview
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      template.primaryColor.withValues(alpha: 0.1),
                      template.secondaryColor.withValues(alpha: 0.1),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Preview Area
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              template.primaryColor,
                              template.secondaryColor,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.description,
                            size: 40.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Template Info
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.1),
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
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
                                ),
                                if (template.isPremium)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 2.h,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [Colors.amber, Colors.orange],
                                      ),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'PRO',
                                      style: TextStyle(
                                        fontFamily: 'System',
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
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

              // Selection Indicator
              if (isSelected)
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, size: 16.sp, color: Colors.white),
                  ).animate().scale(duration: 300.ms, curve: Curves.elasticOut),
                ),
            ],
          ),
        ),
      ),
    ).animate().scale(
      delay: Duration(milliseconds: index * 50),
      duration: 600.ms,
      curve: Curves.elasticOut,
    );
  }

  Widget _buildSelectedTemplateInfo() {
    if (_selectedTemplate == null) return const SizedBox.shrink();

    return GlassContainer.clearGlass(
      height: 120.h,
      width: double.infinity,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: _selectedTemplate!.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                Gap(8.w),
                Expanded(
                  child: Text(
                    'Selected: ${_selectedTemplate!.name}',
                    style: TextStyle(
                      fontFamily: 'System',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (_selectedTemplate!.isPremium)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.amber, Colors.orange],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      'PREMIUM',
                      style: TextStyle(
                        fontFamily: 'System',
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Gap(8.h),
            Text(
              _selectedTemplate!.description,
              style: TextStyle(
                fontFamily: 'System',
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            Gap(8.h),
            Wrap(
              spacing: 8.w,
              children: _selectedTemplate!.features.take(4).map((feature) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _selectedTemplate!.primaryColor.withValues(
                      alpha: 0.1,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    _getFeatureDisplayName(feature),
                    style: TextStyle(
                      fontFamily: 'System',
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: _selectedTemplate!.primaryColor,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    ).animate().slideY(begin: 1, duration: 400.ms, curve: Curves.easeOut);
  }

  String _getTypeDisplayName(CVTemplateType type) {
    switch (type) {
      case CVTemplateType.modern:
        return 'Modern';
      case CVTemplateType.classic:
        return 'Classic';
      case CVTemplateType.creative:
        return 'Creative';
      case CVTemplateType.minimal:
        return 'Minimal';
      case CVTemplateType.professional:
        return 'Professional';
      case CVTemplateType.executive:
        return 'Executive';
    }
  }

  String _getFeatureDisplayName(CVTemplateFeature feature) {
    switch (feature) {
      case CVTemplateFeature.photoSupport:
        return 'Photo';
      case CVTemplateFeature.skillBars:
        return 'Skill Bars';
      case CVTemplateFeature.timeline:
        return 'Timeline';
      case CVTemplateFeature.charts:
        return 'Charts';
      case CVTemplateFeature.icons:
        return 'Icons';
      case CVTemplateFeature.customColors:
        return 'Custom Colors';
      case CVTemplateFeature.multiPage:
        return 'Multi-page';
      case CVTemplateFeature.portfolio:
        return 'Portfolio';
      case CVTemplateFeature.qrCode:
        return 'QR Code';
      case CVTemplateFeature.socialLinks:
        return 'Social Links';
    }
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}
