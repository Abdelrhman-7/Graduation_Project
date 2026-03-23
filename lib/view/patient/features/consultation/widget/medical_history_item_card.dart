import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class MedicalHistoryItemCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const MedicalHistoryItemCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: subtitle,
                  fontSize: 13,
                  color: ColorsManager.lightGray,
                ),
              ],
            ),
          ),
          const CustomText(
            text: "Hold to view",
            fontSize: 12,
            color: ColorsManager.primaryBlue,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
