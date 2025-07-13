import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appImages.dart';
import 'package:social_media_clone/core/constants/appStrings.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

// ignore: must_be_immutable
class ForgotEmailCard extends StatelessWidget {
  ForgotEmailCard({super.key});

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
                      heightFactor: 0.45,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: constraints.maxWidth * 0.04,
                            right: constraints.maxWidth * 0.04,
                            top: constraints.maxWidth * 0.06),
                        child: Image.asset(
                          AppImages.forgotImage,
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
                              AppStrings.forgotPasswordTitle,
                              style: _style.copyWith(
                                  fontSize: constraints.maxHeight * 0.031,
                                  fontFamily: "Poppins-Medium",
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
          
                            //* desc text
                            Text(
                              AppStrings.forgotPasswordDescription,
                              style: _style.copyWith(
                                  height: constraints.maxHeight * 0.0015,
                                  fontSize: constraints.maxHeight * 0.0225,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
          
                            //* buttons
                            authButton(constraints, "Done", () {
                              // Navigate on tap
                              Navigator.pushReplacementNamed(context, '/sign-in');
                            }),
          
                            //* Already Text
                            Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: constraints.maxHeight * .04),
                                child: Center(
                                  child: FittedBox(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Do not have an Account? ',
                                        style: _style.copyWith(
                                            color: Colors.black,
                                            fontSize:
                                                constraints.maxHeight * 0.022,
                                            fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // Navigate on tap
                                                Navigator.pushReplacementNamed(
                                                    context, '/register-phone');
                                              },
                                            text: 'Sign up',
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
              );
            }),
        ),
        );
  }

  TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
}
