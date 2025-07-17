import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

Widget buildTags(double sw, double sh,Map<String, dynamic> postData) {
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

List<String> _getAllTags(Map<String, dynamic> postData) {
  final contentType = postData['data']['contentType'];
  switch (contentType) {
    case 'business':
      return List<String>.from(
          postData['data']['customization']['business']['tags'] ?? []);
    case 'service':
      return List<String>.from(
          postData['data']['customization']['service']['tags'] ?? []);
    case 'product':
      return List<String>.from(
          postData['data']['customization']['product']['tags'] ?? []);
    case 'normal':
      return List<String>.from(
          postData['data']['customization']['normal']['tags'] ?? []);
    default:
      return [];
  }
}
