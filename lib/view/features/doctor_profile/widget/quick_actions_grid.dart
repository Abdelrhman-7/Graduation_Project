import 'package:flutter/material.dart';
import '../../../../shered_widgites/custom_text/custom_text.dart';
import '../../../../shered_widgites/resources/colors_manager.dart';
import 'quick_action_card.dart';

class QuickActionsGrid extends StatelessWidget {
  const QuickActionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Quick Actions',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorsManager.black,
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: [
            QuickActionCard(
              icon: Icons.edit_document,
              label: 'Write Note',
              iconColor: ColorsManager.primaryBlue,
              backgroundColor: ColorsManager.lightBlue,
              onTap: () {},
            ),
            QuickActionCard(
              icon: Icons.medical_services_outlined,
              label: 'e-Prescribe',
              iconColor: ColorsManager.iconPurple,
              backgroundColor: ColorsManager.lightPurple,
              onTap: () {},
            ),
            QuickActionCard(
              icon: Icons.science_outlined,
              label: 'Lab Results',
              iconColor: ColorsManager.iconGreen,
              backgroundColor: ColorsManager.lightGreen,
              onTap: () {},
            ),
            QuickActionCard(
              icon: Icons.assignment_turned_in_outlined,
              label: 'Referrals',
              iconColor: ColorsManager.iconOrange,
              backgroundColor: ColorsManager.lightOrange,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
