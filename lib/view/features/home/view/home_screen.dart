import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/test_api_cubit.dart';
import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';
import 'package:graduation_project/view/features/home/widget/appointment_card.dart';
import 'package:graduation_project/view/features/home/widget/home_app_bar.dart';
import 'package:graduation_project/view/features/home/widget/home_bottom_nav_bar.dart';
import 'package:graduation_project/view/features/home/widget/home_section_header.dart';
import 'package:graduation_project/view/features/home/widget/medication_card.dart';
import 'package:graduation_project/view/features/home/widget/quick_action_item.dart';
import 'package:graduation_project/view/features/doctor_profile/view/doctor_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  String userName = "";
  final String userRole = "Doctor"; // or "Patient"
  final bool isOnline = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final email = await SharedPrefController().getEmail();
    if (email != null && email.contains('@')) {
      setState(() {
        userName = email.split('@').first;
      });
    }
  }

  final List<Map<String, String>> _medications = [
    {"name": "Aspirin", "dose": "100mg", "times": "1x per day"},
    {"name": "Metformin", "dose": "500mg", "times": "2x per day"},
    {"name": "Lisinopril", "dose": "10mg", "times": "1x per day"},
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {"label": "Book", "icon": Icons.calendar_month_outlined},
    {"label": "Refill", "icon": Icons.medication_outlined},
    {"label": "Chat", "icon": Icons.chat_bubble_outline},
    {"label": "Labs", "icon": Icons.biotech_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeTab(context),
      const Center(child: Text('Schedule (Coming Soon)')),
      const Center(child: Text('My Health (Coming Soon)')),
      const DoctorProfileScreen(),
    ];

    return BlocListener<TestApiCubit, TestApiState>(
      listener: (context, state) {
        if (state is TestApiError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FF),
        appBar: _currentIndex == 0
            ? HomeAppBar(
                userName: userName,
                userRole: userRole,
                isOnline: isOnline,
                onNotificationTap: () {},
              )
            : null,
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
        bottomNavigationBar: HomeBottomNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }

  Widget _buildHomeTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Next Appointment
          HomeSectionHeader(
            title: "Next Appointment",
            actionLabel: "See more",
            onActionTap: () {},
          ),
          const SizedBox(height: 12),
          AppointmentCard(
            doctorName: userName,
            specialty: "Cardiologist",
            date: "Mon, 17 Mar 2026",
            time: "10:00 AM",
          ),
          const SizedBox(height: 24),

          // Quick Actions
          const HomeSectionHeader(title: "Quick Actions"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _quickActions.map((action) {
              final label = action["label"] as String;
              return QuickActionItem(
                label: label,
                icon: action["icon"] as IconData,
                onTap: () {
                  if (label == "Book") {
                    Navigator.of(context).pushNamed(RoutManager.findDoctor);
                  } else if (label == "Refill") {
                    Navigator.of(
                      context,
                    ).pushNamed(RoutManager.digitalPrescription);
                  }
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Current Medications
          const HomeSectionHeader(title: "Current Medications"),
          const SizedBox(height: 12),
          ..._medications.map(
            (med) => MedicationCard(
              name: med["name"]!,
              dose: med["dose"]!,
              timesPerDay: med["times"]!,
              onTap: () {},
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
