import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/constants/appControllers.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/view/bottom_bar_widgets.dart';
import 'package:social_media_clone/view/home/screen/home_screen.dart';
import 'package:social_media_clone/view/profile/screen/profile_screen.dart';
import 'package:social_media_clone/view/search/screen/search_screen.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter_svg/svg.dart';

List<BottomCardModel> _bottomCards = [
  BottomCardModel(
    svgUrl: 'assets/svg/camera.svg', // dummy local SVG path
    label: 'Upload Post',
  ),
  BottomCardModel(
    svgUrl: 'assets/images/main/ic_reel.svg', // dummy local SVG path
    label: 'Create Reel',
  ),
  BottomCardModel(
    svgUrl: 'assets/images/svg/ic_live.svg', // dummy local SVG path
    label: 'Go Live',
  ),
];

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  //* index for navigation
  int _currentIndex = 0;

  //* Navigation List
  late final List<VoidCallback> _navigationList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppControllers.mainController = PageController(initialPage: _currentIndex);
    _navigationList = [
      () {
        Navigator.pushNamed(
          context,
          '/post-add-screen',
          arguments: {
            'transition': TransitionType.bottomToTop,
            'duration': 300,
          },
        );
      },
      () {
        Navigator.pushNamed(
          context,
          '/reel-add-screen',
          arguments: {
            'transition': TransitionType.bottomToTop,
            'duration': 300,
          },
        );
      },
      () {
        Navigator.pushNamed(
          context,
          '/reel-add-screen',
          arguments: {
            'transition': TransitionType.bottomToTop,
            'duration': 300,
          },
        );
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        extendBody: true,

        //* Bottom Bar
        bottomNavigationBar: LayoutBuilder(builder: (context, constraints) {
          return SizedBox(
            height: constraints.maxHeight * 0.085,
            child: StylishBottomBar(
              elevation: 0,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.appGradient1, AppColors.appGradient2]),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: AppColors.appYellow,
              notchStyle: NotchStyle.circle,
              hasNotch: true,
              fabLocation: StylishBarFabLocation.center,
              option: AnimatedBarOptions(
                  iconStyle: IconStyle.simple,
                  // padding:
                  //     EdgeInsets.only(top: constraints.maxHeight * 0.02),
                  iconSize: constraints.maxHeight * 0.03

                  //iconStyle: IconStyle.animated,
                  ),
              items: bottomItems,
            ),
          );
        }),

        //* Center Floating Button
        floatingActionButton: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.only(bottom: constraints.maxHeight * 0.000),
              child: SizedBox(
                height: constraints.maxHeight * 0.075,
                width: constraints.maxWidth * 0.162,
                child: GestureDetector(
                  onTap: () {
                    var logger = Logger();
                    logger.d(bottomCards);
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: constraints.maxHeight * 0.02,
                              horizontal: constraints.maxWidth * 0.04),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              )),
                          height: constraints.maxHeight * 0.5,
                          child: Column(
                            children: [
                              Container(
                                height: 15,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: AlignmentDirectional.bottomCenter,
                                        colors: [
                                          AppColors.appGradient1,
                                          AppColors.appGradient2,
                                        ])),
                              ),

                              // Top bar with Create text and cross icon
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0,
                                    horizontal: constraints.maxWidth * 0.01),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Create",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins-Medium",
                                        fontSize: constraints.maxHeight * 0.025,
                                        color: Colors.black,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: constraints.maxHeight * 0.03,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 12.0),

                              // 2x2 Grid for cards
                              Expanded(
                                child: Column(
                                  children: List.generate(
                                    _bottomCards.length,
                                    (index) => Container(
                                      margin: EdgeInsets.only(
                                          bottom:
                                              constraints.maxHeight * 0.015),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: _navigationList[index],
                                          borderRadius: BorderRadius.circular(
                                              constraints.maxWidth * 0.03),
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(
                                                constraints.maxWidth * 0.035),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  AppColors.appGradient1
                                                      .withOpacity(0.9),
                                                  AppColors.appGradient2
                                                      .withOpacity(0.9),
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      constraints.maxWidth *
                                                          0.03),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: AppColors.appGradient1
                                                      .withOpacity(0.3),
                                                  blurRadius:
                                                      constraints.maxWidth *
                                                          0.02,
                                                  offset: Offset(
                                                      0,
                                                      constraints.maxHeight *
                                                          0.005),
                                                ),
                                              ],
                                              border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                // Icon Container
                                                Container(
                                                  width: constraints.maxWidth *
                                                      0.12,
                                                  height: constraints.maxWidth *
                                                      0.12,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            constraints
                                                                    .maxWidth *
                                                                0.025),
                                                    border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.3),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: SvgPicture.asset(
                                                      _bottomCards[index]
                                                          .svgUrl,
                                                      color: Colors.white,
                                                      height:
                                                          constraints.maxWidth *
                                                              0.06,
                                                      width:
                                                          constraints.maxWidth *
                                                              0.06,
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.04),

                                                // Text Content
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        _bottomCards[index]
                                                            .label,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "Poppins-Bold",
                                                          fontSize: constraints
                                                                  .maxHeight *
                                                              0.022,
                                                          color: Colors.white,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                          height: constraints
                                                                  .maxHeight *
                                                              0.003),
                                                      Text(
                                                        "Tap to explore ${_bottomCards[index].label.toLowerCase()}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              "Poppins-Light",
                                                          fontSize: constraints
                                                                  .maxHeight *
                                                              0.016,
                                                          color: Colors.white
                                                              .withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                // Arrow Icon
                                                Container(
                                                  width: constraints.maxWidth *
                                                      0.08,
                                                  height: constraints.maxWidth *
                                                      0.08,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            constraints
                                                                    .maxWidth *
                                                                0.02),
                                                  ),
                                                  child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                    size: constraints.maxWidth *
                                                        0.035,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.0),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.appGradient1,
                          AppColors.appGradient2
                        ],
                      ),
                      borderRadius:
                          BorderRadius.circular(constraints.maxHeight * 0.05),
                    ),
                    child: Center(
                      child: SvgPicture.asset("assets/images/svg/ic_plus.svg",
                          color: Colors.black,
                          width: constraints.maxWidth * 0.2,
                          height: constraints.maxHeight * 0.05),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        body: SafeArea(
          //* Body
          child: IndexedStack(
            index: _currentIndex,
            children: [
             HomeScreen(),
             // SearchScreen(),
              SearchScreen(),
              Container(
                child: Center(
                  child: Text("Reels Screen"),
                ),
              ),
              ProfileScreen()
            ],
          ),

          //  PageView(
          //   physics: const NeverScrollableScrollPhysics(),
          //   controller: AppControllers.mainController,
          //   children: [
          //     HomeScreen(),
          //     SearchScreen(),
          //     ReelsScreen(),
          //     ProfileScreen()
          //   ],
          // ),
        ));
  }
}
