// Script to create folders and files in lib
import 'dart:io';

void main() {
  // Create directories
  Directory('lib/config/themes').createSync(recursive: true);
  Directory('lib/config/l10n').createSync(recursive: true);
  Directory('lib/config/routes').createSync(recursive: true);
  Directory('lib/core/providers').createSync(recursive: true);
  Directory('lib/core/utils').createSync(recursive: true);
  Directory('lib/features/cv_builder/models').createSync(recursive: true);
  Directory('lib/features/cv_builder/widgets').createSync(recursive: true);
  Directory('lib/features/cv_builder/screens').createSync(recursive: true);
  Directory('lib/services').createSync(recursive: true);

  // Create files
  File('lib/main.dart').createSync();
  File('lib/app.dart').createSync();
  File('lib/config/themes/app_colors.dart').createSync();
  File('lib/config/themes/app_themes.dart').createSync();
  File('lib/config/themes/text_styles.dart').createSync();
  File('lib/config/l10n/l10n.dart').createSync();
  File('lib/config/routes/app_router.dart').createSync();
  File('lib/core/providers/theme_provider.dart').createSync();
  File('lib/core/providers/locale_provider.dart').createSync();
  File('lib/core/providers/cv_provider.dart').createSync();
  File('lib/core/utils/validators.dart').createSync();
  File('lib/core/utils/constants.dart').createSync();
  File('lib/features/cv_builder/models/cv_model.dart').createSync();
  File('lib/features/cv_builder/models/personal_info.dart').createSync();
  File('lib/features/cv_builder/models/education.dart').createSync();
  File('lib/features/cv_builder/models/experience.dart').createSync();
  File('lib/features/cv_builder/models/skill.dart').createSync();
  File('lib/features/cv_builder/widgets/personal_form.dart').createSync();
  File('lib/features/cv_builder/widgets/education_form.dart').createSync();
  File('lib/features/cv_builder/widgets/experience_form.dart').createSync();
  File('lib/features/cv_builder/widgets/skill_form.dart').createSync();
  File('lib/features/cv_builder/widgets/cv_preview.dart').createSync();
  File('lib/features/cv_builder/widgets/template_selector.dart').createSync();
  File('lib/features/cv_builder/screens/builder_screen.dart').createSync();
  File('lib/features/cv_builder/screens/preview_screen.dart').createSync();
  File('lib/features/cv_builder/screens/edit_screen.dart').createSync();
  File('lib/services/export_service.dart').createSync();
  File('lib/services/pdf_exporter.dart').createSync();
  File('lib/services/docx_exporter.dart').createSync();
  File('lib/services/html_exporter.dart').createSync();

  print('Folders and files created successfully in lib.');
}