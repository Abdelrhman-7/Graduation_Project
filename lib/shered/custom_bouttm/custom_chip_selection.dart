import 'package:flutter/material.dart';

class CustomChipSelection extends StatelessWidget {
  final List<String> options;
  final List<String> selectedList;
  final Function(String, bool) onSelected;
  final Color selectedColor;
  final Color checkmarkColor;

  const CustomChipSelection({
    super.key,
    required this.options,
    required this.selectedList,
    required this.onSelected,
    this.selectedColor = const Color(0xFFF3E5F5),
    this.checkmarkColor = const Color(0xFFBC00FF),
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((option) {
        final isSelected = selectedList.contains(option);
        return FilterChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (selected) => onSelected(option, selected),
          selectedColor: selectedColor,
          checkmarkColor: checkmarkColor,
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected ? checkmarkColor : Colors.grey.shade300,
            ),
          ),
        );
      }).toList(),
    );
  }
}
