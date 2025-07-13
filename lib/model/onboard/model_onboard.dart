// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:social_media_clone/core/constants/appImages.dart';
import 'package:social_media_clone/core/constants/appStrings.dart';

class ModelOnboard {
  String image;
  String title;
  String desc;
  ModelOnboard({
    required this.image,
    required this.title,
    required this.desc,
  });
}

List<ModelOnboard> dataOnBoard = [
  ModelOnboard(image: AppImages.onboardingScreen1, title: AppStrings.onboardTitle1, desc: AppStrings.onboardDesc1),
  ModelOnboard(image: AppImages.onboardingScreen2, title: AppStrings.onboardTitle2, desc: AppStrings.onboardDesc2),
  ModelOnboard(image: AppImages.onboardingScreen3, title: AppStrings.onboardTitle3, desc: AppStrings.onboardDesc3),
];
