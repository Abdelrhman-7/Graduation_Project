import 'package:flutter/material.dart';

import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';
import 'package:graduation_project/view/features/doctor_profile/view/doctor_profile_screen.dart';
import 'package:graduation_project/view/features/doctor_dashboard/view/today_schedule_screen.dart';
import 'package:graduation_project/view/patient/features/patient_home/widget/appointment_card.dart';
import 'package:graduation_project/view/patient/features/patient_home/widget/home_app_bar.dart';
import 'package:graduation_project/view/patient/features/patient_home/widget/home_bottom_nav_bar.dart';
import 'package:graduation_project/view/patient/features/patient_home/widget/home_section_header.dart';
import 'package:graduation_project/view/patient/features/patient_home/widget/medication_card.dart';
import 'package:graduation_project/view/patient/features/patient_home/widget/notifications_drawer.dart';
import 'package:graduation_project/view/patient/features/patient_home/widget/quick_action_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  String userName = "";
  final String userRole = "Patient"; // Updated from Doctor to Patient
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

  final List<Map<String, dynamic>> _medications = [
    {
      "name": "Amoxicillin",
      "dose": "500mg",
      "times": "1 pill/day",
      "status": "ACTIVE",
      "statusColor": Colors.green,
    },
    {
      "name": "Lisinopril",
      "dose": "10mg",
      "times": "1 pill/day",
      "status": "REFILL",
      "statusColor": Colors.blue,
    },
  ];

  final List<Map<String, dynamic>> _quickActions = [
    {
      "label": "Book",
      "icon": Icons.calendar_month_outlined,
      "color": Colors.blue,
    },
    {
      "label": "Refill",
      "icon": Icons.medication_outlined,
      "color": Colors.orange,
    },
    {"label": "Chat", "icon": Icons.chat_bubble_outline, "color": Colors.green},
    {"label": "Labs", "icon": Icons.biotech_outlined, "color": Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeTab(context),
      const TodayScheduleScreen(),
      _buildMyHealthTab(context),
      const DoctorProfileScreen(),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: _currentIndex == 0
          ? HomeAppBar(
              userName: userName,
              userRole: userRole,
              isOnline: isOnline,
              onNotificationTap: () =>
                  _scaffoldKey.currentState?.openEndDrawer(),
              onProfileTap: () => setState(() => _currentIndex = 3),
            )
          : null,
      endDrawer: const NotificationsDrawer(),
      body: IndexedStack(index: _currentIndex, children: pages),
      bottomNavigationBar: HomeBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
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
            actionLabel: "See All",
            onActionTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            child: const AppointmentCard(
              doctorName: "Dr. Mohamed Ahmed",
              specialty: "Cardiologist",
              date: "Mon, 17 Mar 2026",
              time: "10:00 AM",
            ),
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
                iconColor: action["color"] as Color,
                onTap: () {
                  if (label == "Book") {
                    Navigator.of(context).pushNamed(RoutManager.findDoctor);
                  } else if (label == "Refill") {
                    Navigator.of(
                      context,
                    ).pushNamed(RoutManager.digitalPrescription);
                  } else if (label == "Labs") {
                    Navigator.of(context).pushNamed(RoutManager.labResults);
                  } else if (label == "Chat") {
                    Navigator.of(context).pushNamed(RoutManager.chat);
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
              name: med["name"] as String,
              dose: med["dose"] as String,
              timesPerDay: med["times"] as String,
              status: med["status"] as String,
              statusColor: med["statusColor"] as Color,
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(RoutManager.medicationRefill, arguments: med);
              },
            ),
          ),
          const SizedBox(height: 16),

          // Health Stats
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  "Heart Rate",
                  "72 bpm",
                  Icons.favorite,
                  Colors.red,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  "Blood Type",
                  "O+",
                  Icons.water_drop,
                  Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMyHealthTab(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeSectionHeader(title: "Health Metrics"),
          const SizedBox(height: 16),
          // Metrics Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.5,
            children: [
              _buildMetricCard(
                "Heart Rate",
                "72 bpm",
                Icons.favorite_rounded,
                Colors.red,
              ),
              _buildMetricCard(
                "Blood Pressure",
                "120/80",
                Icons.speed_rounded,
                Colors.blue,
              ),
              _buildMetricCard(
                "Steps",
                "8,432",
                Icons.directions_walk_rounded,
                Colors.green,
              ),
              _buildMetricCard(
                "Sleep",
                "7h 20m",
                Icons.nights_stay_rounded,
                Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const HomeSectionHeader(title: "Activity Summary"),
          const SizedBox(height: 12),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActivityBar("Mon", 0.4),
                _buildActivityBar("Tue", 0.7),
                _buildActivityBar("Wed", 0.9),
                _buildActivityBar("Thu", 0.5),
                _buildActivityBar("Fri", 0.8),
                _buildActivityBar("Sat", 0.3),
                _buildActivityBar("Sun", 0.6),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildActivityBar(String day, double heightFactor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 80 * heightFactor,
          width: 12,
          decoration: BoxDecoration(
            color: ColorsManager.primaryBlue,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
