import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class LabReportCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final String date;
  final String buttonText;
  final IconData? buttonIcon;
  final bool isBordered;
  final VoidCallback? onPressed;

  const LabReportCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.date,
    required this.buttonText,
    this.buttonIcon,
    required this.isBordered,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.black,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined,
                  size: 13, color: ColorsManager.lightGray),
              const SizedBox(width: 4),
              Text(
                date,
                style: const TextStyle(
                  fontSize: 12,
                  color: ColorsManager.lightGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          CustomButton(
            text: buttonText,
            onPressed: onPressed ?? () {},
            backgroundColor:
                isBordered ? Colors.white : ColorsManager.purble,
            textColor: isBordered ? ColorsManager.purble : Colors.white,
            height: 42,
            borderRadius: 12,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            side: isBordered
                ? const BorderSide(color: ColorsManager.purble, width: 1.5)
                : null,
            icon: buttonIcon != null
                ? Icon(buttonIcon,
                    color:
                        isBordered ? ColorsManager.purble : Colors.white,
                    size: 16)
                : null,
          ),
        ],
      ),
    );
  }
}
