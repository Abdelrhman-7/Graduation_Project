import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/view/features/auth/view/choose_account.dart';
import 'package:graduation_project/view/features/auth/view/doctor_registration_screen.dart';
import 'package:graduation_project/view/features/auth/view/forget_passowrd.dart';
import 'package:graduation_project/view/features/auth/view/login_screen.dart';
import 'package:graduation_project/view/features/chat/view/chat_screen.dart';
import 'package:graduation_project/view/features/doctor_dashboard/view/doctor_main_screen.dart';
import 'package:graduation_project/view/features/find_doctor/view/find_doctor_screen.dart';
import 'package:graduation_project/view/features/home/view/home_screen.dart';
import 'package:graduation_project/view/features/lab_results/view/lab_results_screen.dart';
import 'package:graduation_project/view/features/pharmacy/view/digital_prescription_screen.dart';
import 'package:graduation_project/view/features/pharmacy/view/medication_refill_screen.dart';
import 'package:graduation_project/view/patient/features/home/view/patient_main_screen.dart';
import 'package:graduation_project/view/patient/features/consultation/view/consultation_overview_screen.dart';
import 'package:graduation_project/view/features/manage_availability/view/manage_availability_screen.dart';
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
  static const String labResults = "/labResults";
  static const String chat = "/chat";
  static const String medicationRefill = "/medicationRefill";
  static const String doctorHome = "/doctorHome";
  static const String patientHome = "/patientHome";
  static const String consultationOverview = "/consultationOverview";
  static const String manageAvailability = "/manageAvailability";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        final role = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => LoginScreen(role: role));

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
          builder: (_) => const ConsultationOverviewScreen(),
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

      case labResults:
        return MaterialPageRoute(builder: (_) => const LabResultsScreen());

      case chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());

      case medicationRefill:
        final med = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          builder: (_) => MedicationRefillScreen(medication: med),
        );

      case patientHome:
        return MaterialPageRoute(
          builder: (_) => const ConsultationOverviewScreen(),
        );

      case doctorHome:
        return MaterialPageRoute(builder: (_) => const DoctorMainScreen());

      case consultationOverview:
        return MaterialPageRoute(
          builder: (_) => const ConsultationOverviewScreen(),
        );

      case manageAvailability:
        return MaterialPageRoute(
          builder: (_) => const ManageAvailabilityScreen(),
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
