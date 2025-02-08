import 'package:domain/entities/alert_entity.dart';
import 'package:flutter/material.dart';

import 'package:running_app/utils/image_picker_service.dart';
import 'dart:typed_data';

class AddAlertDialog extends StatefulWidget {
  final Function(String title, String description, EAlertType type, Uint8List? image) onSave;

  const AddAlertDialog({super.key, required this.onSave});

  @override
  State<AddAlertDialog> createState() => _AddAlertDialogState();
}

class _AddAlertDialogState extends State<AddAlertDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  EAlertType? _selectedAlertType;
  Uint8List? _imageBytes;
  final ImagePickerService _imageCompressorService = ImagePickerService();

  Future<void> _pickImage() async {
    final Uint8List? compressedImage =
        await _imageCompressorService.pickAndCompressImage(minHeight: 400, minWidth: 1024);
    if (compressedImage != null) {
      setState(() {
        _imageBytes = compressedImage;
      });
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedAlertType != null) {
      widget.onSave(
        _titleController.text,
        _descriptionController.text,
        _selectedAlertType!,
        _imageBytes,
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Alert'),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<EAlertType>(
                value: _selectedAlertType,
                decoration: const InputDecoration(
                  labelText: 'Alert Type',
                  border: OutlineInputBorder(),
                ),
                items: EAlertType.values.map((EAlertType type) {
                  return DropdownMenuItem<EAlertType>(
                    value: type,
                    child: Text(
                      type.toFormattedString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(context).colorScheme.onSurface),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAlertType = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an alert type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Upload Image'),
              ),
              if (_imageBytes != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Image.memory(_imageBytes!, height: 100),
                ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Add Alert'),
        ),
      ],
    );
  }
}
