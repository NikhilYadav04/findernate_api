import 'package:flutter/material.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';

Widget buildLikes(double sw, double sh, PostModel postData) {
  final engagement = postData.engagement;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (engagement.likes >= 0)
          Text(
            '${_formatCount(engagement.likes)} likes',
            style: TextStyle(
              fontSize: sh * 0.016,
              fontFamily: 'Poppins-SemiBold',
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        //SizedBox(height: sh * 0.005),
      ],
    ),
  );
}



Widget buildCommentsShares(
    double sw, double sh, PostModel postData) {
  final engagement = postData.engagement;

  return Padding(
    padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (engagement.comments >= 0) ...[
              Text(
                '${_formatCount(engagement.comments)} comments',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.grey.shade600,
                ),
              ),
            ],
            if (engagement.comments >= 0 && engagement.shares >= 0) ...[
              Text(' • ', style: TextStyle(color: Colors.grey.shade600)),
            ],
            if (engagement.shares >= 0) ...[
              Text(
                '${_formatCount(engagement.shares)} shares',
                style: TextStyle(
                  fontSize: sh * 0.014,
                  fontFamily: 'Poppins-Regular',
                  color: Colors.grey.shade600,
                ),
              ),
            ],
            Spacer(),
            Text(
              _formatTimestamp(postData.createdAt.toIso8601String()),
              style: TextStyle(
                fontSize: sh * 0.012,
                fontFamily: 'Poppins-Regular',
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

String _formatCount(int count) {
  if (count >= 1000000) {
    return '${(count / 1000000).toStringAsFixed(1)}M';
  } else if (count >= 1000) {
    return '${(count / 1000).toStringAsFixed(1)}K';
  }
  return count.toString();
}

String _formatTimestamp(String timestamp) {
  try {
    final DateTime postTime = DateTime.parse(timestamp);
    final Duration difference = DateTime.now().difference(postTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'Just now';
    }
  } catch (e) {
    return 'Just now';
  }
}
