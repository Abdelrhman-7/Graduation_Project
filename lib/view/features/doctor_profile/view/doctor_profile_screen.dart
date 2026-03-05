import 'package:flutter/material.dart';
import '../../../../shered_widgites/resources/colors_manager.dart';
import '../widget/profile_top_section.dart';
import '../widget/up_next_appointment_card.dart';
import '../widget/quick_actions_grid.dart';
import '../widget/patient_requests_list.dart';
import '../widget/today_schedule_list.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.pastelBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.pastelBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: ColorsManager.black,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ProfileTopSection(),
              SizedBox(height: 24),
              UpNextAppointmentCard(),
              SizedBox(height: 24),
              QuickActionsGrid(),
              SizedBox(height: 24),
              PatientRequestsList(),
              SizedBox(height: 24),
              TodayScheduleList(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
