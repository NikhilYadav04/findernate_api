import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

class VerifyEmailOtpPage extends StatefulWidget {
  final String email;

  const VerifyEmailOtpPage({
    super.key,
    required this.email,
  });

  @override
  State<VerifyEmailOtpPage> createState() => _VerifyEmailOtpPageState();
}

class _VerifyEmailOtpPageState extends State<VerifyEmailOtpPage> {
  bool _isLoading = false;

//* Verify Email OTP API CALL
  void _handleVerifyEmailOTP({
    required ProviderRegister provider,
    required BuildContext context,
    required BoxConstraints constraints,
    required ProviderAuth providerAuth,
  }) async {
    //* Validate OTP length
    if (provider.otpController.text.length != 6) {
      showSnackBar(
        "Please enter the complete 6-digit OTP",
        context,
        isError: true,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool isSuccess = await providerAuth.verifyRegister(
      email: provider.personalEmailController.text.toString(),
      otp: provider.otpController.text.toString(),
      context: context,
    );

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/welcome-register',
        (route) => false,
        arguments: {
          'transition': TransitionType.rightToLeft,
          'duration': 300,
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<ProviderAuth>(context, listen: false);
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
                    SizedBox(height: scale(0.015)),

                    //* Back Button
                    InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(Icons.arrow_back_ios, size: scale(0.035)),
                    ),
                    SizedBox(height: scale(0.04)),

                    //* Title
                    Text(
                      'Verify Email',
                      style: _style.copyWith(
                        fontSize: scale(0.032),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: scale(0.015)),

                    //* Subtitle below OTP field
                    Text(
                      'Enter the verification code sent to your email',
                      style: _style.copyWith(
                        fontSize: scale(0.023),
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: scale(0.025)),

                    //* OTP Input Field
                    Form(
                      key: provider.otpFormKey,
                      child: Pinput(
                        controller: provider.otpController,
                        length: 6,
                        defaultPinTheme: defaultPinTheme(constraints),
                        focusedPinTheme: defaultPinTheme(constraints).copyWith(
                          decoration:
                              defaultPinTheme(constraints).decoration!.copyWith(
                                    border: Border.all(
                                        color: Color(0xFFFCD45C), width: 2),
                                  ),
                        ),
                        submittedPinTheme:
                            defaultPinTheme(constraints).copyWith(
                          decoration: defaultPinTheme(constraints)
                              .decoration!
                              .copyWith(
                                border:
                                    Border.all(color: Colors.green, width: 2),
                              ),
                        ),
                        errorPinTheme: defaultPinTheme(constraints).copyWith(
                          decoration: defaultPinTheme(constraints)
                              .decoration!
                              .copyWith(
                                border: Border.all(color: Colors.red, width: 2),
                              ),
                        ),
                        showCursor: true,
                        onCompleted: (pin) {},
                        readOnly: provider.isLoading,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    Spacer(),

                    //* Verify Button
                    _isLoading
                        ? Center(
                            child: SpinKitCircle(
                              color: Color(0xFFFCD45C),
                              size: constraints.maxHeight * 0.05,
                            ),
                          )
                        : authButton(
                            constraints,
                            "Verify OTP",
                            () => _handleVerifyEmailOTP(
                              providerAuth: providerAuth,
                              provider: provider,
                              constraints: constraints,
                              context: context,
                            ),
                          ),

                    SizedBox(height: scale(0.0)),

                    //* Sign In Text
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
