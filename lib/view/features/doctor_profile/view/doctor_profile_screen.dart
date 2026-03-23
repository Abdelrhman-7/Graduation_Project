import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import '../../../../../shered_widgites/resources/colors_manager.dart';
import '../widget/profile_top_section.dart';
import '../widget/up_next_appointment_card.dart';
import '../widget/quick_actions_grid.dart';
import '../widget/patient_requests_list.dart';
import '../widget/today_schedule_list.dart';
import '../../home/widget/notifications_drawer.dart';
import '../../../../../models/model/shered_pref_controller/shered_pref_controler.dart';
import '../../../../../shered_widgites/routes_manager.dart';
import '../../../../../shered_widgites/custom_bouttm/custom_button.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.pastelBackground,
      endDrawer: const NotificationsDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileTopSection(),
              const SizedBox(height: 24),
              const UpNextAppointmentCard(),
              const SizedBox(height: 24),
              const QuickActionsGrid(),
              const SizedBox(height: 24),
              const PatientRequestsList(),
              const SizedBox(height: 24),
              const TodayScheduleList(),
              const SizedBox(height: 32),

              const CustomText(
                text: 'Settings',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsManager.black,
              ),
              const SizedBox(height: 16),
              _buildSettingsItem(
                icon: Icons.edit_calendar_rounded,
                title: 'Manage Availability',
                onTap: () {
                  Navigator.pushNamed(context, RoutManager.manageAvailability);
                },
              ),
              const SizedBox(height: 32),

              // ── Logout Button ─────────────────────────────────────
              CustomButton(
                text: 'Logout',
                onPressed: () {
                  SharedPrefController().logout();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutManager.login,
                    (route) => false,
                  );
                },
                backgroundColor: ColorsManager.primaryBlue,
                textColor: Colors.white,
                height: 56,
                borderRadius: 16,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                icon: const Icon(
                  Icons.logout_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: ColorsManager.primaryBlue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: ColorsManager.primaryBlue, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: ColorsManager.black,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: ColorsManager.lightGray,
        size: 16,
      ),
    );
  }
}
