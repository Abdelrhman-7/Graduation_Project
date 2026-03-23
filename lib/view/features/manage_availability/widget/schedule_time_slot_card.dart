import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class ScheduleTimeSlotCard extends StatelessWidget {
  final String title;
  final String time;
  final bool isEnabled;
  final ValueChanged<bool>? onChanged;

  const ScheduleTimeSlotCard({
    super.key,
    required this.title,
    required this.time,
    required this.isEnabled,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isEnabled ? ColorsManager.white : ColorsManager.pastelBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: isEnabled ? null : Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isEnabled ? ColorsManager.black : Colors.grey[400]!,
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14.w,
                    color: isEnabled ? ColorsManager.primaryBlue : Colors.grey[400]!,
                  ),
                  SizedBox(width: 6.w),
                  CustomText(
                    text: time,
                    fontSize: 13,
                    color: isEnabled ? ColorsManager.black : Colors.grey[400]!,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ],
          ),
          CupertinoSwitch(
            value: isEnabled,
            onChanged: onChanged,
            activeColor: ColorsManager.primaryBlue,
          ),
        ],
      ),
    );
  }
}
