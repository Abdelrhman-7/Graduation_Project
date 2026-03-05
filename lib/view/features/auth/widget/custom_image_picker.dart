import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/string/app_string.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final String title;
  final String subtitle;
  final Function(File) onImageSelected;

  const CustomImagePicker({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onImageSelected,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  File? _selectedImage;
  String? _webImagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      if (mounted) {
        setState(() {
          _selectedImage = File(image.path);
          _webImagePath = image.path;
        });
        widget.onImageSelected(_selectedImage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F9FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.blue.shade100,
            style: BorderStyle.solid,
          ),
        ),
        child: _selectedImage != null
            ? Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: kIsWeb
                        ? Image.network(
                            _webImagePath!,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _selectedImage!,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    AppString.changeDocument,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.blue.shade600,
                    child: const Icon(
                      Icons.file_upload_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
      ),
    );
  }
}
