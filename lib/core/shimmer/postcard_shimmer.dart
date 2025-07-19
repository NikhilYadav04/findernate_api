import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildPostShimmer(double sw, double sh) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.015),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Header
          Row(
            children: [
              CircleAvatar(radius: sw * 0.05, backgroundColor: Colors.white),
              SizedBox(width: sw * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: sw * 0.3,
                    height: sh * 0.02,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(sw * 0.02),
                    ),
                  ),
                  SizedBox(height: sh * 0.005),
                  Container(
                    width: sw * 0.2,
                    height: sh * 0.015,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(sw * 0.015),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: sh * 0.015),

          //* Image
          Container(
            width: double.infinity,
            height: sw * 0.9, // Responsive image height
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sw * 0.02),
            ),
          ),

          SizedBox(height: sh * 0.015),

          //* Action buttons
          Row(
            children: [
              Container(
                width: sw * 0.06,
                height: sw * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sw * 0.01),
                ),
              ),
              SizedBox(width: sw * 0.04),
              Container(
                width: sw * 0.06,
                height: sw * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sw * 0.01),
                ),
              ),
              SizedBox(width: sw * 0.04),
              Container(
                width: sw * 0.06,
                height: sw * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sw * 0.01),
                ),
              ),
              Spacer(),
              Container(
                width: sw * 0.06,
                height: sw * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(sw * 0.01),
                ),
              ),
            ],
          ),

          SizedBox(height: sh * 0.01),

          //* Likes and caption
          Container(
            width: sw * 0.25,
            height: sh * 0.018,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sw * 0.015),
            ),
          ),

          SizedBox(height: sh * 0.008),

          Container(
            width: sw * 0.8,
            height: sh * 0.018,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sw * 0.015),
            ),
          ),

          SizedBox(height: sh * 0.005),

          //* Second caption line
          Container(
            width: sw * 0.6,
            height: sh * 0.018,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(sw * 0.015),
            ),
          ),
        ],
      ),
    ),
  );
}

//* Usage in your widget
Widget buildShimmerList(double sw, double sh) {
  return Column(
    children: List.generate(3, (index) => buildPostShimmer(sw, sh)),
  );
}
