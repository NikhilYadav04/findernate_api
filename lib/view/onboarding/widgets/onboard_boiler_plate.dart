// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:social_media_clone/view/onboarding/widgets/onboard_widgets.dart';

// ignore: must_be_immutable
class OnboardBoilerPlate extends StatelessWidget {
  num index;
  String image;
  String title;
  String description;
  VoidCallback onTap;
  VoidCallback onTapSkip;
  OnboardBoilerPlate({
    Key? key,
    required this.index,
    required this.image,
    required this.title,
    required this.description,
    required this.onTap,
    required this.onTapSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            fit: StackFit.expand,
            children: [
              //* Upper Image
              FractionallySizedBox(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.45,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: constraints.maxWidth * 0.04,
                        right: constraints.maxWidth * 0.04,
                        top: constraints.maxWidth * 0.06),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                    ),
                  )),

              //* Lower Text
              FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.52,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.045),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* title text
                        Text(
                          title,
                          style: _style.copyWith(
                              fontSize: constraints.maxHeight * 0.026,
                              fontFamily: "Poppins-Medium",
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.012,
                        ),

                        //* desc text
                        Text(
                          description,
                          style: _style.copyWith(
                              height: constraints.maxHeight * 0.0015,
                              fontSize: constraints.maxHeight * 0.021,
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),

                        //* buttons
                        onboardButton1(index == 2 ? "Continue" : "Next", onTap,
                            constraints, false),

                        index == 2
                            ? SizedBox()
                            : SizedBox(
                                height: constraints.maxHeight * 0.03,
                              ),

                        index == 2
                            ? SizedBox()
                            : onboardButton("Skip", Colors.white, Colors.black,
                                onTapSkip, constraints, true),

                        //* Already Text
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: constraints.maxHeight * .04),
                            child: Center(
                              child: FittedBox(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Already have an account? ',
                                    style: _style.copyWith(
                                        color: Colors.black,
                                        fontSize: constraints.maxHeight * 0.021,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                      TextSpan(
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // Navigate on tap
                                            Navigator.pushNamed(
                                                context, '/sign-in');
                                          },
                                        text: 'Sign In',
                                        style: _style.copyWith(
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  )),
            ],
          ),
        );
      }),
    );
  }

  TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
}
