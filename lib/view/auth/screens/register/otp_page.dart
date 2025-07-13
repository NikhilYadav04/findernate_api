import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/toastCard.dart';
import 'package:social_media_clone/core/utils/validator.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

class OtpPageRegister extends StatefulWidget {
  const OtpPageRegister({super.key});

  @override
  State<OtpPageRegister> createState() => _OtpPageRegisterState();
}

class _OtpPageRegisterState extends State<OtpPageRegister> {
  //* to toggle visibility
  bool isObSecure = false;

  //* Verify OTP API CALL
  void _handleVerifyOTP(
      {required BuildContext context,
      required BoxConstraints constraints,
      required ProviderRegister provider,
      required TextEditingController controller}) async {
    bool isOTPValid = controller.length == 4;

    if (isOTPValid) {
      _startTimer();
      bool isOTPVerified =
          await provider.verifyOtp(constraints: constraints, context: context);
      if (isOTPVerified) {
        Navigator.pushNamed(context, '/personal-info-1');
      }
    } else {
      ToastCardWidget.showToast(
          constraints: constraints,
          context: context,
          text: "OTP must be 4 digits long",
          icon: Icons.error,
          color: Colors.red);
    }
  }

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
      resizeToAvoidBottomInset: false,
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

            return Consumer<ProviderRegister>(builder: (context, provider, _) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: hPadding(0.04)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: scale(0.03)),
                    InkWell(
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        },
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
                      child: GestureDetector(
                        onTap: () {
                          if (_seconds == 0) {
                            setState(() {
                              _handleVerifyOTP(
                                  context: context,
                                  constraints: constraints,
                                  provider: provider,
                                  controller: provider.otpController);
                            });
                          }
                        },
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Spacer(),

                    //* Buttons
                    provider.isLoading
                        ? Center(
                            child: SpinKitCircle(
                              color: Color(0xFFFCD45C),
                              size: constraints.maxHeight * 0.05,
                            ),
                          )
                        : authButton(
                            constraints,
                            "Next",
                            () => _handleVerifyOTP(
                                provider: provider,
                                constraints: constraints,
                                context: context,
                                controller: provider.otpController)),

                    //* No Account Text
                    noAccountSignInText(constraints, () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/sign-in',
                        arguments: {
                          'transition': TransitionType.bottomToTop,
                          'duration': 300,
                        },
                      );
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
