import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appControllers.dart';
import 'package:social_media_clone/model/onboard/model_onboard.dart';
import 'package:social_media_clone/view/onboarding/widgets/onboard_boiler_plate.dart';

class OnboardRootScreen extends StatefulWidget {
  const OnboardRootScreen({super.key});

  @override
  State<OnboardRootScreen> createState() => _OnboardRootScreenState();
}

class _OnboardRootScreenState extends State<OnboardRootScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppControllers.onBoardPageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Container(
          color: Colors.white,
          child:  PageView(
          controller: AppControllers.onBoardPageController,
          children: List.generate(dataOnBoard.length, (index) {
            return OnboardBoilerPlate(
              index: index,
              image: dataOnBoard[index].image,
              title: dataOnBoard[index].title,
              description: dataOnBoard[index].desc,
              onTap: () {
                if (index < dataOnBoard.length - 1) {
                  AppControllers.onBoardPageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushNamed(context, '/register-phone');
                }
              },
              onTapSkip: () {
                AppControllers.onBoardPageController.animateToPage(
                  2,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            );
          }),
                ),
              ),
        );
  }
}
