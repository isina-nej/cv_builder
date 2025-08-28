// lib/features/cv_builder/widgets/step_indicator.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../screens/builder_screen.dart';

class StepIndicator extends StatelessWidget {
  final List<BuilderStep> steps;
  final int currentStep;
  final Function(int)? onStepTapped;

  const StepIndicator({
    super.key,
    required this.steps,
    required this.currentStep,
    this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Step titles and icons row
        Row(
          children: steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isActive = index == currentStep;
            final isCompleted = index < currentStep;

            return Expanded(
              child: GestureDetector(
                onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
                child: Column(
                  children: [
                    // Icon container
                    Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? theme.colorScheme.primary
                                : isActive
                                ? theme.colorScheme.primaryContainer
                                : theme.colorScheme.surfaceVariant,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isActive
                                  ? theme.colorScheme.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            isCompleted ? Icons.check : step.icon,
                            color: isCompleted
                                ? theme.colorScheme.onPrimary
                                : isActive
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                            size: 24.sp,
                          ),
                        )
                        .animate(target: isActive ? 1 : 0)
                        .scale(
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.1, 1.1),
                          duration: 300.ms,
                        ),

                    Gap(8.h),

                    // Step title
                    Text(
                      step.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'System',
                        fontSize: 12.sp,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: isActive
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),

        Gap(16.h),

        // Progress bar
        Container(
          height: 4.h,
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final progress = (currentStep + 1) / steps.length;
              return Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: constraints.maxWidth * progress,
                  height: 4.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              );
            },
          ),
        ),

        Gap(8.h),

        // Current step description
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            steps[currentStep].description,
            key: ValueKey(currentStep),
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'System',
              fontSize: 14.sp,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}
