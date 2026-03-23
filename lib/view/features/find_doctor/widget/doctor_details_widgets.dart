import 'package:flutter/material.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_state.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class DoctorStatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color baseColor;

  const DoctorStatItem({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.baseColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: baseColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: baseColor, size: 24),
        ),
        const SizedBox(height: 8),
        CustomText(
          text: value,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: ColorsManager.black,
        ),
        const SizedBox(height: 4),
        CustomText(text: label, fontSize: 12, color: ColorsManager.lightGray),
      ],
    );
  }
}

class DoctorInfoSection extends StatelessWidget {
  final String title;
  final String content;

  const DoctorInfoSection({
    super.key,
    required this.title,
    required this.content,
    required PharmacyLoaded state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorsManager.black,
        ),
        const SizedBox(height: 12),
        CustomText(text: content, fontSize: 15, color: ColorsManager.lightGray),
      ],
    );
  }
}
