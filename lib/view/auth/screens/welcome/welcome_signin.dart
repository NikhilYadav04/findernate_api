// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appImages.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

// ignore: must_be_immutable
class WelcomeSignin extends StatelessWidget {
  WelcomeSignin({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                //* Upper Image
                FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.5,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: constraints.maxWidth * 0.04,
                          right: constraints.maxWidth * 0.04,
                          top: constraints.maxWidth * 0.08),
                      child: Image.asset(
                        AppImages.welcomeScreen2,
                        fit: BoxFit.contain,
                      ),
                    )),

                //* Button
                FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.45,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: constraints.maxWidth * 0.05),
                          child: authButton(constraints, "Done", () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/bottom-bar',
                              (Route<dynamic> route) =>
                                  false, // removes all previous routes
                              arguments: {
                                'transition': TransitionType.rightToLeft,
                                'duration': 300,
                              },
                            );
                          }),
                        )
                      ],
                    ))
              ],
            );
          }),
        ));
  }
}
