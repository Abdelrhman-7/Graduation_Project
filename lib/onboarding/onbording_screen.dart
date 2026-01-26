import 'package:flutter/material.dart';
import 'package:graduation_project/core/resources/colors_manager.dart';
import 'package:graduation_project/core/routes_manager.dart';
import 'package:graduation_project/models/onboarding_model.dart';
import 'package:graduation_project/onboarding/default_onbording.dart';
import 'package:graduation_project/onboarding/first_onbording.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  int _currentIndex = 0;

  void goNextPage() {
    if (_currentIndex == OnBoardingModel.onBoardingScreens.length - 1) {
      Navigator.pushReplacementNamed(context, RoutesManager.chooseAccount);
      return;
    }
    setState(() {
      _currentIndex++;
    });
  }

  void backToPreviousPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          FirstOnbording(nextPage: goNextPage),
          ...OnBoardingModel.onBoardingScreens
              .skip(0)
              .map(
                (model) => DefultOnbording(
                  model: model,
                  onBackPress: backToPreviousPage,
                  onNextPress: goNextPage,
                  isFirst: _currentIndex == 1,
                ),
              ),
        ],
      ),
    );
  }
}
