import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/models/repository/patient_form_data.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_chip_selection.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_switch.dart';
import 'package:graduation_project/shered_widgites/custom_text_filed/custom_text_field.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/shered_widgites/routes_manager.dart';
import 'package:graduation_project/shered_widgites/string/app_string.dart';

enum PatientRegistrationStep { welcome, form }

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({super.key});

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  PatientRegistrationStep _currentStep = PatientRegistrationStep.welcome;
  final PageController _pageController = PageController();
  int _currentSubPage = 0;

  final _dateController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  final List<String> _selectedAllergies = [];
  final List<String> _selectedMedications = [];
  bool _shareDataWithInsurance = true;

  @override
  void dispose() {
    _pageController.dispose();
    _dateController.dispose();
    _fullNameController.dispose();
    _phoneController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  void _nextPage() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (_currentSubPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentSubPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStep == PatientRegistrationStep.welcome) {
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
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppString.welcomepatient,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: ColorsManager.purble,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                AppString.pleasechooseanoption,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: ColorsManager.gray),
              ),
              const SizedBox(height: 50),
              CustomButton(
                backgroundColor: ColorsManager.purble,
                text: AppString.createNewAccountPatient,
                onPressed: () {
                  setState(() {
                    _currentStep = PatientRegistrationStep.form;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                backgroundColor: ColorsManager.purble,
                text: AppString.alreadyhaveanaccountLogInPatient,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RoutManager.login,
                    arguments: AppString.patient,
                  );
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
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.w),
          onPressed: () {
            if (_currentSubPage == 0) {
              setState(() {
                _currentStep = PatientRegistrationStep.welcome;
              });
            } else {
              _previousPage();
            }
          },
        ),
        title: Text(
          AppString.patientRegistration,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: LinearProgressIndicator(
              value: (_currentSubPage + 1) / 2,
              color: ColorsManager.purble,
              backgroundColor: ColorsManager.gray.withOpacity(0.1),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (idx) => setState(() => _currentSubPage = idx),
              physics: const NeverScrollableScrollPhysics(),
              children: [_buildStepOne(), _buildStepTwo()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepOne() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppString.personalInformation,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            controller: _fullNameController,
            labelText: AppString.fullName,
            errorText: "Please enter full name",
            hintText: 'John Doe',
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: _phoneController,
            labelText: AppString.phoneNumber,
            errorText: "Please enter phone number",
            hintText: '+1 234 567 890',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 24),
          CustomTextField(
            controller: _dateController,
            labelText: AppString.dateOfBirth,
            errorText: "Please select date of birth",
            hintText: 'yyyy-MM-dd',
            isDateField: true,
            initialDate: DateTime(2000),
            firstDate: DateTime(1950),
            lastDate: DateTime.now(),
          ),
          const Divider(height: 40),
          const Text(
            AppString.medicalHistory,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              AppString.knownAllergies,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          CustomChipSelection(
            options: PatientFormData.allergiesOptions,
            selectedList: _selectedAllergies,
            onSelected: (option, selected) {
              setState(() {
                selected
                    ? _selectedAllergies.add(option)
                    : _selectedAllergies.remove(option);
              });
            },
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              AppString.currentMedications,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          CustomChipSelection(
            options: PatientFormData.medicationOptions,
            selectedList: _selectedMedications,
            onSelected: (option, selected) {
              setState(() {
                selected
                    ? _selectedMedications.add(option)
                    : _selectedMedications.remove(option);
              });
            },
          ),
          const SizedBox(height: 32),
          CustomButton(
            text: AppString.createNewAccount,
            backgroundColor: ColorsManager.purble,
            onPressed: _nextPage,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStepTwo() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppString.privacySettings,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          CustomTextField(
            controller: _emergencyContactController,
            labelText: AppString.emergencyContactNumber,
            errorText: "Please enter emergency contact",
            hintText: AppString.emergencyContactHint,
            prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          CustomSwitch(
            label: AppString.allowSharingMedicalHistory,
            value: _shareDataWithInsurance,
            onChanged: (val) => setState(() => _shareDataWithInsurance = val),
          ),
          const SizedBox(height: 40),
          CustomButton(
            text: AppString.completeRegistration,
            backgroundColor: ColorsManager.purble,
            onPressed: () {
              _showSuccessDialog();
            },
          ),
        ],
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
            const Text(
              AppString.success,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            const Text(
              AppString.accountCreatedSuccessfully,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 24.h),
            CustomButton(
              text: AppString.backToHome,
              backgroundColor: ColorsManager.purble,
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  RoutManager.patientHome,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
