import 'package:flutter/material.dart';
import 'package:graduation_project/view/features/auth/view/choose_account.dart';
import 'package:graduation_project/view/features/auth/view/doctor_registration_screen.dart';
import 'package:graduation_project/view/features/auth/view/forget_passowrd.dart';
import 'package:graduation_project/view/features/auth/view/login_screen.dart';
import 'package:graduation_project/view/features/auth/view/patient_registration_screen.dart';
import 'package:graduation_project/view/features/find_doctor/view/find_doctor_screen.dart';
import 'package:graduation_project/view/features/home/view/home_screen.dart';
import 'package:graduation_project/view/features/pharmacy/view/digital_prescription_screen.dart';

class RoutManager {
  static const String login = '/loginscreen';
  static const String registerscreen = '/registerscreen';
  static const String home = '/home';
  static const String forgetPassword = "/forgetPassword";
  static const String newPassowrdScreen = "/newPassowrdScreen";
  static const String patientRegistrationScreen = "/patientRegistrationScreen";
  static const String doctorRegistrationScreen = "/doctorRegistrationScreen";
  static const String chooseAccount = "/chooseAccount";
  static const String findDoctor = "/findDoctor";
  static const String digitalPrescription = "/digitalPrescription";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case registerscreen:
        return MaterialPageRoute(builder: (_) => const ForgetPassowrd());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassowrd());

      case chooseAccount:
        return MaterialPageRoute(builder: (_) => const ChooseAccount());

      case patientRegistrationScreen:
        return MaterialPageRoute(
          builder: (_) => const PatientRegistrationScreen(),
        );

      case doctorRegistrationScreen:
        return MaterialPageRoute(
          builder: (_) => const DoctorRegistrationScreen(),
        );

      case findDoctor:
        return MaterialPageRoute(builder: (_) => const FindDoctorScreen());

      case digitalPrescription:
        return MaterialPageRoute(
          builder: (_) => const DigitalPrescriptionScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
