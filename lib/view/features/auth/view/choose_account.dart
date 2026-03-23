import 'package:flutter/material.dart';
import 'package:graduation_project/view/features/auth/view/login_screen.dart';
import 'package:graduation_project/view/features/auth/view/doctor_registration_screen.dart';
import 'package:graduation_project/view/features/auth/widget/custmo_select_login_button.dart';
import 'package:graduation_project/shered_widgites/custom_bouttm/custom_button.dart';
import 'package:graduation_project/shered_widgites/resources/colors_manager.dart';
import 'package:graduation_project/shered_widgites/resources/image_assets.dart';
import 'package:graduation_project/shered_widgites/string/app_string.dart';
import 'package:graduation_project/view/patient/features/auth/view/patient_registration_screen.dart';

class ChooseAccount extends StatefulWidget {
  const ChooseAccount({super.key});
  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

class _ChooseAccountState extends State<ChooseAccount> {
  String selectedRole = "";
  String position = "";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorsManager.white),
      backgroundColor: ColorsManager.white,

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.0615,
          vertical: height * 0.00995,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppString.joinAsA,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(height: height * 0.0090),
            const Text(
              AppString.chooseYourRole,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: height * 0.029),
            Row(
              children: [
                CustmoSelectLoginButton(
                  text: AppString.patient,
                  text2: AppString.findDoctorAndBook,
                  image: ImageAssets.patientImage,
                  isSelected: selectedRole == AppString.patient,
                  onTap: () {
                    setState(() {
                      selectedRole = AppString.patient;
                    });
                  },
                ),
                SizedBox(width: width * 0.05033),
                CustmoSelectLoginButton(
                  text: AppString.doctor,
                  text2: AppString.managePatientsAndSchedule,
                  image: ImageAssets.doctorImage,
                  isSelected: selectedRole == AppString.doctor,
                  onTap: () {
                    setState(() {
                      selectedRole = AppString.doctor;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.029),
            CustmoSelectLoginButton(
              text: AppString.nursing,
              text2: AppString.assistDoctorsAndSupport,
              image: ImageAssets.nursingImage,
              isSelected: selectedRole == AppString.nursing,
              onTap: () {
                setState(() {
                  selectedRole = AppString.nursing;
                });
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.0615,
          vertical: height * 0.05,
        ),
        child: CustomButton(
          onPressed: () {
            if (selectedRole == AppString.patient) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PatientRegistrationScreen(),
                ),
              );
            } else if (selectedRole == AppString.doctor) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DoctorRegistrationScreen(),
                ),
              );
            } else if (selectedRole == AppString.nursing) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(role: selectedRole),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorsManager.lightGray,
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.00615,
                    vertical: height * 0.009,
                  ),
                  elevation: 0.02,
                  content: const Text(
                    AppString.pleaseSelectRoleFirst,
                    style: TextStyle(color: ColorsManager.black),
                  ),
                ),
              );
            }
          },
          backgroundColor: ColorsManager.purble,
          text: AppString.continueText,
        ),
      ),
    );
  }
}
