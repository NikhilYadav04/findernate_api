import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_media_clone/controller/profile/profile_controller.dart';
import 'package:social_media_clone/view/auth/screens/others/change_password_otp.dart';
import 'package:social_media_clone/view/auth/screens/others/change_password_screen.dart';
import 'package:social_media_clone/view/auth/screens/others/delete_account_screen.dart';
import 'package:social_media_clone/view/auth/screens/register/otp_page.dart';
import 'package:social_media_clone/view/auth/screens/register/personal_information_page_1.dart';
import 'package:social_media_clone/view/auth/screens/register/personal_information_page_2.dart';
import 'package:social_media_clone/view/auth/screens/register/register_phone_page.dart';
import 'package:social_media_clone/view/auth/screens/signin/forgot_email_card.dart';
import 'package:social_media_clone/view/auth/screens/signin/forgot_password_page.dart';
import 'package:social_media_clone/view/auth/screens/signin/sign_in_page.dart';
import 'package:social_media_clone/view/auth/screens/welcome/welcome_register.dart';
import 'package:social_media_clone/view/auth/screens/welcome/welcome_signin.dart';
import 'package:social_media_clone/view/bottom_bar_screen.dart';
import 'package:social_media_clone/view/content/screens/post/add/post_root_screen.dart';
import 'package:social_media_clone/view/content/screens/post/display/normal_post_display.dart';
import 'package:social_media_clone/view/content/screens/reel/reel_root_screen.dart';
import 'package:social_media_clone/view/home/screen/story_view_screen.dart';
import 'package:social_media_clone/view/onboarding/screens/onboard_root_screen.dart';
import 'package:social_media_clone/view/onboarding/screens/splash_screen.dart';
import 'package:social_media_clone/view/profile/screen/image_crop_screen.dart';
import 'package:social_media_clone/view/profile/screen/profile_edit_screen.dart';
import 'package:social_media_clone/view/settings/screen/account_settings_screen.dart';
import 'package:social_media_clone/view/settings/screen/profile_settings_screen_2.dart';
import 'package:vs_story_designer/vs_story_designer.dart';

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
    //  page = UniversalPostDemo();
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
    case '/delete-account':
      page = DeleteAccountPage();
      break;
    case '/otp-change-password':
      final email = args?['email'];
      page = PasswordChangeOtpPage(email: email);
      break;
    case '/change-password':
      page = ChangePasswordScreen();
      break;
    case '/forget-card':
      page = ForgotEmailCard();
      break;
    case '/bottom-bar':
      page = BottomBarScreen();
    case '/profile-edit-screen':
      final isProfile = args?['isProfile'];
      page = EditProfileScreen(
        isProfile: isProfile,
      );
      break;
    case '/image-crop-screen':
      File image = args?['image'] ?? '';
      final ProviderProfile provider = args?['provider'];
      page = SimpleCropScreen(
        image: image,
        provider: provider,
      );
      break;
    case '/settings-screen':
      final isBusiness = args?['isBusiness'] ?? false;
      final isBusinessDetails = args?['isBusinessDetails'] ?? false;
      page = ProfileSettingsScreen2(
        isBusiness: isBusiness,
        isBusinessDetails: isBusinessDetails,
      );
      break;
    case '/account-settings-screen':
      page = AccountSettingsScreen();
      break;
    case '/post-add-screen':
      page = CreatePostScreen();
      break;
    case '/reel-add-screen':
      page = CreateReelScreen();
      break;
    case '/add-story-screen':
      final argsMap = args ?? <String, dynamic>{};
      final centerText =
          argsMap['title'] as String? ?? 'Start Creating Your Story';
      final imagePath = argsMap['imagePath'] as String?;
      Widget middleBottomWidget =
          argsMap['middleBottomWidget'] as Widget? ?? SizedBox();
      Widget onDoneButtonStyle =
          argsMap['onDoneButtonStyle'] as Widget? ?? SizedBox();

      page = VSStoryDesigner(
        middleBottomWidget: Center(
          child: middleBottomWidget,
        ),
        centerText: centerText,
        themeType: ThemeType.dark,
        galleryThumbnailQuality: 250,
        mediaPath: imagePath,
        onDone: (uri) {},
        onDoneButtonStyle: onDoneButtonStyle,
      );
      break;
    case '/story-view':
      page = StoryView();
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
