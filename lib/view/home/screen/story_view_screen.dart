import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_story_presenter/flutter_story_presenter.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key});

  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> {
  PageController pageController = PageController();
  double currentPageValue = 0.0;

  //* Story Data
  List<StoryModel> sampleStory = [
    StoryModel(
      userName: 'Kaival Patel',
      userProfile: 'https://avatars.githubusercontent.com/u/39383435?v=4',
      stories: [
        StoryItem(
          storyItemSource: StoryItemSource.network,
          duration: const Duration(seconds: 5),
          imageConfig: StoryViewImageConfig(
            fit: BoxFit.fitHeight,
            progressIndicatorBuilder: (p0, p1, p2) => Center(
              child: SpinKitFadingCircle(
                color: AppColors.appYellow,
                size: 50,
              ),
            ),
          ),
          storyItemType: StoryItemType.image,
          url:
              "https://images.pexels.com/photos/3225517/pexels-photo-3225517.jpeg?auto=compress&cs=tinysrgb&w=800",
        ),
        StoryItem(
          storyItemSource: StoryItemSource.network,
          duration: const Duration(seconds: 5),
          imageConfig: StoryViewImageConfig(
            fit: BoxFit.fitHeight,
            progressIndicatorBuilder: (p0, p1, p2) => Center(
              child: SpinKitFadingCircle(
                color: AppColors.appYellow,
                size: 50,
              ),
            ),
          ),
          storyItemType: StoryItemType.image,
          url:
              "https://images.pexels.com/photos/32748147/pexels-photo-32748147.jpeg?_gl=1*1l32r2r*_ga*ODkzOTA1ODk5LjE3NTE0Mzc1MTc.*_ga_8JE65Q40S6*czE3NTE0Mzc1MTYkbzEkZzEkdDE3NTE0Mzc1MTkkajU3JGwwJGgw",
        ),
      ],
    ),
    StoryModel(
      userName: 'Aarav Shah',
      userProfile: 'https://randomuser.me/api/portraits/men/32.jpg',
      stories: [
        StoryItem(
          storyItemSource: StoryItemSource.network,
          duration: const Duration(seconds: 5),
          imageConfig: StoryViewImageConfig(
            fit: BoxFit.fitHeight,
            progressIndicatorBuilder: (p0, p1, p2) => Center(
              child: SpinKitFadingCircle(
                color: Color(0xFF42A5F5),
                size: 50,
              ),
            ),
          ),
          storyItemType: StoryItemType.image,
          url:
              "https://images.pexels.com/photos/1236701/pexels-photo-1236701.jpeg?auto=compress&cs=tinysrgb&w=800",
        ),
        StoryItem(
          storyItemSource: StoryItemSource.network,
          duration: const Duration(seconds: 5),
          imageConfig: StoryViewImageConfig(
            fit: BoxFit.fitHeight,
            progressIndicatorBuilder: (p0, p1, p2) => Center(
              child: SpinKitFadingCircle(
                color: Color(0xFF42A5F5),
                size: 50,
              ),
            ),
          ),
          storyItemType: StoryItemType.image,
          url:
              "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=800",
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  multiStoryView() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView.builder(
          itemCount: sampleStory.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return AnimatedBuilder(
              animation: pageController,
              child: MyStoryView(
                storyModel: sampleStory[index],
                pageController: pageController,
              ),
              builder: (context, child) {
                if (pageController.position.hasContentDimensions) {
                  currentPageValue = pageController.page ?? 0.0;
                  final isLeaving = (index - currentPageValue) <= 0;
                  final t = (index - currentPageValue);
                  final rotationY = lerpDouble(0, 30, t)!;
                  const maxOpacity = 0.8;
                  final num opacity = lerpDouble(0, maxOpacity, t.abs())!
                      .clamp(0.0, maxOpacity);
                  final isPaging = opacity != maxOpacity;
                  final transform = Matrix4.identity();
                  transform.setEntry(3, 2, 0.003);
                  transform.rotateY(-rotationY * (pi / 180.0));
                  return Transform(
                    alignment: isLeaving
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    transform: transform,
                    child: Stack(
                      children: [
                        child!,
                        if (isPaging && !isLeaving)
                          Positioned.fill(
                            child: Opacity(
                              opacity: opacity as double,
                              child: const ColoredBox(
                                color: Colors.black87,
                              ),
                            ),
                          )
                      ],
                    ),
                  );
                }

                return child!;
              },
            );
          },
        ),
      ),
    );
  }
}

