import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class MedicationCard extends StatelessWidget {
  final String name;
  final String dose;
  final String timesPerDay;
  final VoidCallback? onTap;

  const MedicationCard({
    super.key,
    required this.name,
    required this.dose,
    required this.timesPerDay,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: ColorsManager.purble.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.medication,
              color: ColorsManager.purble,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$dose · $timesPerDay",
                  style: const TextStyle(
                    color: ColorsManager.lightGray,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              color: ColorsManager.lightGray,
            ),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
