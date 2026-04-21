import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/shered_widgites/custom_text/custom_text.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

import 'package:graduation_project/models/model/shered_pref_controller/shered_pref_controler.dart';
import 'package:graduation_project/shered_widgites/resources/image_assets.dart';

class ConsultationPatientCard extends StatefulWidget {
  const ConsultationPatientCard({super.key});

  @override
  State<ConsultationPatientCard> createState() => _ConsultationPatientCardState();
}

class _ConsultationPatientCardState extends State<ConsultationPatientCard> {
  String userName = "Loading...";

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
    } else {
      setState(() {
        userName = "Patient";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28.r,
            backgroundImage: const AssetImage(ImageAssets.doctorImage),
            backgroundColor: ColorsManager.pastelBackground,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: userName,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    const CustomText(
                      text: "Ready for Call",
                      fontSize: 13,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: "10:00 AM",
                      fontSize: 13,
                      color: ColorsManager.lightGray,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            Icons.more_vert_rounded,
            color: ColorsManager.lightGray,
            size: 24.w,
          ),
        ],
      ),
    );
  }
}
