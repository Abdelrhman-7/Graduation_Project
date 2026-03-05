import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

/// A specialty filter chip used in the horizontal list on FindDoctorScreen.
/// Has a border stroke, an icon, and a label. Highlights when selected.
class SpecialtyFilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SpecialtyFilterChip({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.purble : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? ColorsManager.purble : const Color(0xFFDDDDDD),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: ColorsManager.purble.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? Colors.white : ColorsManager.purble,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : ColorsManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
