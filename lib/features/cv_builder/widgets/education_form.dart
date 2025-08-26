// lib/features/cv_builder/widgets/education_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cv_provider.dart';
import '../models/education.dart';

class EducationForm extends StatefulWidget {
  const EducationForm({super.key});

  @override
  State<EducationForm> createState() => _EducationFormState();
}

class _EducationFormState extends State<EducationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController institutionController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _addEducation() {
    if (_formKey.currentState!.validate()) {
      final edu = Education(
        degree: degreeController.text,
        institution: institutionController.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
        description: descriptionController.text,
      );
      Provider.of<CVProvider>(context, listen: false).addEducation(edu);
      _clearFields();
    }
  }

  void _clearFields() {
    degreeController.clear();
    institutionController.clear();
    startDateController.clear();
    endDateController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: degreeController,
            decoration: const InputDecoration(labelText: 'Degree'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: institutionController,
            decoration: const InputDecoration(labelText: 'Institution'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: startDateController,
            decoration: const InputDecoration(labelText: 'Start Date'),
          ),
          TextFormField(
            controller: endDateController,
            decoration: const InputDecoration(labelText: 'End Date'),
          ),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
          ),
          ElevatedButton(
            onPressed: _addEducation,
            child: const Text('Add Education'),
          ),
        ],
      ),
    );
  }
}