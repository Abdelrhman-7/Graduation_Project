import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';
import 'package:graduation_project/view/features/home/widget/home_section_header.dart';
import 'package:graduation_project/view/features/lab_results/widget/detailed_results_card.dart';
import 'package:graduation_project/view/features/lab_results/widget/hemoglobin_trend_card.dart';
import 'package:graduation_project/view/features/lab_results/widget/lab_report_card.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: ColorsManager.black,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Lab Results',
          style: TextStyle(
            color: ColorsManager.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.tune_rounded,
                color: ColorsManager.purble,
                size: 22,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hemoglobin Trend Card ─────────────────────────────
            const HemoglobinTrendCard(),
            const SizedBox(height: 24),

            // ── Latest Reports ────────────────────────────────────
            HomeSectionHeader(
              title: 'Latest Reports',
              actionLabel: 'See All',
              onActionTap: () {},
            ),
            const SizedBox(height: 12),
            LabReportCard(
              title: 'Complete Blood Count (CBC)',
              status: 'NORMAL',
              statusColor: ColorsManager.iconGreen,
              statusBg: ColorsManager.lightGreen,
              date: 'Oct 14, 2025',
              buttonText: 'Download PDF',
              buttonIcon: Icons.download_rounded,
              isBordered: false,
            ),
            const SizedBox(height: 12),
            LabReportCard(
              title: 'Lipid Profile',
              status: 'ATTENTION REQUIRED',
              statusColor: ColorsManager.iconOrange,
              statusBg: ColorsManager.lightOrange,
              date: 'Sep 15, 2025',
              buttonText: 'View Details',
              isBordered: true,
            ),
            const SizedBox(height: 24),

            // ── Detailed Results ──────────────────────────────────
            const HomeSectionHeader(title: 'Detailed Results'),
            const SizedBox(height: 12),
            const DetailedResultsCard(),
            const SizedBox(height: 28),

            // ── Consult Doctor Button ─────────────────────────────
            CustomButton(
              text: 'Consult Doctor',
              onPressed: () {
                Navigator.of(context).pushNamed(RoutManager.chat);
              },
              backgroundColor: ColorsManager.purble,
              textColor: Colors.white,
              height: 56,
              borderRadius: 16,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              icon: const Icon(
                Icons.phone_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
