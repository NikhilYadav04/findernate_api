import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/view/settings/screen/profile_settings_screen_2.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          bottom: false,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  //* App Bar
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    leading: GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: screenHeight * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    floating: true,
                    snap: true,
                    title: Text(
                      "Account Settings",
                      style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          color: Colors.black,
                          fontSize: screenHeight * 0.024,
                          fontWeight: FontWeight.bold),
                    ),
                    toolbarHeight: screenHeight * 0.08,
                  ),
                ];
              },
              body: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.00,
                  horizontal: screenHeight * 0.00,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: screenHeight * 0.01),

                    //* Edit profile
                    listCard(
                      'Edit Profile',
                      "assets/images/settings/ic_notes.svg",
                      Colors.black,
                      screenHeight,
                      screenWidth,
                      () {
                        print('Navigate to Account');
                      },
                      isSvg: true,
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    //* Change Password
                    listCard(
                      'Change Password',
                      "assets/images/settings/ic_notes.svg",
                      Colors.black,
                      screenHeight,
                      screenWidth,
                      () {
                        _showChangePasswordConfirmationDialog(context);
                      },
                      isSvg: true,
                    ),
                    SizedBox(height: screenHeight * 0.01),

                    //* Delete Account
                    listCard(
                      'Delete Account',
                      "assets/images/settings/ic_notes.svg",
                      Colors.black,
                      screenHeight,
                      screenWidth,
                      () {
                        Navigator.pushNamed(
                          context,
                          '/delete-account',
                          arguments: {
                            'transition': TransitionType.rightToLeft,
                            'duration': 200,
                          },
                        );
                      },
                      isSvg: true,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                  ],
                ),
              ))),
    );
  }
}

//* Show Change Password Confirmation Dialog
Future<bool?> _showChangePasswordConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColors.appGradient1, AppColors.appGradient2],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: Text(
            'Change Password',
            style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontWeight: FontWeight.bold,
              color: Colors.white, // This is ignored due to ShaderMask
            ),
          ),
        ),
        content: Text(
          'Do you want to change your password?',
          style: TextStyle(
            fontFamily: "Poppins-Medium",
            color: Colors.grey.shade700,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'No',
              style: TextStyle(
                fontFamily: "Poppins-Medium",
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.appGradient1, AppColors.appGradient2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: () {
                final authProvider =
                    Provider.of<ProviderAuth>(context, listen: false);
                String email = authProvider.currentUserData?.email ?? '';
                Logger().d("${email}");

                if (email == '' || email.isEmpty) {
                  Navigator.of(context)
                      .pop(false); // Pop with false since no email
                } else {
                  //* First pop the dialog
                  Navigator.of(context).pop(true);

                  //* Then send OTP and navigate
                  authProvider.sendVerificationOtp(
                      email: email, context: context);

                  Navigator.pushNamed(
                    context,
                    '/otp-change-password',
                    arguments: {
                      'transition': TransitionType.rightToLeft,
                      'email': email,
                      'duration': 200,
                    },
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Yes',
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
