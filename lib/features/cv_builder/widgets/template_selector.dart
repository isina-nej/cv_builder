// lib/features/cv_builder/widgets/template_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cv_provider.dart';
import '../../../core/utils/constants.dart';

class TemplateSelector extends StatelessWidget {
  const TemplateSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final cvProvider = Provider.of<CVProvider>(context);

    return DropdownButton<String>(
      value: cvProvider.cv.template,
      items: [
        DropdownMenuItem(value: CVTemplates.modern, child: const Text('Modern')),
        DropdownMenuItem(value: CVTemplates.classic, child: const Text('Classic')),
        DropdownMenuItem(value: CVTemplates.creative, child: const Text('Creative')),
      ],
      onChanged: (value) {
        if (value != null) {
          cvProvider.changeTemplate(value);
        }
      },
    );
  }
}