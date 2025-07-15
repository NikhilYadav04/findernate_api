// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets_3.dart';
import 'package:social_media_clone/view/settings/widgets/popup_card.dart';

class ProfileSettingsScreen2 extends StatefulWidget {
  final bool isBusiness;
  final bool isBusinessDetails;
  const ProfileSettingsScreen2({
    Key? key,
    required this.isBusiness,
    required this.isBusinessDetails,
  }) : super(key: key);

  @override
  State<ProfileSettingsScreen2> createState() => _ProfileSettingsScreen2State();
}

class _ProfileSettingsScreen2State extends State<ProfileSettingsScreen2> {
  String _selectedLanguage = 'English';
  bool _isMuted = false;
  bool _hideAddress = false;
  bool _hideNumber = false;

  Future<void> _logout() async {}

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // top:false,
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return NestedScrollView(
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
                          size: constraints.maxHeight * 0.035,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    centerTitle: true,
                    floating: true,
                    snap: true,
                    title: postAddAppBar(
                      maxHeight: constraints.maxHeight,
                      maxWidth: constraints.maxWidth,
                      title: 'Settings',
                    ),
                    toolbarHeight: constraints.maxHeight * 0.08,
                  ),
                ];
              },
              body: SingleChildScrollView(
                // Changed Column to SingleChildScrollView
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.00,
                    horizontal: screenHeight * 0.00,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      listCard(
                          !(widget.isBusiness)
                              ? ModelSettings.settingsList[1].label
                              : "Upgrade Business Profile",
                          ModelSettings.settingsList[1].svg,
                          Colors.black,
                          screenHeight,
                          screenWidth, () {
                        // //* nav to Add Plan
                        // Navigator.pushNamed(
                        //   context,
                        //   '/add-business-plan',
                        //   arguments: {
                        //     'transition': TransitionType.rightToLeft,
                        //     'duration': 300,
                        //     'isUpgrade': !(widget.isBusiness) ? false : true
                        //   },
                        // );
                      }),

                      SizedBox(height: screenHeight * 0.01),

                      //* Language
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/settings/ic_text.svg",
                          color: Colors.black,
                          height: screenHeight * 0.025,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Language',
                          style: GoogleFonts.roboto(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w500,
                            fontSize: screenHeight * 0.022,
                          ),
                        ),
                        trailing: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedLanguage,
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.black,
                                size: screenHeight * 0.025),
                            items: <String>[
                              'English',
                              'Spanish',
                              'French',
                              'German'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.022)),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedLanguage = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      //* Mute Notification
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/images/settings/ic_sound.svg",
                          color: Colors.black,
                          height: screenHeight * 0.025,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          'Mute Notification',
                          style: GoogleFonts.roboto(
                            color: Colors.grey.shade900,
                            fontWeight: FontWeight.w500,
                            fontSize: screenHeight * 0.022,
                          ),
                        ),
                        trailing: Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            value: _isMuted,
                            onChanged: (bool value) {
                              setState(() {
                                _isMuted = value;
                              });
                            },
                            activeColor: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      //* Custom Notification
                      listCard(
                        'Custom Notification',
                        "assets/images/settings/ic_notify.svg",
                        Colors.black,
                        screenHeight,
                        screenWidth,
                        () {
                          print('Navigate to Custom Notification');
                        },
                        isSvg: true,
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      //* Account
                      listCard(
                        'Account',
                        "assets/images/settings/ic_notes.svg",
                        Colors.black,
                        screenHeight,
                        screenWidth,
                        () {
                          Navigator.pushNamed(
                            context,
                            '/account-settings-screen',
                            arguments: {
                              'transition': TransitionType.rightToLeft,
                              'duration': 300,
                            },
                          );
                          print('Navigate to Account');
                        },
                        isSvg: true,
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      //* About App
                      listCard(
                        'About App',
                        "assets/images/settings/ic_layers.svg",
                        Colors.black,
                        screenHeight,
                        screenWidth,
                        () {
                          print('Navigate to About App');
                        },
                        isSvg: true,
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      //* Help Center
                      listCard(
                        'Help Center',
                        "assets/images/settings/ic_help.svg",
                        Colors.black,
                        screenHeight,
                        screenWidth,
                        () {
                          print('Navigate to Help Center');
                        },
                        isSvg: true,
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                        ),
                        child: Divider(
                          thickness: 1,
                          color: Colors.grey.shade400,
                          height: 1,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.025),

                      widget.isBusiness
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //* Business Info
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.04,
                                  ),
                                  child: postAddLabel(
                                      "Business Info", screenHeight),
                                ),

                                SizedBox(height: screenHeight * 0.01),

                                //* View Your Business Details
                                widget.isBusinessDetails
                                    ? listCard(
                                        'View Your Business Details',
                                        "assets/images/settings/ic_users.svg",
                                        Colors.black,
                                        screenHeight,
                                        screenWidth,
                                        () {
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   '/view-business-1-screen',
                                          //   arguments: {
                                          //     'transition':
                                          //         TransitionType.rightToLeft,
                                          //     'duration': 300,
                                          //   },
                                          // );
                                        },
                                        isSvg: true,
                                      )
                                    : SizedBox.shrink(),
                                widget.isBusinessDetails
                                    ? SizedBox(height: screenHeight * 0.01)
                                    : SizedBox.shrink(),

                                //* Ad Your Business Details
                                !(widget.isBusinessDetails)
                                    ? listCard(
                                        'Add Your Business Details',
                                        Icons.person_pin_outlined,
                                        Colors.black,
                                        screenHeight,
                                        screenWidth,
                                        () {
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   '/add-business-1-screen',
                                          //   arguments: {
                                          //     'transition':
                                          //         TransitionType.rightToLeft,
                                          //     'duration': 300,
                                          //   },
                                          // );
                                        },
                                        isSvg: false,
                                      )
                                    : SizedBox.shrink(),
                                !(widget.isBusinessDetails)
                                    ? SizedBox(height: screenHeight * 0.01)
                                    : SizedBox.shrink(),

                                //* KYC Update: Complete your KYC
                                listCard(
                                  'Complete your KYC',
                                  "assets/images/settings/ic_users.svg",
                                  Colors.black,
                                  screenHeight,
                                  screenWidth,
                                  () {
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   '/upload-kyc-screen',
                                    //   arguments: {
                                    //     'transition':
                                    //         TransitionType.rightToLeft,
                                    //     'duration': 200,
                                    //   },
                                    // );
                                  },
                                  isSvg: true,
                                ),
                                SizedBox(height: screenHeight * 0.01),

                                //* Promote Your Business
                                listCard(
                                  'Promote Your Business',
                                  "assets/images/settings/ic_security.svg",
                                  Colors.black,
                                  screenHeight,
                                  screenWidth,
                                  () {
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   '/business-post',
                                    //   arguments: {
                                    //     'transition':
                                    //         TransitionType.rightToLeft,
                                    //     'duration': 200,
                                    //   },
                                    // );
                                  },
                                  isSvg: true,
                                ),
                                SizedBox(height: screenHeight * 0.01),

                                //* Edit Your Business Details
                                widget.isBusinessDetails
                                    ? listCard(
                                        'Edit Your Business Details',
                                        "assets/images/settings/ic_security.svg",
                                        Colors.black,
                                        screenHeight,
                                        screenWidth,
                                        () {
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   '/edit-business-1-screen',
                                          //   arguments: {
                                          //     'transition':
                                          //         TransitionType.rightToLeft,
                                          //     'duration': 200,
                                          //   },
                                          // );
                                        },
                                      )
                                    : SizedBox.shrink(),
                                widget.isBusinessDetails
                                    ? SizedBox(height: screenHeight * 0.01)
                                    : SizedBox.shrink(),

                                // * Hide Address
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/images/settings/ic_pin.svg",
                                    color: Colors.black,
                                    height: screenHeight * 0.025,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    'Hide Address',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenHeight * 0.022,
                                    ),
                                  ),
                                  trailing: Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: _hideAddress,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _hideAddress = value;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.01),

                                // * Hide Number
                                ListTile(
                                  leading: SvgPicture.asset(
                                    "assets/images/settings/ic_phone.svg",
                                    color: Colors.black,
                                    height: screenHeight * 0.025,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    'Hide Number',
                                    style: GoogleFonts.roboto(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: screenHeight * 0.022,
                                    ),
                                  ),
                                  trailing: Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: _hideNumber,
                                      onChanged: (bool value) {
                                        setState(() {
                                          _hideNumber = value;
                                        });
                                      },
                                      activeColor: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      widget.isBusiness
                          ? SizedBox(height: screenHeight * 0.02)
                          : SizedBox.shrink(),

                      widget.isBusiness
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                              ),
                              child: Divider(
                                thickness: 1, // Adjusted thickness
                                color: Colors.grey.shade400,
                                height: 1,
                              ),
                            )
                          : SizedBox.shrink(),
                      widget.isBusiness
                          ? SizedBox(height: screenHeight * 0.015)
                          : SizedBox.shrink(),

                      //* Logout (activate business profile if already implemented)

                      listCard(
                        ModelSettings
                            .settingsList[0].label, // Assuming this is 'Logout'
                        ModelSettings.settingsList[0].svg,
                        ModelSettings.settingsList[0].color,
                        screenHeight,
                        screenWidth,
                        () {
                          Logger().d("Tapped");
                          _showLogoutConfirmationDialog(context);
                        },
                      ),

                      SizedBox(
                        height: screenHeight * 0.03,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget listCard(
  String title,
  dynamic iconData,
  Color color,
  double screenHeight,
  double screenWidth,
  void Function() onTap, {
  bool isSvg = true,
}) {
  return Container(
    child: ListTile(
      onTap: onTap,
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
        size: screenHeight * 0.025,
      ),
      leading: isSvg
          ? SvgPicture.asset(iconData as String, height: screenHeight * 0.026)
          : Icon(iconData as IconData,
              size: screenHeight * 0.026, color: color),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: screenHeight * 0.022,
        ),
      ),
    ),
  );
}

Widget postAddLabel(String text, double maxHeight) {
  return Text(
    text,
    style: GoogleFonts.roboto(
      fontSize: maxHeight * 0.028, // fixed font size
      color: const Color.fromARGB(255, 105, 105, 105),
      fontWeight: FontWeight.w700,
    ),
  );
}

TextStyle _textStyle2 = const TextStyle(fontFamily: "Poppins-Medium");

class ModelSettings {
  final String label;
  final String svg;
  final Color color;

  ModelSettings({required this.label, required this.svg, required this.color});

  static List<ModelSettings> settingsList = [
    ModelSettings(
        label: 'Logout', svg: 'assets/svg/logout.svg', color: Colors.red),
    ModelSettings(
        label: 'Activate Business Profile',
        svg: 'assets/svg/add.svg',
        color: Colors.grey.shade800),
  ];
}

//* Show Logout Confirmation Dialog
//* Show Logout Confirmation Dialog
Future<bool?> _showLogoutConfirmationDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Logout',
          style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        content: Text(
          'Are you sure you want to logout from your account?',
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
          ElevatedButton(
            onPressed: () async {
              final provider =
                  Provider.of<ProviderAuth>(context, listen: false);
              provider.logout(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
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
        ],
      );
    },
  );
}
