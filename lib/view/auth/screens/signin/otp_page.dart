import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/utils/validator.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  //* to toggle visibility
  bool isObSecure = false;

  int _seconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _seconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Scaling factors
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;

            // Example scaling
            double scale(double value) => value * maxHeight;
            double hPadding(double value) => value * maxWidth;

            return Consumer<ProviderSignIn>(builder: (context, provider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding(0.04)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: scale(0.03)),
                    InkWell(
                        //onTap: ()=>context.pop(),
                        child: Icon(Icons.arrow_back_ios, size: scale(0.035))),
                    SizedBox(height: scale(0.04)),
                    Text(
                      'OTP Sent',
                      style: _style.copyWith(
                        fontSize: scale(0.035),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: scale(0.012)),
                    Text(
                      'Enter the OTP sent to you',
                      style: _style.copyWith(
                        fontSize: scale(0.025),
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: scale(0.045)),

                    //* Fields And Label

                    Pinput(
                      controller: provider.otpController,
                      key: provider.otpFormKey,
                      length: 6,
                      defaultPinTheme: defaultPinTheme(constraints),
                      focusedPinTheme: defaultPinTheme(constraints),
                      submittedPinTheme: defaultPinTheme(constraints),
                      showCursor: true,
                      onCompleted: (pin) {},
                      readOnly: false,
                    ),
                    SizedBox(height: scale(0.028)),

                    FittedBox(
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't receive any code? ",
                          style: _style.copyWith(
                            color: Colors.black,
                            fontSize: scale(0.021),
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: _seconds == 0
                                  ? "Resend"
                                  : "Resend in ${formatTime(_seconds)}",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _seconds == 0
                                    ? () {
                                        _startTimer();
                                      }
                                    : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),

                    //* Buttons
                    authButton(constraints, "Next", () {}),
                    //SizedBox(height: scale(0.025)),

                    //* No Account Text
                    noAccountSignUpText(constraints, () {
                      //  context.push('/register-phone');
                    }),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
}
