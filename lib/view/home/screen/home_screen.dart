import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/home/home_controller.dart';
import 'package:social_media_clone/core/shimmer/postcard_shimmer.dart';
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
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    provider = HomeProvider();
    _scrollController = ScrollController();

    // Add scroll listener for pagination
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 50) {
        if (!provider.isLoading && provider.hasMore) {
          provider.fetchPosts();
          Logger().d("Fetching");
        }
      }
    });
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    if (!provider.isLoading) {
      await provider.refreshPosts();
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
                floating: false,
                snap: false,
                pinned: false,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                toolbarHeight: screenHeight * 0.065,
                expandedHeight: screenHeight * 0.065,
                flexibleSpace: homeAppBar(
                    onTap1: _scrollToTop,
                    onTap2: () {},
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
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  StoryBar(maxHeight: screenHeight, maxWidth: screenWidth),
                  SizedBox(height: screenHeight * 0.01),
                  ChangeNotifierProvider(
                    create: (context) => provider..fetchPosts(),
                    child: Consumer<HomeProvider>(
                      builder: (context, provider, _) {
                        return Column(
                          children: [
                            //* Show shimmer when initializing
                            if (provider.isInitializing)
                              ...List.generate(
                                  3,
                                  (index) => buildShimmerList(
                                      screenWidth, screenHeight))
                            else ...[
                              //* Posts list with index
                              ...provider.posts.asMap().entries.map((entry) {
                                final index = entry.key;
                                final post = entry.value;

                                return UniversalPostCard(
                                  isReel: post.postType != "photo",
                                  postData: post,
                                  onLike: () => print('Service post liked'),
                                  onComment: () =>
                                      print('Service post commented'),
                                  onShare: () => print('Service post shared'),
                                  onSave: () => print('Service post saved'),
                                  onProfileTap: () =>
                                      print('Service post profile tapped'),
                                );
                              }).toList(),

                              //* Loading indicator at bottom for pagination
                              if (provider.hasMore && provider.isLoading)
                                Container(
                                  padding: EdgeInsets.all(16),
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                ),
                            ],
                          ],
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
