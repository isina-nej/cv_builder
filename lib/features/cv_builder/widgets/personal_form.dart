// lib/features/cv_builder/widgets/personal_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cv_provider.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/cross_platform_image.dart';
import '../models/personal_info.dart';
import 'package:file_picker/file_picker.dart'; // Assume added dependency

class PersonalForm extends StatefulWidget {
  const PersonalForm({super.key});

  @override
  State<PersonalForm> createState() => _PersonalFormState();
}

class _PersonalFormState extends State<PersonalForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController summaryController;
  String? photoPath;

  @override
  void initState() {
    super.initState();
    final cv = Provider.of<CVProvider>(context, listen: false).cv;
    nameController = TextEditingController(text: cv.personalInfo.name);
    emailController = TextEditingController(text: cv.personalInfo.email);
    phoneController = TextEditingController(text: cv.personalInfo.phone);
    addressController = TextEditingController(text: cv.personalInfo.address);
    summaryController = TextEditingController(text: cv.personalInfo.summary);
    photoPath = cv.personalInfo.photoPath;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    summaryController.dispose();
    super.dispose();
  }

  void _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        photoPath = result.files.single.path;
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final info = PersonalInfo(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
        summary: summaryController.text,
        photoPath: photoPath,
      );
      Provider.of<CVProvider>(context, listen: false).updatePersonalInfo(info);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: Validators.validateName,
          ),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: Validators.validateEmail,
          ),
          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
            validator: Validators.validatePhone,
          ),
          TextFormField(
            controller: addressController,
            decoration: const InputDecoration(labelText: 'Address'),
          ),
          TextFormField(
            controller: summaryController,
            decoration: const InputDecoration(labelText: 'Summary'),
            maxLines: 3,
          ),
          ElevatedButton(
            onPressed: _pickPhoto,
            child: const Text('Upload Photo'),
          ),
          CrossPlatformImage(imagePath: photoPath, height: 100),
          ElevatedButton(
            onPressed: _save,
            child: const Text('Save Personal Info'),
          ),
        ],
      ),
    );
  }
}
