import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:graduation_project/shered/resources/styles_manager.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool isDateField;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.inputFormatters,
    this.suffixText,
    this.controller,
    this.prefixIcon,
    this.isDateField = false,
    this.initialDate,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          readOnly: isDateField,
          onTap: isDateField
              ? () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: initialDate ?? DateTime.now(),
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: lastDate ?? DateTime(2100),
                  );
                  if (picked != null && controller != null) {
                    controller!.text = DateFormat('yyyy-MM-dd').format(picked);
                  }
                }
              : null,
          decoration:
              StylesManager.inputDecoration(
                hint: hint,
                fillColor: Colors.white,
                borderColor: Colors.grey.shade300,
              ).copyWith(
                suffixText: suffixText,
                suffixStyle: suffixText != null
                    ? const TextStyle(color: Colors.grey)
                    : null,
                prefixIcon:
                    prefixIcon ??
                    (isDateField
                        ? const Icon(Icons.calendar_month, color: Colors.grey)
                        : null),
              ),
        ),
      ],
    );
  }
}
