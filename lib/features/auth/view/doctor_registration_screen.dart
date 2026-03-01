import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/auth/widget/custom_drop_down.dart';
import 'package:graduation_project/features/auth/widget/custom_image_picker.dart';
import 'package:graduation_project/shered/custom_text_filed/custom_text_field.dart';
import 'package:graduation_project/shered/resources/colors_manager.dart';
import 'package:graduation_project/shered/routes_manager.dart';
import 'package:graduation_project/shered/string/app_string.dart';
import 'package:graduation_project/shered/custom_bouttm/custom_button.dart';

enum DoctorRegistrationStep { welcome, form }

class DoctorRegistrationScreen extends StatefulWidget {
  const DoctorRegistrationScreen({super.key});

  @override
  State<DoctorRegistrationScreen> createState() =>
      _DoctorRegistrationScreenState();
}

class _DoctorRegistrationScreenState extends State<DoctorRegistrationScreen> {
  DoctorRegistrationStep _currentStep = DoctorRegistrationStep.welcome;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    if (_currentStep == DoctorRegistrationStep.welcome) {
      return _buildWelcomeView();
    } else {
      return _buildFormView();
    }
  }

  Widget _buildWelcomeView() {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppString.welcomedoctor,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.purble,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppString.pleasechooseanoption,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp, color: ColorsManager.gray),
              ),
              SizedBox(height: 50.h),
              CustomButton(
                backgroundColor: ColorsManager.purble,
                text: AppString.createNewAccount,
                onPressed: () {
                  setState(() {
                    _currentStep = DoctorRegistrationStep.form;
                  });
                },
              ),
              SizedBox(height: 20.h),
              CustomButton(
                backgroundColor: ColorsManager.purble,
                text: AppString.alreadyhaveanaccountLogIn,
                onPressed: () {
                  Navigator.pushNamed(context, RoutesManager.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormView() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () {
            setState(() {
              _currentStep = DoctorRegistrationStep.welcome;
            });
          },
        ),
        title: const Text(
          AppString.doctorRegistration,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              AppString.joinAsAProvider,
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1C1E),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              AppString.provideProfessionalDetails,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 32.h),
            CustomDropDown(
              label: AppString.specialization,
              hint: AppString.selectYourSpecialty,
              items: const [
                'Cardiology',
                'Dermatology',
                'Pediatrics',
                'Neurology',
                'Orthopedics',
                'Psychiatry',
                'Ophthalmology',
                'Internal Medicine',
              ],
              onChanged: (_) {},
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              label: AppString.medicalLicenseNumber,
              hint: AppString.egLicense,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              label: AppString.yearsOfExperience,
              hint: AppString.zero,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              suffixText: AppString.years,
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: ColorsManager.purble,
                  size: 20.w,
                ),
                SizedBox(width: 8.w),
                Text(
                  AppString.identityVerification,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            CustomImagePicker(
              title: AppString.uploadCredentials,
              subtitle: AppString.uploadMedicalLicense,
              onImageSelected: (image) {
                setState(() {
                  _selectedImage = image;
                });
              },
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.lock_outline, size: 14.w, color: Colors.grey),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    AppString.hipaaNote,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
            CustomButton(
              onPressed: () {
                if (_selectedImage == null) {
                  _showErrorDialog(AppString.pleaseUploadLicenseFirst);
                } else {
                  _showSuccessDialog();
                }
              },
              backgroundColor: ColorsManager.purble,
              text: AppString.submitAndVerify,
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_outline,
              color: ColorsManager.purble,
              size: 80.w,
            ),
            SizedBox(height: 16.h),
            Text(
              AppString.success,
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              AppString.accountCreatedSuccessfully,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14.sp),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: AppString.backToHome,
              backgroundColor: ColorsManager.purble,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 60.w),
            SizedBox(height: 16.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: "OK",
              backgroundColor: ColorsManager.purble,
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
