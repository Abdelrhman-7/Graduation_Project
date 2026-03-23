import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

import '../widget/manage_availability_app_bar.dart';
import '../widget/doctor_profile_header.dart';
import '../widget/availability_toggle.dart';
import '../widget/calendar_grid_section.dart';
import '../widget/schedule_time_slot_card.dart';
import '../widget/add_time_slot_button.dart';

class ManageAvailabilityScreen extends StatelessWidget {
  const ManageAvailabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: const ManageAvailabilityAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Section
                    const DoctorProfileHeader(),
                    SizedBox(height: 24.h),

                    // Availability Toggle
                    const AvailabilityToggle(),
                    SizedBox(height: 32.h),

                    // Calendar Section
                    const CalendarGridSection(),
                    SizedBox(height: 32.h),

                    // Schedule Section Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          text: 'Schedule for Sep 5',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.black,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const CustomText(
                            text: 'Apply to week',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorsManager.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Time Slots
                    ScheduleTimeSlotCard(
                      title: 'Morning Shift',
                      time: '08:00 AM - 12:00 PM',
                      isEnabled: true,
                      onChanged: (val) {},
                    ),
                    ScheduleTimeSlotCard(
                      title: 'Lunch Break',
                      time: '12:00 PM - 01:00 PM',
                      isEnabled: false,
                      onChanged: (val) {},
                    ),
                    ScheduleTimeSlotCard(
                      title: 'Afternoon Shift',
                      time: '01:00 PM - 05:00 PM',
                      isEnabled: true,
                      onChanged: (val) {},
                    ),
                    SizedBox(height: 12.h),

                    // Add Time Slot Button
                    AddTimeSlotButton(onTap: () {}),
                  ],
                ),
              ),
            ),
            
            // Bottom Button
            Padding(
              padding: EdgeInsets.all(24.w),
              child: CustomButton(
                text: 'Save Changes',
                onPressed: () {},
                backgroundColor: ColorsManager.primaryBlue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
