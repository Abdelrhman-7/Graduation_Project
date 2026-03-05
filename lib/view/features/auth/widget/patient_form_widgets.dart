import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/styles_manager.dart';

class PatientFormWidgets {
  static Widget buildChipsSelection(
    List<String> options,
    List<String> selectedList,
    Function(String, bool) onSelected,
  ) {
    return Wrap(
      spacing: 8,
      children: options.map((option) {
        final isSelected = selectedList.contains(option);
        return FilterChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (selected) => onSelected(option, selected),
          selectedColor: const Color(0xFFF3E5F5),
          checkmarkColor: const Color(0xFFBC00FF),
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected
                  ? const Color(0xFFBC00FF)
                  : Colors.grey.shade300,
            ),
          ),
        );
      }).toList(),
    );
  }

  static Widget buildPrivacySwitch(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: const Color(0xFFBC00FF),
          ),
        ],
      ),
    );
  }

  static Widget buildProgressIndicator(
    int currentPage,
    int totalPages,
    String stepText,
    String ofText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$stepText ${currentPage + 1} $ofText',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                '${((currentPage + 1) / totalPages * 100).toInt()}%',
                style: const TextStyle(
                  color: Color(0xFFBC00FF),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: (currentPage + 1) / totalPages,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFFBC00FF),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  static Widget buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    ),
  );

  // A better buildDateField that takes onTap
  static Widget buildDateFieldWithAction(
    TextEditingController controller,
    VoidCallback onTap,
  ) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      decoration: StylesManager.inputDecoration(hint: 'yyyy-MM-dd').copyWith(
        prefixIcon: const Icon(Icons.calendar_month, color: Colors.grey),
      ),
    );
  }
}
