// ignore: file_names
import 'package:flutter/material.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';

class RegisterDoctorScreen extends StatelessWidget {
  const RegisterDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: ColorsManager.white),
      body: Container(decoration: BoxDecoration(color: ColorsManager.white)),
    );
  }
}
