import 'package:flutter/material.dart';
import 'package:social_media_clone/view/auth/screens/register/otp_page.dart';
import 'package:social_media_clone/view/auth/screens/register/personal_information_page_1.dart';
import 'package:social_media_clone/view/auth/screens/register/personal_information_page_2.dart';
import 'package:social_media_clone/view/auth/screens/register/register_phone_page.dart';
import 'package:social_media_clone/view/auth/screens/signin/forgot_email_card.dart';
import 'package:social_media_clone/view/auth/screens/signin/forgot_password_page.dart';
import 'package:social_media_clone/view/auth/screens/signin/sign_in_page.dart';
import 'package:social_media_clone/view/auth/screens/test/auth_test.dart';
import 'package:social_media_clone/view/auth/screens/welcome/welcome_register.dart';
import 'package:social_media_clone/view/auth/screens/welcome/welcome_signin.dart';
import 'package:social_media_clone/view/onboarding/screens/onboard_root_screen.dart';
import 'package:social_media_clone/view/onboarding/screens/splash_screen.dart';

enum TransitionType {
  rightToLeft,
  leftToRight,
  bottomToTop,
  topToBottom,
  fade,
}

///* Builds a PageRoute with the given [child], using [type] and [duration].
PageRouteBuilder<dynamic> buildPageRoute(
  Widget child, {
  TransitionType type = TransitionType.rightToLeft,
  Duration duration = const Duration(milliseconds: 200),
}) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => child,
    transitionDuration: duration,
    transitionsBuilder: (_, animation, __, child) {
      final curveAnim = CurvedAnimation(
        parent: animation,
        curve: Curves.easeInOut,
      );

      switch (type) {
        case TransitionType.leftToRight:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
        case TransitionType.topToBottom:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
        case TransitionType.bottomToTop:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
        case TransitionType.fade:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        case TransitionType.rightToLeft:
        default:
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(curveAnim),
            child: child,
          );
      }
    },
  );
}

/// Centralized route generator that reads transition type & duration
Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments as Map<String, dynamic>?;
  final type = args?['transition'] as TransitionType?;
  final ms = args?['duration'] as int?;
  final duration = ms != null ? Duration(milliseconds: ms) : null;

  Widget page;
  switch (settings.name) {
    case '/':
      page = SplashScreen();
      //page = AuthTestingPage();
      break;
    case '/onboard':
      page = OnboardRootScreen();
      break;
    case '/welcome-signin':
      page = WelcomeSignin();
      break;
    case '/welcome-register':
      page = WelcomeRegister();
      break;
    case '/sign-in':
      page = SignInPage();
      break;
    case '/forgot-pass':
      page = ForgotPasswordPage();
      break;
    case '/register-phone':
      page = RegisterPhonePage();
      break;
    case '/personal-info-1':
      page = PersonalInformationPage1();
      break;
    case '/personal-info-2':
      page = PersonalInformationPage2();
      break;
    case '/otp-email-register':
      page = VerifyEmailOtpPage(email: "");
      break;
    case '/forget-card':
      page = ForgotEmailCard();
      break;

    default:
      page = Text("No Pages Available");
      break;
    // page = Scaffold(
    //     body: Center(child: Text('No route defined for ${settings.name}')));
  }

  return buildPageRoute(
    page,
    type: type ?? TransitionType.rightToLeft,
    duration: duration ?? const Duration(milliseconds: 200),
  );
}



// Example of pushing with custom transition & duration:
// Navigator.pushNamed(
//   context,
//   '/sign-in',
//   arguments: {
//     'transition': TransitionType.fade,
//     'duration': 300,
//   },
// );
