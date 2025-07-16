import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/showPreview.dart';
import 'package:social_media_clone/model/user/posts/model_post.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

Widget profileHeader({
  required double maxHeight,
  required double maxWidth,
  required List<Map<String, String>> userDetails,
  bool isBusinessAccount = false, // Add this parameter
  bool isBusinessDetails = false, // Add this parameter
}) {
  return Container(
    height: maxHeight * 0.11,
    width: double.infinity,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ListTile(
            subtitle: Text(
              userDetails[1]['fullName'] ?? "JonDoe",
              style: _textStyle2.copyWith(
                color: Colors.grey.shade800,
                fontSize: constraints.maxHeight * 0.175,
              ),
            ),
            title: Row(
              children: [
                Text(
                  userDetails[0]['username'] ?? "hello_123",
                  style: _textStyle2.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: constraints.maxHeight * 0.25,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // Add Business badge next to username
                if (isBusinessAccount)
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.02),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: maxWidth * 0.02,
                        vertical: maxHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            colors: [
                              AppColors.appGradient1,
                              AppColors.appGradient2
                            ]),
                        color: Colors.yellow[700], // Yellow background
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Business',
                        style: _textStyle2.copyWith(
                          color: Colors.white, // Black text
                          fontSize: constraints.maxHeight * 0.12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            leading: GestureDetector(
              onLongPress: () => _showTransparentProfile(
                context,
                userDetails[3]['profileURL'],
                maxHeight,
              ),
              child: Hero(
                tag: 'profilePhoto',
                child: CircleAvatar(
                  radius: constraints.maxHeight * 0.28,
                  backgroundImage: CachedNetworkImageProvider(
                    userDetails[3]['profileURL'] ?? '',
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

void _showTransparentProfile(
    BuildContext context, String? imageUrl, double maxHeight) {
  if (imageUrl == null || imageUrl.isEmpty) return;

  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.8), // fully transparent
    barrierDismissible: true,
    barrierLabel: '', // required, but empty
    builder: (_) => Center(
      child: Hero(
        tag: 'profilePhoto', // same tag for the Hero animation
        child: CircleAvatar(
          radius: maxHeight * 0.12, // enlarged size
          backgroundImage: CachedNetworkImageProvider(imageUrl),
        ),
      ),
    ),
  );
}

Widget profileBio(
    {required double maxHeight,
    required double maxWidth,
    required String bio}) {
  return Align(
    alignment: Alignment.topLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.045),
      child: Text(
        bio,
        style: _textStyle2.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: maxHeight * 0.02),
      ),
    ),
  );
}

Widget profilePhotosGrid(
    {required double maxHeight,
    required double maxWidth,
    required List<PostModel> list,
    required String media}) {
  return GridView.builder(
    padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.045),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: maxWidth * 0.025,
      mainAxisSpacing: maxHeight * 0.015,
      childAspectRatio: 1,
    ),
    itemCount: list.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onLongPress: () {
          //* Preview
          if (media == "image") {
            showDialog(
                context: context,
                barrierColor:
                    Colors.black.withOpacity(0.8), // fully transparent
                barrierDismissible: true,
                barrierLabel: '',
                builder: (_) => openPreview(
                    username: list[index].createdBy,
                    location: list[index].location,
                    context: context,
                    initialPage: 0,
                    list: list[index],
                    sh: maxHeight,
                    sw: maxWidth));
          }
        },
        onTap: () {
          //* Navigate to detail
          Navigator.pushNamed(
            context,
            '/post-detail-card',
            arguments: {
              'transition': TransitionType.bottomToTop,
              'mediaType': list[index].mediaType == "image" ? "image" : "video",
              'duration': 300,
              'postModel': list[index],
            },
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black, width: .5), // Black border of width 2
            borderRadius: BorderRadius.circular(maxHeight * 0.015),
          ),
          child: GestureDetector(
            onDoubleTap: () {
              //* Show preview of it
            },
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
              child: CachedNetworkImage(
                imageUrl: list[index].mediaType == "image"
                    ? list[index].mediaUrl[0]
                    : list[index].videoThumbnail,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget profileStats(
    {required double maxHeight,
    required double maxWidth,
    required BuildContext context,
    required String userName,
    required List<String> followers,
    required List<String> following,
    required String postCount,
    required String userId,
    required bool isPersonal}) {
  return Container(
    height: maxHeight * 0.085,
    child: GestureDetector(
      //* nav to followers stats screen(depending on personal or user)
      onTap: () {
        // isPersonal
        //     ? Navigator.pushNamed(
        //         context,
        //         '/profile-follower-detail-screen',
        //         arguments: {
        //           'transition': TransitionType.fade,
        //           'duration': 300,
        //           'listFollowers': followers,
        //           'listFollowing': following,
        //           'userName': userName
        //         },
        //       )
        //     : Navigator.pushNamed(
        //         context,
        //         '/profile-follower-detail-screen-user',
        //         arguments: {
        //           'transition': TransitionType.fade,
        //           'duration': 300,
        //           'listFollowers': followers,
        //           'listFollowing': following,
        //           'userName': userName,
        //           'userId': userId
        //         },
        //       );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 1,
              child: _StatItem(label: 'Posts', value: postCount.toString())),
          statsDivider(maxHeight: maxHeight, maxWidth: maxWidth),
          Expanded(
              flex: 1,
              child: _StatItem(
                  label: 'Following', value: following.length.toString())),
          statsDivider(maxHeight: maxHeight, maxWidth: maxWidth),
          Expanded(
              flex: 1,
              child: _StatItem(
                  label: 'Followers', value: followers.length.toString())),
        ],
      ),
    ),
  );
}

Widget profileStatsUser(
    {required double maxHeight,
    required double maxWidth,
    required BuildContext context,
    required String userName,
    required List<dynamic> followers,
    required List<dynamic> following,
    required String postCount,
    required String userId,
    required bool isPersonal}) {
  return Container(
    height: maxHeight * 0.085,
    child: GestureDetector(
      //* nav to followers stats screen(depending on personal or user)
      onTap: () {
        isPersonal
            ? Navigator.pushNamed(
                context,
                '/profile-follower-detail-screen',
                arguments: {
                  'transition': TransitionType.fade,
                  'duration': 300,
                  'listFollowers': followers,
                  'listFollowing': following,
                  'userName': userName
                },
              )
            : Navigator.pushNamed(
                context,
                '/profile-follower-detail-screen-user',
                arguments: {
                  'transition': TransitionType.fade,
                  'duration': 300,
                  'listFollowers': followers,
                  'listFollowing': following,
                  'userName': userName,
                  'userId': userId
                },
              );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
              flex: 1,
              child: _StatItem(label: 'Posts', value: postCount.toString())),
          statsDivider(maxHeight: maxHeight, maxWidth: maxWidth),
          Expanded(
              flex: 1,
              child: _StatItem(
                  label: 'Following', value: following.length.toString())),
          statsDivider(maxHeight: maxHeight, maxWidth: maxWidth),
          Expanded(
              flex: 1,
              child: _StatItem(
                  label: 'Followers', value: followers.length.toString())),
        ],
      ),
    ),
  );
}

Widget _StatItem({
  required String label,
  required String value,
}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: constraints.maxHeight * 0.09),
                child: Text(value,
                    style: _textStyle2.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: constraints.maxHeight * 0.25)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  label,
                  style: _textStyle2.copyWith(
                    color: Colors.grey.shade800,
                    fontSize: constraints.maxHeight * 0.22,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Widget profileTabs(
//     {required double maxHeight,
//     required double maxWidth,
//     required ProviderProfile provider}) {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.045),
//     child: Container(
//       child: Row(
//         children: [
//           Expanded(
//               flex: 1,
//               child: _TabButton(
//                 label: 'Photos',
//                 selected: true,
//                 maxHeight: maxHeight,
//                 maxWidth: maxWidth,
//                 onTap: () {
//                   provider.changeTabIndex(0);
//                 },
//                 gradient: provider.giveTabButtonGradient(0),
//                 backgroundColor: provider.giveTabButtonColors(0)[0],
//                 textColor: provider.giveTabButtonColors(0)[1],
//               )),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//               flex: 1,
//               child: _TabButton(
//                 label: 'Video',
//                 selected: false,
//                 maxHeight: maxHeight,
//                 maxWidth: maxWidth,
//                 onTap: () {
//                   provider.changeTabIndex(1);
//                 },
//                 gradient: provider.giveTabButtonGradient(1),
//                 backgroundColor: provider.giveTabButtonColors(1)[0],
//                 textColor: provider.giveTabButtonColors(1)[1],
//               )),
//           SizedBox(
//             width: 10,
//           ),
//           Expanded(
//               flex: 1,
//               child: _TabButton(
//                 label: 'Saved',
//                 selected: false,
//                 maxHeight: maxHeight,
//                 maxWidth: maxWidth,
//                 onTap: () {
//                   provider.changeTabIndex(2);
//                 },
//                 gradient: provider.giveTabButtonGradient(2),
//                 backgroundColor: provider.giveTabButtonColors(2)[0],
//                 textColor: provider.giveTabButtonColors(2)[1],
//               )),
//         ],
//       ),
//     ),
//   );
// }

Widget _TabButton(
    {required String label,
    required bool selected,
    required double maxHeight,
    required double maxWidth,
    required Color backgroundColor,
    required Color textColor,
    required LinearGradient gradient,
    required VoidCallback onTap}) {
  return Container(
    width: double.infinity,
    height: maxHeight * 0.055,
    decoration: BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(40),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            Colors.transparent, // Make button background transparent
        shadowColor: Colors.transparent, // Remove shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(maxHeight * 0.015),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Center(
        child: FittedBox(
          child: Text(
            label,
            style: _textStyle2.copyWith(
              color: textColor,
              fontSize: maxHeight * 0.02,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget editProfileButton({
  required double maxHeight,
  required double maxWidth,
  required bool isProfile,
  required BuildContext context,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.045),
    child: SizedBox(
      width: double.infinity,
      child: Container(
        width: double.infinity,
        height: maxHeight * 0.065,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.appGradient1, AppColors.appGradient2]),
          borderRadius: BorderRadius.circular(maxHeight * 0.015),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(maxHeight * 0.015),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/profile-edit-screen',
              arguments: {
                'isProfile': isProfile,
                'transition': TransitionType.rightToLeft,
                'duration': 300,
              },
            );
          },
          child: Text(
            'Edit Profile',
            style: _textStyle2.copyWith(
              color: Colors.white,
              fontSize: maxHeight * 0.022,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget statsDivider({required double maxHeight, required double maxWidth}) {
  return Container(
    width: maxWidth * 0.005,
    height: double.infinity,
    color: Colors.black,
  );
}

Widget profileBar({
  required double maxHeight,
  required double maxWidth,
  required String title,
  bool isBusinessAccount = false,
  bool isBusinessDetails = false,
}) {
  return Container(
    height: maxHeight * 0.065,
    child: Center(
      child: Text(
        title,
        style: _textStyle2.copyWith(
            color: Colors.black,
            fontSize: maxHeight * 0.025,
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget postsText({required double maxHeight, required double maxWidth}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.045),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Text('Posts',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: maxHeight * 0.023)),
    ),
  );
}

Widget userProfileHeader({
  required double maxHeight,
  required double maxWidth,
  required Map<String, dynamic> post,
  required bool isBusinessAccount, // Add this parameter
}) {
  return Container(
    height: maxHeight * 0.11,
    width: double.infinity,
    child: LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: ListTile(
            trailing: Icon(
              Icons.more_vert,
              size: constraints.maxHeight * 0.3,
              color: Colors.black,
            ),
            subtitle: Text(
              post["full_name"] ?? "JohnDoe",
              style: _textStyle2.copyWith(
                color: Colors.grey.shade800,
                fontSize: constraints.maxHeight * 0.175,
              ),
            ),
            title: Row(
              children: [
                Text(
                  post["username"] ?? 'xyz_123',
                  style: _textStyle2.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: constraints.maxHeight * 0.25,
                  ),
                ),
                // Add Business badge next to username
                if (isBusinessAccount)
                  Padding(
                    padding: EdgeInsets.only(left: maxWidth * 0.02),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: maxWidth * 0.02,
                        vertical: maxHeight * 0.005,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: AlignmentDirectional.bottomCenter,
                            colors: [
                              AppColors.appGradient1,
                              AppColors.appGradient2,
                            ]),
                        color: Colors.yellow[700], // Yellow background
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Business',
                        style: _textStyle2.copyWith(
                          color: Colors.white, // Black text
                          fontSize: constraints.maxHeight * 0.12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            leading: GestureDetector(
              onLongPress: () => _showTransparentProfile(
                context,
                post["profile_image_url"] ??
                    'https://randomuser.me/api/portraits/men/33.jpg',
                maxHeight,
              ),
              child: Hero(
                tag: 'profilePhoto',
                child: CircleAvatar(
                  radius: constraints.maxHeight * 0.28,
                  backgroundImage: CachedNetworkImageProvider(
                    post["profile_image_url"] ??
                        'https://randomuser.me/api/portraits/men/33.jpg',
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

Widget postAddButton(
    double maxHeight, double maxWidth, String title, VoidCallback onTap) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.appGradient1, AppColors.appGradient2]),
    ),
    width: double.infinity,
    height: maxHeight * 0.07,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(maxHeight * 0.015),
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: _textStyle2.copyWith(
          fontSize: maxHeight * 0.024,
          color: Colors.white,
          letterSpacing: 1,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

final List<String> images = [
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
  'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
  'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
  'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
  'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308',
  'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
  'https://images.unsplash.com/photo-1465101046530-73398c7f28ca',
];

TextStyle _textStyle1 = TextStyle(fontFamily: "Poppins-Regular");
TextStyle _textStyle2 = TextStyle(fontFamily: "Poppins-Medium");
