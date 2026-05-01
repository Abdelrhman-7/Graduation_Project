import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/view/patient/features/consultation/widget/consultation_patient_card.dart';
import 'package:graduation_project/view/patient/features/consultation/widget/medical_history_item_card.dart';
import 'package:graduation_project/view/patient/features/consultation/widget/reason_for_visit_card.dart';
import 'package:graduation_project/view/patient/features/consultation/widget/section_header.dart';
import 'package:graduation_project/view/patient/features/consultation/widget/vital_card.dart';

class ConsultationOverviewScreen extends StatelessWidget {
  const ConsultationOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const CustomText(
          text: "Consultation #4092",
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.visibility_outlined, color: Colors.black87),
            tooltip: 'Reveal encrypted medical history',
            onPressed: () {},
          ),
          SizedBox(width: 4.w),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            const ConsultationPatientCard(),
            const SectionHeader(title: "Reason for Visit"),
            const ReasonForVisitCard(),
            const SectionHeader(
              title: "Recent Vitals",
              trailingText: "Recorded 15m ago",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                VitalCard(
                  icon: Icons.favorite_outline,
                  label: "BP",
                  value: "120/80",
                  footer: "Normal",
                  footerColor: Colors.green,
                ),
                VitalCard(
                  icon: Icons.timer_outlined,
                  label: "HR",
                  value: "78",
                  footer: "bpm",
                ),
                VitalCard(
                  icon: Icons.thermostat_outlined,
                  label: "Temp",
                  value: "98.6°",
                  footer: "Fahrenheit",
                ),
              ],
            ),
            const SectionHeader(
              title: "Medical History (Secure)",
              icon: Icons.lock_outline,
            ),
            const MedicalHistoryItemCard(
              title: "Allergies",
              subtitle: "Severe Penicillin Allergy",
            ),
            const MedicalHistoryItemCard(
              title: "Chronic Conditions",
              subtitle: "Mild Asthma (Diagnosed 2018)",
            ),
            const MedicalHistoryItemCard(
              title: "Past Surgeries",
              subtitle: "Appendectomy (2015)",
            ),
            SizedBox(height: 16.h),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: const CustomText(
                  text: "Data is encrypted. Tap eye icon above to reveal all.",
                  fontSize: 11,
                  color: Colors.grey,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 120.h),
          ],
        ),
      ),
      bottomSheet: _buildBottomActions(),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 54.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: const CustomText(
                  text: "Prescribe",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 54.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4FACFE), Color(0xFF007BFF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF007BFF).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const CustomText(
                  text: "Start Video Call",
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
