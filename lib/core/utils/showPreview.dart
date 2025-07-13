import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/model/user/posts/model_post.dart';

//* To show preview of images
Widget openPreview(
    {required BuildContext context,
    required int initialPage,
    required PostModel list,
    required String username,
    required String location,
    required double sh,
    required double sw}) {
  return Container(
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.symmetric(horizontal: sw * 0.03),
          height: sh * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                  color: Colors.grey.shade800,
                ),
                height: sh * 0.08,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: sh * 0.03,
                        backgroundImage:
                            CachedNetworkImageProvider(list.createdByImageURL),
                      ),
                      SizedBox(width: sw * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${username}",
                            style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              color: Colors.white,
                              fontSize: sh * 0.022,
                            ),
                          ),
                          Text(
                            "${location}",
                            style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              color: Colors.grey.shade300,
                              fontSize: sh * 0.015,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: sh * 0.04,
                          ))
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      )),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: list.mediaUrl[0],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(Icons.error, color: Colors.red, size: 40),
                      ),
                      fadeInDuration: Duration(milliseconds: 500),
                      cacheKey: list.mediaUrl[0],
                      memCacheWidth: 800,
                      memCacheHeight: 800,
                    ),
                  ),
                ),
              ),

              // you can add more widgets below if needed
            ],
          ),
        ),
      ));
}

// simple model for your media items
class MediaItem {
  final String mediaType; // "image" or "video"
  final List<String> mediaUrl; // if image, list of URLs
  final String videoThumbnail; // if video

  MediaItem({
    required this.mediaType,
    required this.mediaUrl,
    required this.videoThumbnail,
  });
}
