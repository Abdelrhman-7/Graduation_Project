import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';
import 'package:graduation_project/models/onboarding_model.dart';
import 'package:graduation_project/widgets/custom_elevated_button.dart';

class DefultOnbording extends StatelessWidget {
  const DefultOnbording({
    super.key,
    required this.model,
    this.isFirst = false,
    required this.onNextPress,
    required this.onBackPress,
  });

  final OnBoardingModel model;
  final bool isFirst;
  final VoidCallback onNextPress;
  final VoidCallback onBackPress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.purble,
      body: Container(
        decoration: BoxDecoration(color: ColorsManager.white),
        child: Column(
          children: [
            Image.asset(model.image),
            Text(model.title),
            Text(model.description),
            SizedBox(height: 16.h),
            CustomElevatedButton(
              label: model.buttonLabel,
              onPressed: onNextPress,
            ),

            SizedBox(height: 16.h),

            if (!isFirst)
              CustomElevatedButton(
                label: "Back",
                onPressed: onBackPress,
                isBackButton: true,
              ),
          ],
        ),
      ),
    );
  }
}
