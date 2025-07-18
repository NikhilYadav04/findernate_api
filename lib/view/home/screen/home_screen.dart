import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/home/home_controller.dart';
import 'package:social_media_clone/view/content/widgets/display/post_header.dart';
import 'package:social_media_clone/view/home/screen/home_app_bar.dart';
import 'package:social_media_clone/view/home/screen/story_bar_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = HomeProvider();
  }

  void _checkIfAtBottom(ScrollNotification scrollInfo) {
    final isAtBottom =
        scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent;
    final isNearBottom =
        scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 50;

    print("Is at bottom: $isAtBottom");
    print("Is near bottom (50px): $isNearBottom");

    if (isAtBottom &&
        isNearBottom &&
        !provider.isLoadingCard &&
        provider.hasMoreCard) {
      provider.fetchPostsData();
      Logger().d("Fetching");
    }
  }

  Future<void> _refresh() async {
    if (!provider.isLoadingCard) {
      await provider.refreshPostsData();
      Logger().d("Refreshing");
    } else {
      return;
    }
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
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                toolbarHeight: screenHeight * 0.065,
                flexibleSpace: homeAppBar(
                    onTap: () {},
                    unreadCount: "0",
                    maxHeight: screenHeight,
                    maxWidth: screenWidth,
                    context: context),
              )
            ];
          },
          body: LiquidPullToRefresh(
            onRefresh: _refresh,
            animSpeedFactor: 2,
            showChildOpacityTransition: false,
            color: Color(0xFFFCD45C),
            backgroundColor: Colors.white,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  StoryBar(maxHeight: screenHeight, maxWidth: screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  ChangeNotifierProvider(
                    create: (context) => provider..fetchPostsData(),
                    child: Consumer<HomeProvider>(
                      builder: (context, provider, _) {
                        return Expanded(
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              _checkIfAtBottom(scrollInfo);
                              return false;
                            },
                            child: ListView.builder(
                              itemCount: provider.postsCard.length +
                                  (provider.hasMoreCard ? 1 : 0),
                              itemBuilder: (context, index) {
                                //* Show loading indicator at bottom
                                if (index == provider.postsCard.length) {
                                  return Container(
                                    padding: EdgeInsets.all(16),
                                    alignment: Alignment.center,
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                final post = provider.postsCard[index];
                                return UniversalPostCard(
                                  postData: post,
                                  onLike: () => print('Service post liked'),
                                  onComment: () =>
                                      print('Service post commented'),
                                  onShare: () => print('Service post shared'),
                                  onSave: () => print('Service post saved'),
                                  onProfileTap: () =>
                                      print('Service post profile tapped'),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
