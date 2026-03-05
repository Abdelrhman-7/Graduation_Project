import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class QuickActionItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;

  const QuickActionItem({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: ColorsManager.purble.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: ColorsManager.purble, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: ColorsManager.black,
            ),
          ),
        ],
      ),
    );
  }
}
