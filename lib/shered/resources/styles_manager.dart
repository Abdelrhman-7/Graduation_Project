import 'package:flutter/material.dart';

class StylesManager {
  static InputDecoration inputDecoration({
    required String hint,
    Color? fillColor,
    Color? borderColor,
  }) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: fillColor ?? Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: borderColor ?? Colors.grey.shade200),
      ),
    );
  }
}
