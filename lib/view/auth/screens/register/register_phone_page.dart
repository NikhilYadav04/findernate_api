import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({super.key});

  @override
  State<RegisterPhonePage> createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends State<RegisterPhonePage> {
  //* Send OTP API CALL
  void _handleSendOTP(
      {required BuildContext context,
      required BoxConstraints constraints,
      required ProviderRegister provider,
      required TextEditingController controller}) async {
    bool isPhoneValid = controller.length == 10;

    if (isPhoneValid) {
      bool isOTPSend =
          await provider.sendOtp(constraints: constraints, context: context);

      if (isOTPSend) {
        Navigator.pushNamed(context, "/otp-register"); // ✅ call it directly
      }
    }
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
                child: Container(
                  color: Colors.white,
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
                          child:
                              Icon(Icons.arrow_back_ios, size: scale(0.035))),
                      SizedBox(height: scale(0.04)),
                      Text(
                        'Phone',
                        style: _style.copyWith(
                          fontSize: scale(0.032),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: scale(0.012)),
                      Text(
                        'Enter your phone number',
                        style: _style.copyWith(
                          fontSize: scale(0.023),
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: scale(0.02)),

                      //* Fields And Label

                      phoneField(
                          constraints: constraints,
                          formKey: provider.phoneFormKey,
                          controller: provider.phoneFormController,
                          provider: provider),
                      SizedBox(height: scale(0.028)),

                      Spacer(),

                      //* Buttons
                      authButton(constraints, "Next", () {
                        final isPhoneValid =
                            provider.phoneFormController.text.length == 10;
                        if (isPhoneValid) {
                          Navigator.pushNamed(context, "/personal-info-1");
                        } else {
                          // Optionally, you can show a snackbar or alert to tell user to correct phone number
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Please enter a valid phone number')),
                          );
                        }
                      }),

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
