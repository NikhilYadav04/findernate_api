// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/controller/profile/profile_controller.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/core/utils/validator.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/http/models/model_user.dart';
import 'package:social_media_clone/view/profile/widgets/edit_profile_widgets.dart';
import 'package:social_media_clone/view/profile/widgets/profile_screen_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  final bool isProfile;
  const EditProfileScreen({
    Key? key,
    required this.isProfile,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ProviderAuth>(context, listen: false);
      final providerProfile =
          Provider.of<ProviderProfile>(context, listen: false);

      UserModel? userModel = provider.currentUserData;

      if (userModel != null) {
        providerProfile.fullNameController.text = userModel.fullName;
        providerProfile.emailController.text = userModel.email;
        providerProfile.dateController.text = userModel.dateOfBirth;
        providerProfile.gender = userModel.gender;
        providerProfile.bioController.text = userModel.bio;
        providerProfile.profileImageController.text = userModel.profileImageUrl;
        if (userModel.location != "") {
          providerProfile.locationController.text = userModel.location;
        } else {
          providerProfile.locationController.text = "Add Location";
        }
      }
    });
  }

  bool _isLoading = false;

  void _editProfile() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final providerProfile =
        Provider.of<ProviderProfile>(context, listen: false);

    bool isFullNameValid =
        Validator.fullNameValidator(providerProfile.fullNameController.text) ==
            null;

    if (isFullNameValid) {
      bool success = await providerProfile.updateUserProfile(context: context);

      if (success) {
        Navigator.pop(context);
      }
    } else {
      showSnackBar(
          Validator.fullNameValidator(
                  providerProfile.fullNameController.text) ??
              "Please Enter your Full Name",
          context,
          isError: true);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Consumer<ProviderProfile>(
            builder: (context, provider, _) {
              return NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      //* App Bar
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        leading: GestureDetector(
                          onTap: () {
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                              provider.imageFIle = null;
                              provider.clearAllData();
                              provider.clearFieldError();
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
                        toolbarHeight: screenHeight * 0.08,
                        snap: true,
                        floating: true,
                        centerTitle: true,
                        title: profileEditAppBar(
                            maxHeight: screenHeight, maxWidth: screenWidth),
                      )
                    ];
                  },
                  body: SingleChildScrollView(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),

                          //* Edit Profile Picture
                          GestureDetector(
                            onTap: () async {
                              await provider.pickImageFromGallery();

                              provider.imageFIle == null
                                  ? null
                                  : Navigator.pushNamed(
                                      context,
                                      '/image-crop-screen',
                                      arguments: {
                                        'transition': TransitionType.fade,
                                        'provider': provider,
                                        'image': provider.imageFIle,
                                        'duration': 300,
                                      },
                                    );
                            },
                            child: editProfilePhotoWidget(
                                imageFile: provider.imageFIle,
                                maxHeight: screenHeight,
                                maxWidth: screenWidth,
                                imageURL: provider
                                            .profileImageController.text ==
                                        ""
                                    ? "https://static.thenounproject.com/png/630737-200.png"
                                    : provider.profileImageController.text),
                          ),

                          SizedBox(
                            height: screenHeight * 0.028,
                          ),

                          Text(
                            "Your Profile Details",
                            style: _textStyle2.copyWith(
                                fontSize:
                                    screenHeight * 0.025, // fixed font size
                                color: Colors.grey.shade900,
                                fontWeight: FontWeight.w700),
                          ),

                          //* Enable Business Profile

                          //* Slider to enable
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text(
                          //       "Business Profile",
                          //       style: _textStyle2.copyWith(
                          //           fontSize:
                          //               screenHeight * 0.025, // fixed font size
                          //           color: Colors.grey.shade900,
                          //           fontWeight: FontWeight.w700),
                          //     ),
                          //     //* If business profile exists already switch always on
                          //     GestureDetector(
                          //         onTap: () {
                          //           // print("Tapped");
                          //           // //* nav to Add Plan
                          //           // Navigator.pushNamed(
                          //           //   context,
                          //           //   '/add-business-plan',
                          //           //   arguments: {
                          //           //     'transition': TransitionType.rightToLeft,
                          //           //     'duration': 300,
                          //           //   },
                          //           // );
                          //         },
                          //         child: switchWidget(false, (val) {
                          //           // Navigator.pushNamed(
                          //           //   context,
                          //           //   '/add-business-plan',
                          //           //   arguments: {
                          //           //     'transition': TransitionType.rightToLeft,
                          //           //     'duration': 300,
                          //           //   },
                          //           // );
                          //         })),
                          //   ],
                          // ),

                          // SizedBox(
                          //   height: screenHeight * 0.01,
                          // ),

                          // //* Add Business Category
                          // AnimatedContainer(
                          //   curve: Curves.easeInOut,
                          //   duration: Duration(milliseconds: 300),
                          //   child: Column(
                          //     //* Select Business Name
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       //* Select Sub-Category
                          //       profileLabel("Enter Sub-Category", screenHeight,
                          //           isRequired: true),
                          //       SizedBox(
                          //         height: screenHeight * 0.018,
                          //       ),
                          //       businessSubCategoryField(
                          //           formKey: provider.subCatKey1,
                          //           maxHeight: screenHeight,
                          //           maxWidth: screenWidth,
                          //           controller: provider.subCatController1,
                          //           validator: dummyNameValidator,
                          //           provider: provider,
                          //           key: 'sub1',
                          //           isError: provider.hasError('sub1'),
                          //           label: 'Sub-Category 1 (e.g., Salon)'),
                          //       SizedBox(
                          //         height: screenHeight * 0.025,
                          //       ),

                          //       businessSubCategoryField(
                          //           formKey: provider.subCatKey2,
                          //           maxHeight: screenHeight,
                          //           maxWidth: screenWidth,
                          //           controller: provider.subCatController2,
                          //           validator: dummyNameValidator1,
                          //           provider: provider,
                          //           key: 'sub2',
                          //           isError: provider.hasError('sub2'),
                          //           label: 'Sub-Category 2 (e.g., Gym)'),
                          //       SizedBox(
                          //         height: screenHeight * 0.025,
                          //       ),
                          //       businessSubCategoryField(
                          //           formKey: provider.subCatKey3,
                          //           maxHeight: screenHeight,
                          //           maxWidth: screenWidth,
                          //           controller: provider.subCatController3,
                          //           validator: dummyNameValidator21,
                          //           provider: provider,
                          //           key: 'sub3',
                          //           isError: provider.hasError('sub3'),
                          //           label: 'Sub-Category 3 (e.g., Bakery)'),
                          //     ],
                          //   ),
                          // ),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),

                          //* Add Username
                          profileLabel("Full Name", screenHeight,
                              isRequired: true),
                          SizedBox(
                            height: screenHeight * 0.012,
                          ),
                          profileEditInputField(
                              formKey: provider.fullNameKey,
                              maxHeight: screenHeight,
                              maxWidth: screenWidth,
                              controller: provider.fullNameController,
                              validator: Validator.fullNameValidator,
                              provider: provider,
                              key: 'username',
                              isError: provider.hasError('username'),
                              label: ''),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),

                          //* Add Email
                          profileLabel("Email", screenHeight, isRequired: true),
                          SizedBox(
                            height: screenHeight * 0.012,
                          ),
                          profileEditInputField(
                              readOnly: true,
                              formKey: provider.emailKey,
                              maxHeight: screenHeight,
                              maxWidth: screenWidth,
                              controller: provider.emailController,
                              validator: Validator.emailValidator,
                              provider: provider,
                              key: 'email',
                              isError: provider.hasError('email'),
                              label: ''),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),

                          //* Add Email
                          profileLabel("Location", screenHeight,
                              isRequired: true),
                          SizedBox(
                            height: screenHeight * 0.012,
                          ),
                          locationDynamicField(
                            formKey: provider.locationKey,
                            maxHeight: screenHeight,
                            maxWidth: screenWidth,
                            controller: provider.locationController,
                            validator: dummyNameValidator,
                            provider: provider,
                            key: 'location',
                            isError: provider.hasError('location'),
                          ),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),

                          //* Add DOB and Gender
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    profileLabel("DOB", screenHeight,
                                        isRequired: true),
                                    SizedBox(height: screenHeight * 0.015),
                                    profileEditDateField(
                                        maxHeight: screenHeight,
                                        maxWidth: screenWidth,
                                        formKey: provider.dateKey,
                                        controller: provider.dateController,
                                        validator: Validator.usernameValidator,
                                        context: context,
                                        onTap: provider.setDate)
                                  ],
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    profileLabel("Gender", screenHeight,
                                        isRequired: true),
                                    SizedBox(height: screenHeight * 0.015),
                                    editProfileGenderField(
                                        maxHeight: screenHeight,
                                        maxWidth: screenWidth,
                                        context: context,
                                        provider: provider)
                                  ],
                                ),
                              ),
                            ],
                          ),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),

                          //* Add Bio
                          profileLabel("About", screenHeight),
                          SizedBox(
                            height: screenHeight * 0.012,
                          ),
                          profileEditBioField(
                              formKey: provider.bioKey,
                              maxHeight: screenHeight,
                              maxWidth: screenWidth,
                              controller: provider.bioController,
                              validator: dummyNameValidator,
                              provider: provider,
                              key: 'about',
                              isError: provider.hasError('about'),
                              label: ''),

                          SizedBox(
                            height: screenHeight * 0.04,
                          ),

                          //* Button
                          _isLoading
                              ? Center(
                                  child: SpinKitCircle(
                                    color: AppColors.appYellow,
                                    size: screenHeight * 0.05,
                                  ),
                                )
                              : postAddButton(screenHeight, screenWidth,
                                  'Update', _editProfile),

                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                        ],
                      ),
                    ),
                  ));
            },
          ),
        ));
  }

  Widget switchWidget(bool isEnabled, void Function(bool) onChanged) {
    return GestureDetector(
      child: Switch(
        value: isEnabled,
        onChanged: onChanged,
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          return states.contains(MaterialState.selected)
              ? AppColors.appYellow
              : Colors.white;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          return states.contains(MaterialState.selected)
              ? AppColors.appYellow.withOpacity(0.2)
              : Colors.grey.shade300;
        }),
        trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
          return states.contains(MaterialState.selected)
              ? Color(0xFFB8860B)
              : Colors.grey;
        }),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
          return states.contains(MaterialState.pressed)
              ? AppColors.appYellow.withOpacity(0.2)
              : Colors.transparent;
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}

Widget profileLabel(String text, double maxHeight, {bool isRequired = false}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text,
          style: _textStyle2.copyWith(
            fontSize: maxHeight * 0.022,
            color: Colors.grey.shade700,
          ),
        ),
        if (isRequired)
          TextSpan(
            text: ' *',
            style: _textStyle2.copyWith(
              fontSize: maxHeight * 0.022,
              color: Colors.red,
            ),
          ),
      ],
    ),
  );
}

TextStyle _textStyle2 = TextStyle(fontFamily: "Poppins-Medium");

String? dummyNameValidator(String? name) {
  // Always passes validation
  return null;
}

String? dummyNameValidator1(String? name) {
  // Always passes validation
  return null;
}

String? dummyNameValidator21(String? name) {
  // Always passes validation
  return null;
}
