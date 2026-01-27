import 'package:flutter/material.dart';
import 'package:graduation_project/core/custom_bouttm/custmo_select_login_button.dart';
import 'package:graduation_project/core/custom_bouttm/custom_navigator_button.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';
import 'package:graduation_project/core/resources/image_assets.dart';
import 'package:graduation_project/features/auth/ui/login_screen.dart';
import 'package:graduation_project/features/auth/ui/register_Doctor_screen/register_Doctor_screen.dart';
import 'package:graduation_project/features/auth/ui/register_patient_screen/register_patient_screen.dart';

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
              "Join as a...",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
            SizedBox(height: height * 0.0090),
            const Text(
              "Choose your role to get started with your healthcare journey.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: height * 0.029),
            Row(
              children: [
                CustmoSelectLoginButton(
                  text: "Patient",
                  text2: "Find doctor & book appointments",
                  image: ImageAssets.onBoarding1,
                  isSelected: selectedRole == "Patient",
                  onTap: () {
                    setState(() {
                      selectedRole = "Patient";
                    });
                  },
                ),
                SizedBox(width: width * 0.05033),
                CustmoSelectLoginButton(
                  text: "Doctor",
                  text2: "Manage patients & schedule",
                  image: ImageAssets.onBoarding1,
                  isSelected: selectedRole == "Doctor",
                  onTap: () {
                    setState(() {
                      selectedRole = "Doctor";
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.029),
            CustmoSelectLoginButton(
              text: "Nursing",
              text2: "Assist doctors & support patients",
              image: ImageAssets.onBoarding1,
              isSelected: selectedRole == "Nursing",
              onTap: () {
                setState(() {
                  selectedRole = "Nursing";
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
        child: CustomNavigatorButton(
          onPressed: () {
            if (selectedRole == "Patient") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPatientScreen(),
                ),
              );
            } else if (selectedRole == "Doctor") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterDoctorScreen()),
              );
            } else if (selectedRole == "Nursing") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
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
                    "  Please select a role first",
                    style: TextStyle(color: ColorsManager.black),
                  ),
                ),
              );
            }
          },
          color: ColorsManager.purble,
          text: "Continue",
        ),
      ),
    );
  }
}
