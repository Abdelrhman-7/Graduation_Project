import 'package:flutter/material.dart';
import '../../../../shered_widgites/resources/colors_manager.dart';

class TodayScheduleList extends StatelessWidget {
  const TodayScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Today\'s Schedule',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsManager.black,
          ),
        ),
        const SizedBox(height: 16),
        _buildScheduleItem(
          time: '10:30 AM',
          patientName: 'Mark Doe',
          type: 'General Checkup',
          iconColor: ColorsManager.primaryBlue,
          backgroundColor: ColorsManager.lightBlue,
        ),
        const SizedBox(height: 12),
        _buildScheduleItem(
          time: '11:15 AM',
          patientName: 'Emily Zhang',
          type: 'Vaccination',
          iconColor: ColorsManager.iconGreen,
          backgroundColor: ColorsManager.lightGreen,
        ),
        const SizedBox(height: 12),
        _buildScheduleItem(
          time: '01:00 PM',
          patientName: 'Lunch Break',
          type: 'No appointments',
          iconColor: ColorsManager.iconOrange,
          backgroundColor: ColorsManager.lightOrange,
          isBreak: true,
        ),
      ],
    );
  }

  Widget _buildScheduleItem({
    required String time,
    required String patientName,
    required String type,
    required Color iconColor,
    required Color backgroundColor,
    bool isBreak = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  time.split(' ')[0], // Time
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                Text(
                  time.split(' ')[1], // AM/PM
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: iconColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patientName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isBreak ? ColorsManager.gray : ColorsManager.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.lightGray,
                  ),
                ),
              ],
            ),
          ),
          if (!isBreak)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorsManager.pastelBackground,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: ColorsManager.primaryBlue,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }
}
