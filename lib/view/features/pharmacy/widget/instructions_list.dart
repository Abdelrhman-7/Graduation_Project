import 'package:flutter/material.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_state.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class InstructionsList extends StatelessWidget {
  final PharmacyLoaded state;

  const InstructionsList({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final instructions = state.prescription.instructions;
    
    // Ensure we have at least 4 items for the grid, using empty strings if needed
    final freq = instructions.isNotEmpty ? instructions[0] : 'N/A';
    final duration = instructions.length > 1 ? instructions[1] : 'N/A';
    final method = instructions.length > 2 ? instructions[2] : 'N/A';
    final note = instructions.length > 3 ? instructions[3] : 'N/A';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                _buildGridItem(
                  icon: Icons.access_time_rounded,
                  label: 'Frequency',
                  value: freq,
                ),
                const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFF1F1F1)),
                _buildGridItem(
                  icon: Icons.calendar_today_rounded,
                  label: 'Duration',
                  value: duration,
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
          IntrinsicHeight(
            child: Row(
              children: [
                _buildGridItem(
                  icon: Icons.medication_rounded,
                  label: 'Method',
                  value: method,
                ),
                const VerticalDivider(width: 1, thickness: 1, color: Color(0xFFF1F1F1)),
                _buildGridItem(
                  icon: Icons.info_outline_rounded,
                  label: 'Note',
                  value: note,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: ColorsManager.purble),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorsManager.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: ColorsManager.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
