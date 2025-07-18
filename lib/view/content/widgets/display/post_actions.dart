import 'package:flutter/material.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';

Widget buildContent(double sw, double sh, PostModel postData,
    String getDisplayName) {
  final caption = postData.caption;
  final description = postData.description ?? '';

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: sh * 0.008),
        if (caption.isNotEmpty) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${getDisplayName} ',
                  style: TextStyle(
                    fontSize: sh * 0.016,
                    fontFamily: 'Poppins-SemiBold',
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: caption,
                  style: TextStyle(
                    fontSize: sh * 0.016,
                    fontFamily: 'Poppins-Regular',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sh * 0.005),
        ],
        if (description.isNotEmpty) ...[
          Text(
            description,
            style: TextStyle(
              fontSize: sh * 0.014,
              fontFamily: 'Poppins-Regular',
              color: Colors.grey.shade700,
              height: 1.3,
            ),
          ),
        ],
      ],
    ),
  );
}
