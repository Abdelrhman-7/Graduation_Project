import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class DoctorProfileHeader extends StatelessWidget {
  const DoctorProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundImage: const NetworkImage(
                'https://randomuser.me/api/portraits/women/44.jpg',
              ),
              backgroundColor: ColorsManager.pastelBackground,
            ),
            Positioned(
              right: 0,
              bottom: 2.r,
              child: Container(
                width: 14.r,
                height: 14.r,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorsManager.white, width: 2.r),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Dr. Sarah Jenkins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorsManager.black,
              ),
              SizedBox(height: 4.h),
              const CustomText(
                text: 'General Practitioner',
                fontSize: 14,
                color: ColorsManager.lightGray,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
