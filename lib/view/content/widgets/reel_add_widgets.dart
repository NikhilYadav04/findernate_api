import 'dart:io';
import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

Widget buildVideoPicker(
  double sw,
  double sh,
  File? selectedVideo,
  VoidCallback onTap,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Select Video',
        style: TextStyle(
          fontSize: sh * 0.02,
          fontFamily: 'Poppins-Medium',
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
      SizedBox(height: sh * 0.015),
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: sh * 0.25,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.appGradient1, width: 2),
          ),
          child: selectedVideo == null
              ? Center(
                  child: Container(
                    width: sw * 0.15,
                    height: sw * 0.15,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: AppColors.appGradient1, width: 2),
                    ),
                    child: Icon(
                      Icons.videocam,
                      color: AppColors.appGradient1,
                      size: sw * 0.08,
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      // Video placeholder/thumbnail
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: AppColors.black.withOpacity(0.8),
                        child: Center(
                          child: Icon(
                            Icons.play_circle_filled,
                            color: AppColors.white,
                            size: sw * 0.15,
                          ),
                        ),
                      ),

                      // Video indicator
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.02,
                            vertical: sh * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.videocam,
                                color: AppColors.white,
                                size: sh * 0.015,
                              ),
                              SizedBox(width: sw * 0.01),
                              Text(
                                'Video',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: sh * 0.012,
                                  fontFamily: 'Poppins-Medium',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    ],
  );
}
