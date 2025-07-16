import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media_clone/view/profile/widgets/profile_screen_widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _refresh() async {
    final authProvider = Provider.of<ProviderAuth>(context, listen: false);
    authProvider.refreshUserStats(context: context);
    Logger().d(authProvider.currentUserData!.profileImageUrl);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<ProviderAuth>(context, listen: false);
      authProvider.getUserStats(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          top: false,
          bottom: false,
          child: LiquidPullToRefresh(
            animSpeedFactor: 2,
            showChildOpacityTransition: false,
            color: AppColors.appYellow,
            backgroundColor: Colors.white,
            onRefresh: _refresh,
            child: Consumer<ProviderAuth>(
              builder: (context, provider, _) {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      //* Profile Header Section
                      provider.isUserStatsLoading
                          ? Skeletonizer(
                              enabled: true,
                              ignoreContainers: false,
                              textBoneBorderRadius: TextBoneBorderRadius(
                                  BorderRadius.circular(12)),
                              enableSwitchAnimation: true,
                              justifyMultiLineText: true,
                              effect: ShimmerEffect(
                                baseColor: AppColors.appYellow,
                                highlightColor: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  //* App Bar
                                  profileBar(
                                      maxHeight: screenHeight,
                                      maxWidth: screenWidth,
                                      title: "My Profile"),

                                  //* Profile Header And Bio
                                  profileHeader(
                                    userDetails: [
                                      {'username': 'john_doe_456'},
                                      {'fullName': 'John Doe'},
                                      {
                                        'email': 'john.doe@email.com',
                                        'phone': '+1-555-0456',
                                        'location': 'Chicago, IL',
                                      },
                                      {
                                        'profileURL':
                                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80',
                                      },
                                    ],
                                    maxHeight: screenHeight,
                                    maxWidth: screenWidth,
                                    isBusinessAccount: true,
                                    isBusinessDetails: true,
                                  ),
                                  profileBio(
                                      maxHeight: screenHeight,
                                      maxWidth: screenWidth,
                                      bio: ""),
                                  SizedBox(height: screenHeight * 0.03),

                                  //* Follow/Following Button
                                  editProfileButton(
                                      isProfile: false,
                                      maxHeight: screenHeight,
                                      maxWidth: screenWidth,
                                      context: context),
                                  SizedBox(height: screenHeight * 0.03),

                                  //* Profile Stats
                                  profileStats(
                                      isPersonal: true,
                                      userId: "random",
                                      maxHeight: screenHeight,
                                      maxWidth: screenWidth,
                                      context: context,
                                      followers: [],
                                      following: [],
                                      postCount: "10",
                                      userName: "dummy"),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                //* App Bar
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.04),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      profileBar(
                                        maxHeight: screenHeight,
                                        maxWidth: screenWidth,
                                        title: "My Profile",
                                        isBusinessAccount: provider
                                                .currentUserData
                                                ?.isBusinessProfile ??
                                            false,
                                        isBusinessDetails: provider
                                                .currentUserData
                                                ?.isBusinessProfile ??
                                            false,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "assets/images/svg/ic_notify.svg",
                                            height: screenHeight * 0.03,
                                            width: screenWidth * 0.03,
                                            fit: BoxFit.contain,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                context,
                                                '/settings-screen',
                                                arguments: {
                                                  'transition': TransitionType
                                                      .rightToLeft,
                                                  'isBusiness': true,
                                                  'isBusinessDetails': true,
                                                  'duration': 300,
                                                },
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              "assets/images/settings/ic_settings.svg",
                                              height: screenHeight * 0.028,
                                              width: screenWidth * 0.028,
                                              fit: BoxFit.contain,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                //* Profile Header And Bio
                                profileHeader(
                                  userDetails: [
                                    {
                                      'username':
                                          provider.currentUserData?.username ??
                                              ""
                                    },
                                    {
                                      'fullName':
                                          provider.currentUserData?.fullName ??
                                              ''
                                    },
                                    {
                                      'email':
                                          provider.currentUserData?.email ?? "",
                                      'phone': provider
                                              .currentUserData?.phoneNumber ??
                                          "",
                                      'location': "",
                                    },
                                    {
                                      'profileURL': provider.currentUserData
                                                  ?.profileImageUrl ==
                                              ""
                                          ? 'https://static.thenounproject.com/png/630737-200.png'
                                          : provider.currentUserData
                                                  ?.profileImageUrl ??
                                              'https://static.thenounproject.com/png/630737-200.png'
                                    },
                                  ],
                                  maxHeight: screenHeight,
                                  maxWidth: screenWidth,
                                  isBusinessAccount: provider
                                          .currentUserData?.isBusinessProfile ??
                                      false,
                                  isBusinessDetails: provider
                                          .currentUserData?.isBusinessProfile ??
                                      false,
                                ),
                                profileBio(
                                    maxHeight: screenHeight,
                                    maxWidth: screenWidth,
                                    bio: provider.currentUserData?.bio == ""
                                        ? "Hey I Am Using Instagram"
                                        : provider.currentUserData?.bio ??
                                            "Hey I Am Using Instagram"),
                                SizedBox(height: screenHeight * 0.03),

                                //* Follow/Following Button
                                editProfileButton(
                                    isProfile: false,
                                    maxHeight: screenHeight,
                                    maxWidth: screenWidth,
                                    context: context),
                                SizedBox(height: screenHeight * 0.03),

                                //* Profile Stats
                                profileStats(
                                    isPersonal: true,
                                    userId: "random",
                                    maxHeight: screenHeight,
                                    maxWidth: screenWidth,
                                    context: context,
                                    followers:
                                        provider.currentUserData?.followers ??
                                            [],
                                    following:
                                        provider.currentUserData?.following ??
                                            [],
                                    postCount: provider
                                            .currentUserData?.posts.length
                                            .toString() ??
                                        "0",
                                    userName:
                                        provider.currentUserData?.username ??
                                            ""),
                              ],
                            ),

                      SizedBox(height: screenHeight * 0.02),

                      // //* Profile Tabs
                      // profileTabs(
                      //     maxHeight: screenHeight,
                      //     maxWidth: screenWidth,
                      //     provider: provider),
                      // SizedBox(
                      //   height: screenHeight * 0.025,
                      // ),

                      // //* Photos Grid
                      // Skeletonizer(
                      //   enabled: provider.isPostDetailsLoaded,
                      //   ignoreContainers: false,
                      //   textBoneBorderRadius:
                      //       TextBoneBorderRadius(BorderRadius.circular(12)),
                      //   enableSwitchAnimation: true,
                      //   justifyMultiLineText: true,
                      //   effect: ShimmerEffect(
                      //       baseColor: AppColors.appYellow,
                      //       highlightColor: Colors.white),
                      //   child: IndexedStack(
                      //     index: provider.tabIndex,
                      //     children: [
                      //       GestureDetector(
                      //         onTap: () {},
                      //         child: profilePhotosGrid(
                      //             maxHeight: screenHeight,
                      //             maxWidth: screenWidth,
                      //             list: provider.mapPosts['allPosts'] ?? [],
                      //             media: 'image'),
                      //       ),
                      //       profilePhotosGrid(
                      //           maxHeight: screenHeight,
                      //           maxWidth: screenWidth,
                      //           list: provider.mapPosts['allReels'] ?? [],
                      //           media: 'video'),
                      //       Container(color: Colors.blue)
                      //     ],
                      //   ),
                      // ),

                      // SizedBox(
                      //   height: screenHeight * 0.05,
                      // ),

                      // ReelVideoPlayer(
                      //     authorId: "id2PbIOhkmQwBDxUxJ3onnU1oo82",
                      //     provider: homeprovider,
                      //     maxHeight: screenHeight,
                      //     maxWidth: screenWidth,
                      //     thumbNail:
                      //         "https://firebasestorage.googleapis.com/v0/b/findernate-2d4b3.firebasestorage.app/o/posts%2Fid2PbIOhkmQwBDxUxJ3onnU1oo82%2FpfHY6orlWVKTYRhT91a5%2Fthumbnail%2Fdata%2Fuser%2F0%2Fcom.example.social_media_clone%2Fcache%2Fposts%252Fid2PbIOhkmQwBDxUxJ3onnU1oo82%252FpfHY6orlWVKTYRhT91a5%252Fvideo%252Fid2PbIOhkmQwBDxUxJ3onnU1oo82_1751794287360.png?alt=media&token=7af15e22-3008-4fd1-9f8f-90ce84c8606e",
                      //     isActive: true,
                      //     videoUrl:
                      //         "https://firebasestorage.googleapis.com/v0/b/findernate-2d4b3.firebasestorage.app/o/posts%2Fid2PbIOhkmQwBDxUxJ3onnU1oo82%2FpfHY6orlWVKTYRhT91a5%2Fvideo%2Fid2PbIOhkmQwBDxUxJ3onnU1oo82_1751794287360.jpg?alt=media&token=2a8b403c-cef5-461c-8ae8-ebe7a3b312e9",
                      //     username: "Nikhil",
                      //     caption: "Hello",
                      //     likes: "50",
                      //     comments: "52",
                      //     shares: '0',
                      //     profilePic:
                      //         "https://cdn-icons-png.flaticon.com/512/6596/6596121.png",
                      //     postId: "pfHY6orlWVKTYRhT91a5")

                      //PreviewContent(sh: screenHeight, sw: screenWidth, list: provider.mapPosts['allPosts']![0])
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
