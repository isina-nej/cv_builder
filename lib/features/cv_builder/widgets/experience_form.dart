// lib/features/cv_builder/widgets/experience_form.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/cv_provider.dart';
import '../models/experience.dart';

class ExperienceForm extends StatefulWidget {
  const ExperienceForm({super.key});

  @override
  State<ExperienceForm> createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void _addExperience() {
    if (_formKey.currentState!.validate()) {
      final exp = Experience(
        title: titleController.text,
        company: companyController.text,
        startDate: startDateController.text,
        endDate: endDateController.text,
        description: descriptionController.text,
      );
      Provider.of<CVProvider>(context, listen: false).addExperience(exp);
      _clearFields();
    }
  }

  void _clearFields() {
    titleController.clear();
    companyController.clear();
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
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Job Title'),
            validator: (value) => value!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: companyController,
            decoration: const InputDecoration(labelText: 'Company'),
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
            onPressed: _addExperience,
            child: const Text('Add Experience'),
          ),
        ],
      ),
    );
  }
}