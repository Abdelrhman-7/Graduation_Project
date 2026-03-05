import 'package:flutter/material.dart';
import 'package:graduation_project/models/model/pharmacy_model.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/controller/business_logic-layer/pharmacy_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PharmacySelectionCard extends StatelessWidget {
  final PharmacyModel pharmacy;
  final bool isSelected;
  const PharmacySelectionCard({
    super.key,
    required this.pharmacy,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PharmacyCubit>().selectPharmacy(pharmacy),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? ColorsManager.purble : Colors.transparent,
            width: 2,
          ),
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
          children: [
            // Pharmacy Image/Icon
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: ColorsManager.purble.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: pharmacy.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.asset(pharmacy.imageUrl!, fit: BoxFit.cover),
                    )
                  : Icon(
                      pharmacy.icon,
                      color: ColorsManager.purble,
                      size: 24.w,
                    ),
            ),
            SizedBox(width: 12.w),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          pharmacy.name,
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.black,
                          ),
                        ),
                      ),
                      if (!isSelected)
                        Text(
                          'Select',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.purble,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    pharmacy.address,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsManager.lightGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  // Stock Status
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: pharmacy.isInStock
                          // ignore: deprecated_member_use
                          ? Colors.green.withOpacity(0.1)
                          // ignore: deprecated_member_use
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      pharmacy.isInStock ? 'In Stock' : 'Out of Stock',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: pharmacy.isInStock ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: Icon(
                  Icons.check_circle,
                  color: ColorsManager.purble,
                  size: 24.w,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
