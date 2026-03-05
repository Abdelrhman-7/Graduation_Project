import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_state.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';

class MedicineInfoCard extends StatelessWidget {
  final PharmacyLoaded state;

  const MedicineInfoCard({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final medicine = state.prescription.medicine;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Text(
                    medicine.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  medicine.genericName,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorsManager.lightGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  medicine.dosage,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.purble,
                  ),
                ),
                Text(
                  medicine.count,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: ColorsManager.lightGray,
                  ),
                ),
              ],
            ),
          ),

          // Right side: Image
          Container(
            width: 96.w,
            height: 96.h,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: ColorsManager.purble.withOpacity(0.05),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: Image.asset(
                medicine.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.medication_rounded,
                  color: ColorsManager.purble,
                  size: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
