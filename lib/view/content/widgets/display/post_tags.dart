import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';

Widget buildTags(double sw, double sh, PostModel postData) {
  final tags = _getAllTags(postData);

  if (tags.isEmpty) return SizedBox.shrink();

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
    child: Wrap(
      spacing: sw * 0.02,
      runSpacing: sh * 0.005,
      children: tags
          .map(
            (tag) => Text(
              '#$tag',
              style: TextStyle(
                fontSize: sh * 0.014,
                fontFamily: 'Poppins-Medium',
                color: AppColors.appGradient2,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
          .toList(),
    ),
  );
}

List<String> _getAllTags(PostModel postData) {
  final contentType = postData.contentType;
  switch (contentType) {
    case 'business':
      return List<String>.from(postData.customization.business?.tags ?? []);
    case 'service':
      return List<String>.from(postData.customization.service?.tags ?? []);
    case 'product':
      return List<String>.from(postData.customization.product?.tags ?? []);
    case 'normal':
      return List<String>.from(postData.customization.normal?.tags ?? []);
    default:
      return [];
  }
}
