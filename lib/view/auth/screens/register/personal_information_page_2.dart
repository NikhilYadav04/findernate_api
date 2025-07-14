import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/core/utils/validator.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets_2.dart';

class PersonalInformationPage2 extends StatefulWidget {
  const PersonalInformationPage2({super.key});

  @override
  State<PersonalInformationPage2> createState() =>
      _PersonalInformationPage2State();
}

class _PersonalInformationPage2State extends State<PersonalInformationPage2> {
  //* to toggle visibility
  bool isObSecure = false;

  bool _isLoading = false;

//* Call Register API CAL:
  void _handleRegisterUser({
    required BuildContext context,
    required BoxConstraints constraints,
    required ProviderRegister provider,
    required ProviderAuth providerAuth,
  }) async {
    String? usernameError =
        Validator.usernameValidator(provider.usernameController.text);
    String? passwordError =
        Validator.passwordBasicValidator(provider.passwordController.text);

    bool isFUllNameValid = usernameError == null;
    bool isPasswordValid = passwordError == null;

    if (isPasswordValid && isFUllNameValid) {
      setState(() {
        _isLoading = true;
      });

      bool isSuccess = await providerAuth.register(
        fullName: provider.personalFullNameController.text.toString(),
        username: provider.personalFullNameController.text.toString(),
        email: provider.personalEmailController.text.toString(),
        password: provider.passwordController.text.toString(),
        confirmPassword: provider.passwordController.text.toString(),
        phoneNumber: provider.phoneFormController.text.toString(),
        dateOfBirth: provider.personalDOBController.text.toString(),
        gender: provider.gender,
        context: context,
      );

      setState(() {
        _isLoading = false;
      });

      if (isSuccess) {
        Navigator.pushNamed(
          context,
          '/otp-email-register',
          arguments: {
            'transition': TransitionType.rightToLeft,
            'duration': 300,
          },
        );
      }
    } else {
      if (!isFUllNameValid) {
        showSnackBar(usernameError, context, isError: true);
        return;
      }

      if (!isPasswordValid) {
        showSnackBar(passwordError, context, isError: true);
        return;
      }
    }
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
                      'Select a Username',
                      style: _style.copyWith(
                        fontSize: scale(0.032),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: scale(0.012)),
                    Text(
                      'Help secure your account',
                      style: _style.copyWith(
                        fontSize: scale(0.023),
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: scale(0.045)),

                    authFieldLabelWithAsterisk("Phone", constraints),
                    SizedBox(height: scale(0.008)),

                    phoneField(
                        constraints: constraints,
                        formKey: provider.phoneFormKey,
                        controller: provider.phoneFormController,
                        provider: provider),

                    //* Fields And Label
                    authFieldLabelWithAsterisk("Username", constraints),
                    SizedBox(height: scale(0.008)),

                    inputFieldRegister(
                        constraints: constraints,
                        formKey: provider.usernameFormKey,
                        controller: provider.usernameController,
                        validator: Validator.usernameValidator,
                        key: 'username',
                        isError: provider.hasError('username'),
                        provider: provider),

                    SizedBox(height: scale(0.025)),

                    authFieldLabelWithAsterisk("Password", constraints),

                    SizedBox(height: scale(0.008)),
                    passwordFieldRegister(
                        constraints: constraints,
                        formKey: provider.passwordFormKey,
                        controller: provider.passwordController,
                        validator: Validator.passwordBasicValidator,
                        key: 'password',
                        isError: provider.hasError('password'),
                        provider: provider,
                        isObSecure: isObSecure,
                        onTap: () => setState(() {
                              isObSecure = !isObSecure;
                            })),

                    Spacer(),

                    //* Buttons
                    _isLoading
                        ? Center(
                            child: SpinKitCircle(
                              color: AppColors.appYellow,
                              size: constraints.maxHeight * 0.05,
                            ),
                          )
                        : authButton(
                            constraints,
                            "Done",
                            () => _handleRegisterUser(
                                providerAuth: providerAuth,
                                constraints: constraints,
                                context: context,
                                provider: provider)),

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

// Updated label widget with red asterisk
Widget authFieldLabelWithAsterisk(String text, BoxConstraints constraints) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: constraints.maxHeight * 0.023,
            color: Colors.grey.shade700,
          ),
        ),
        TextSpan(
          text: ' *',
          style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: constraints.maxHeight * 0.023,
            color: Colors.red,
          ),
        ),
      ],
    ),
  );
}

// Updated input field widget with red border only (no error text)

