import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/constants/appControllers.dart';
import 'package:social_media_clone/view/bottom_bar_widgets.dart';
import 'package:social_media_clone/view/profile/screen/profile_screen.dart';
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
  BottomCardModel(
    svgUrl: 'assets/svg/camera.svg', // dummy local SVG path
    label: 'Business',
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
        // Navigator.pushNamed(
        //   context,
        //   '/post-add-screen',
        //   arguments: {
        //     'transition': TransitionType.bottomToTop,
        //     'duration': 300,
        //   },
        // );
      },
      () {
        // Navigator.pushNamed(
        //   context,
        //   '/reel-add-screen',
        //   arguments: {
        //     'transition': TransitionType.bottomToTop,
        //     'duration': 300,
        //   },
        // );
      },
      () {
        // Navigator.pushNamed(
        //   context,
        //   '/reel-add-screen',
        //   arguments: {
        //     'transition': TransitionType.bottomToTop,
        //     'duration': 300,
        //   },
        // );
      },
      () {
        // Navigator.pushNamed(
        //   context,
        //   '/reel-add-screen',
        //   arguments: {
        //     'transition': TransitionType.bottomToTop,
        //     'duration': 300,
        //   },
        // );
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
                height: constraints.maxHeight * 0.08,
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
                          height: constraints.maxHeight * 0.44,
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
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12.0,
                                    mainAxisSpacing: 12.0,
                                    childAspectRatio: 1.8,
                                  ),
                                  itemCount: _bottomCards.length,
                                  itemBuilder: (context, index) {
                                    return Container(
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
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: _navigationList[index],
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          child: Padding(
                                            padding: EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  color: Colors.white,
                                                  _bottomCards[index].svgUrl,
                                                  height:
                                                      constraints.maxHeight *
                                                          0.04,
                                                ),
                                                SizedBox(height: 8.0),
                                                Text(
                                                  _bottomCards[index].label,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily:
                                                        "Poppins-Medium",
                                                    fontSize:
                                                        constraints.maxHeight *
                                                            0.02,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
              Container(
                child: Center(
                  child: Text("Home Screen"),
                ),
              ),
              Container(
                child: Center(
                  child: Text("Search Screen"),
                ),
              ),
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
