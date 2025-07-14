import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //* to toggle visibility
  bool isObSecure = false;
  bool _isLoading = false;

//* Login API Call
  //* Login API Call
  void _handleLogin({
    required BuildContext context,
    required BoxConstraints constraints,
    required ProviderSignIn provider,
    required ProviderAuth providerAuth,
  }) async {
    bool isUsernameValid = provider.userNameController.text.trim().isNotEmpty;
    bool isPasswordValid = provider.passwordController.text.trim().isNotEmpty;

    if (isUsernameValid && isPasswordValid) {
      setState(() {
        _isLoading = true;
      });

      bool loginSuccess = await providerAuth.login(
        usernameOrEmail: provider.userNameController.text.trim(),
        password: provider.passwordController.text.trim(),
        context: context,
      );

      setState(() {
        _isLoading = false;
      });

      if (loginSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/welcome-signin',
          (route) => false,
          arguments: {
            'transition': TransitionType.fade,
            'duration': 300,
          },
        );
      }

      return;
    } else {
      if (!isUsernameValid) {
        showSnackBar("Please enter your username or email", context,
            isError: true);
        return;
      }

      if (!isPasswordValid) {
        showSnackBar("Please enter your password", context, isError: true);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext screenContext) {
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

            return Consumer<ProviderSignIn>(builder: (context, provider, _) {
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
                      'Sign In',
                      style: _style.copyWith(
                        fontSize: scale(0.032),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: scale(0.012)),
                    Text(
                      'Enter your credentials',
                      style: _style.copyWith(
                        fontSize: scale(0.023),
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: scale(0.045)),

                    //* Fields And Label
                    authFieldLabel("Username or Email", constraints),
                    SizedBox(height: scale(0.007)),

                    inputFieldSignIn(
                        hintext: '',
                        constraints: constraints,
                        formKey: provider.userNameFormKey,
                        controller: provider.userNameController,
                        validator: dummyNameValidator,
                        provider: provider,
                        key: 'username',
                        isError: provider.hasError('username')),

                    SizedBox(height: scale(0.025)),

                    authFieldLabel("Password", constraints),

                    SizedBox(height: scale(0.007)),
                    passwordFieldSignIn(
                        helper: '',
                        constraints: constraints,
                        formKey: provider.passwordFormKey,
                        controller: provider.passwordController,
                        validator: dummyNameValidator,
                        isObSecure: isObSecure,
                        provider: provider,
                        key: 'password',
                        isError: provider.hasError('password'),
                        onTap: () => setState(() {
                              isObSecure = !isObSecure;
                            })),
                    SizedBox(height: scale(0.01)),

                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //       onPressed: () {
                    //         Navigator.pushNamed(context, '/forgot-pass');
                    //       },
                    //       child: ShaderMask(
                    //         shaderCallback: (bounds) => LinearGradient(
                    //           colors: [
                    //             AppColors.appGradient1,
                    //             AppColors.appGradient2,
                    //           ],
                    //           begin: Alignment.topLeft,
                    //           end: Alignment.bottomRight,
                    //         ).createShader(Rect.fromLTWH(
                    //             0, 0, bounds.width, bounds.height)),
                    //         child: Text(
                    //           'Forgot Password?',
                    //           style: _style.copyWith(
                    //             fontSize: scale(0.02),
                    //             color: Colors
                    //                 .white, // This is ignored due to ShaderMask
                    //           ),
                    //         ),
                    //       )),
                    // ),
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
                            "Sign In",
                            () => _handleLogin(
                                constraints: constraints,
                                context: context,
                                providerAuth: providerAuth,
                                provider: provider)),

                    //* No Account Text
                    noAccountSignUpText(constraints, () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/personal-info-1',
                        arguments: {
                          'transition': TransitionType.rightToLeft,
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

  String? dummyNameValidator(String? name) {
    // Always passes validation
    return null;
  }

  TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
}
