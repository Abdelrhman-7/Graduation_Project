import 'package:flutter/material.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import '../widget/today_schedule_widgets.dart';

class TodayScheduleScreen extends StatefulWidget {
  const TodayScheduleScreen({super.key});

  @override
  State<TodayScheduleScreen> createState() => _TodayScheduleScreenState();
}

class _TodayScheduleScreenState extends State<TodayScheduleScreen> {
  int _activeTabIndex = 0; // 0: Day, 1: Week, 2: Month

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tabs
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _buildTab('Day', _activeTabIndex == 0, 0),
                    _buildTab('Week', _activeTabIndex == 1, 1),
                    _buildTab('Month', _activeTabIndex == 2, 2),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Content based on tab
              if (_activeTabIndex == 0) ...[
                // Stats Cards
                const Row(
                  children: [
                    StatsCard(
                      count: '5',
                      label: 'Remaining',
                      color: primaryBlue,
                    ),
                    SizedBox(width: 16),
                    StatsCard(
                      count: '2',
                      label: 'Completed',
                      color: Colors.black87,
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Timeline
                const HighlightedTimelineItem(
                  time: '09:00',
                  patientName: 'Emma Watson',
                  appointmentType: 'Video Consultation',
                  status: 'Upcoming',
                ),
                const TimelineItem(
                  time: '09:30',
                  patientName: 'John Doe',
                  appointmentType: 'In-Person',
                  status: 'Completed',
                  statusColor: Colors.grey,
                ),
                const TimelineItem(
                  time: '10:00',
                  patientName: 'Jane Smith',
                  appointmentType: 'Video Consultation',
                  status: 'Confirmed',
                  statusColor: Colors.green,
                ),
                const BreakTimelineItem(time: '11:00'),
                const TimelineItem(
                  time: '11:30',
                  patientName: 'Michael Brown',
                  appointmentType: 'In-Person',
                  status: 'Pending',
                  statusColor: Colors.orange,
                ),
                const SizedBox(height: 100), // padding for FAB and nav bar
              ] else if (_activeTabIndex == 1) ...[
                // Week View
                const SizedBox(height: 60),
                const Center(
                  child: CustomText(
                    text: 'Week View Coming Soon',
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 100),
              ] else ...[
                // Month View
                const SizedBox(height: 60),
                const Center(
                  child: CustomText(
                    text: 'Month View Coming Soon',
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryBlue,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {},
      ),
    );
  }

  Widget _buildTab(String text, bool isActive, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: CustomText(
              text: text,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? Colors.black87 : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(text: label, fontSize: 14, color: Colors.black54),
          CustomText(
            text: value,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ],
      ),
    );
  }
}
