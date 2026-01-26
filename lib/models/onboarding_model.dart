import 'package:graduation_project/core/resources/image_assets.dart';

class OnBoardingModel {
  String image;
  String title;
  String description;
  String buttonLabel;
  bool isFirstPage;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonLabel,
    this.isFirstPage = false,
  });

  static List<OnBoardingModel> onBoardingScreens = [
    OnBoardingModel(
      image: ImageAssets.onBoarding1,
      title: "Connect with\n Experts",
      description:
          "Get instant 24/7 access to top-rated doctors and specialists. Consultations,prescriptions, and advice—all from your phone. .",
      buttonLabel: "Next",
    ),

    OnBoardingModel(
      image: ImageAssets.onBoarding2,
      title: "Discover Movies",
      description:
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.",
      buttonLabel: "Next",
    ),

    OnBoardingModel(
      image: ImageAssets.onBoarding3,
      title: "Explore All Genres",
      description:
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.",
      buttonLabel: "Next",
    ),
  ];
}