class MyStoryView extends StatefulWidget {
  const MyStoryView({
    super.key,
    required this.storyModel,
    required this.pageController,
  });

  final StoryModel storyModel;
  final PageController pageController;

  @override
  State<MyStoryView> createState() => _MyStoryViewState();
}

class _MyStoryViewState extends State<MyStoryView> {
  late FlutterStoryController controller;

  @override
  void initState() {
    controller = FlutterStoryController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;

    final storyViewIndicatorConfig = StoryViewIndicatorConfig(
      height: 4,
      activeColor: Colors.white,
      backgroundCompletedColor: Colors.white,
      backgroundDisabledColor: Colors.white.withOpacity(0.5),
      horizontalGap: 1,
      borderRadius: 1.5,
    );

    return FlutterStoryPresenter(
      flutterStoryController: controller,
      items: widget.storyModel.stories,
      footerWidget: MessageBoxView(
        controller: controller,
        sh: sh,
        sw: sw,
      ),
      storyViewIndicatorConfig: storyViewIndicatorConfig,
      initialIndex: 0,
      headerWidget: ProfileView(
        storyModel: widget.storyModel,
        sh: sh,
        sw: sw,
      ),
      onStoryChanged: (p0) {},
      onPreviousCompleted: () async {
        await widget.pageController.previousPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate);
      },
      onCompleted: () async {
        await widget.pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate);
        controller = FlutterStoryController();
      },
    );
  }
}

class MessageBoxView extends StatelessWidget {
  final sh;
  final sw;
  const MessageBoxView(
      {super.key,
      required this.controller,
      required this.sh,
      required this.sw});

  final FlutterStoryController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  onTap: () {
                    controller.pause();
                  },
                  onTapOutside: (event) {
                    controller.play();
                    FocusScope.of(context).unfocus();
                  },
                  style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: sh * 0.02,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                      hintStyle: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: sh * 0.02,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      hintText: 'Enter Message',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: sh * 0.011)),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            CircleAvatar(
              radius: sh * 0.025,
              backgroundColor: Colors.grey.withOpacity(0.4),
              child: Center(
                child: IconButton(
                    onPressed: () {},
                    iconSize: sh * 0.025,
                    icon: Transform.rotate(
                        angle: 0,
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final sh;
  final sw;
  const ProfileView({
    Key? key,
    required this.storyModel,
    this.sh,
    this.sw,
  }) : super(key: key);

  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 15, right: 0),
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(1),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: storyModel.userProfile,
                  height: sh * 0.04,
                  width: sh * 0.04,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      storyModel.userName,
                      style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: sh * 0.02,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.blue,
                    size: sh * 0.03,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    '1d',
                    style: TextStyle(
                      color: Colors.grey.shade100,
                      fontFamily: "Poppins-Medium",
                      //fontWeight: FontWeight.bold,
                      fontSize: sh * 0.022,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: sw * 0.07),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: sh * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Story Data Model
class StoryModel {
  String userName;
  String userProfile;
  List<StoryItem> stories;

  StoryModel({
    required this.userName,
    required this.userProfile,
    required this.stories,
  });
}

// Custom Widget - Question
class TextOverlayView extends StatelessWidget {
  const TextOverlayView({super.key, required this.controller});

  final FlutterStoryController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                  'https://images.pexels.com/photos/1761279/pexels-photo-1761279.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        spreadRadius: 0,
                      )
                    ]),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "What’s your favorite outdoor activity and why?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: IntrinsicWidth(
                        child: TextFormField(
                          onTap: () {
                            controller?.pause();
                          },
                          onTapOutside: (event) {
                            // controller?.play();
                            FocusScope.of(context).unfocus();
                          },
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              hintText: 'Type something...',
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: -40,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffE2DCFF),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                        )
                      ]),
                  padding: const EdgeInsets.all(20),
                  child: CachedNetworkImage(
                    imageUrl: 'https://devkrest.com/logo/devkrest_outlined.png',
                    height: 40,
                    width: 40,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
