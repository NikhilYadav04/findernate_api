import 'package:flutter/material.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';
import 'package:social_media_clone/view/content/widgets/display/post_image.dart';
import 'package:social_media_clone/view/content/widgets/display/video_display.dart';

Widget buildPostVideo(double sw, double sh, void Function() onTap,
    PostModel postData) {
  final mediaUrl = postData.media[0].url;
  final thumbnailUrl = postData.media[0].thumbnailUrl;
  final contentType = postData.contentType;

  return GestureDetector(
    onDoubleTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: sw * 0.04),
      width: double.infinity,
      height: sw,
      child: Stack(
        children: [
          ClipRRect(
            // ADD THIS
            borderRadius: BorderRadius.circular(8), // ADD THIS
            child: Container(
                width: double.infinity,
                height: double.infinity,
                child:
                    FeedPlayer(videoURL: mediaUrl, thumbNailURL: thumbnailUrl)),
          ), // ADD THIS CLOSING PARENTHESIS

          // Content type specific overlay
          if (contentType == 'normal') buildNormalOverlay(sw, sh, postData),
        ],
      ),
    ),
  );
}

