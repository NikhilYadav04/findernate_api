import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

Widget buildPostImage(double sw, double sh,void Function() onTap,Map<String,dynamic> postData) {
  final mediaUrl = postData['data']['media']['url'];
  final contentType = postData['data']['contentType'];

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
              child: Image.network(
                mediaUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: Icon(
                      Icons.error,
                      color: Colors.grey.shade400,
                      size: sw * 0.1,
                    ),
                  );
                },
              ),
            ),
          ), // ADD THIS CLOSING PARENTHESIS

          // Content type specific overlay
          if (contentType == 'normal') _buildNormalOverlay(sw, sh,postData),
        ],
      ),
    ),
  );
}

Widget _buildNormalOverlay(double sw, double sh,Map<String,dynamic> postData) {
  final normalData = postData['data']['customization']['normal'];
  final mood = normalData['mood'] ?? '';
  final activity = normalData['activity'] ?? '';

  if (mood.isEmpty && activity.isEmpty) return SizedBox.shrink();

  return Positioned(
    top: 12,
    left: 12,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.025,
        vertical: sh * 0.005,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.appGradient1.withOpacity(0.9),
            AppColors.appGradient2.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${mood} • ${activity}',
        style: TextStyle(
          color: Colors.white,
          fontSize: sh * 0.012,
          fontFamily: 'Poppins-Medium',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
