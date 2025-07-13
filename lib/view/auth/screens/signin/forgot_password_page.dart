import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/validator.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  //* to toggle visibility
  bool isObSecure = false;

  //* Forgot Password API Call
  void _handleForgetPassword({
    required BuildContext context,
    required BoxConstraints constraints,
    required ProviderSignIn provider,
  }) async {
    final isEmailValid =
        provider.forgetPassEmailFormKey.currentState?.validate() ?? false;
    final isPasswordValid =
        provider.forgetPassLastPasswordFormKey.currentState?.validate() ??
            false;
    final isPhoneValid =
        provider.forgetPassPhoneFormKey.currentState?.validate() ?? false;

    if (isEmailValid && isPasswordValid && isPhoneValid) {
      final success = true;
      if (success) {
        Navigator.pushNamed(context, '/forget-card');
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

            return Consumer<ProviderSignIn>(
              builder: (context, provider, _) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: hPadding(0.04)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scale(0.03)),
                      InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child:
                              Icon(Icons.arrow_back_ios, size: scale(0.035))),
                      SizedBox(height: scale(0.04)),
                      Text(
                        'Forgot Password',
                        style: _style.copyWith(
                          fontSize: scale(0.032),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: scale(0.012)),
                      Text(
                        'Let’s help recover your account',
                        style: _style.copyWith(
                          fontSize: scale(0.023),
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: scale(0.030)),

                      //* Fields And Label

                      SizedBox(height: scale(0.025)),

                      authFieldLabel("Email", constraints),

                      SizedBox(height: scale(0.008)),
                      inputFieldSignIn(
                          hintext: '',
                          constraints: constraints,
                          formKey: provider.forgetPassEmailFormKey,
                          controller: provider.forgetPassEmailController,
                          validator: Validator.emailValidator,
                          key: 'email',
                          isError: provider.hasError('email'),
                          provider: provider),

                      SizedBox(height: scale(0.025)),

                      authFieldLabel("Phone Number", constraints),

                      SizedBox(height: scale(0.008)),
                      inputFieldSignIn(
                          hintext: '',
                          keyboardType: TextInputType.phone,
                          constraints: constraints,
                          formKey: provider.forgetPassPhoneFormKey,
                          controller: provider.forgetPassPhoneController,
                          validator: Validator.phoneValidator,
                          key: 'phone',
                          isError: provider.hasError('phone'),
                          provider: provider),

                      SizedBox(height: scale(0.025)),

                      authFieldLabel("Last Remembered Password", constraints),

                      SizedBox(height: scale(0.008)),
                      passwordFieldSignIn(
                          helper: '',
                          constraints: constraints,
                          formKey: provider.forgetPassLastPasswordFormKey,
                          controller: provider.forgetPassLastPasswordController,
                          validator: Validator.passwordValidator,
                          key: 'remember-password',
                          isError: provider.hasError('remember-password'),
                          provider: provider,
                          isObSecure: isObSecure,
                          onTap: () => setState(() {
                                isObSecure = !isObSecure;
                              })),

                      Spacer(),

                      //* Buttons
                      provider.isLoading
                          ? Center(
                              child: SpinKitCircle(
                                color: AppColors.appYellow,
                                size: constraints.maxHeight * 0.05,
                              ),
                            )
                          : authButton(
                              constraints,
                              "Done",
                              () => _handleForgetPassword(
                                  constraints: constraints,
                                  provider: provider,
                                  context: context)),

                      SizedBox(height: scale(0.01)),

                      //* No Account Text
                      noAccountSignUpText(constraints, () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/register-phone',
                          arguments: {
                            'transition': TransitionType.bottomToTop,
                            'duration': 300,
                          },
                        );
                      }),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
}
