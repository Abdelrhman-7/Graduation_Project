import 'package:flutter/material.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';
import 'package:graduation_project/models/onboarding_model.dart';

class FirstOnbording extends StatelessWidget {
  FirstOnbording({super.key, required this.nextPage});
  final OnBoardingModel model = OnBoardingModel.onBoardingScreens[0];
  final VoidCallback nextPage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.yellow,

      body: Container(
        decoration: BoxDecoration(color: ColorsManager.white),
        child: Column(
          children: [
            Image.asset(model.image),
            Text(model.title),
            Text(model.description),
          ],
        ),
      ),
    );
  }
}
