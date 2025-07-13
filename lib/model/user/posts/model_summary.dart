import 'package:social_media_clone/model/user/model_user_summary.dart';

class CommentModel {
  final String commentId;
  final UserSummary commenter;
  final String text;
  final DateTime timestamp;
  final List<CommentModel> replies;

  CommentModel({
    required this.commentId,
    required this.commenter,
    required this.text,
    required this.timestamp,
    required this.replies,
  });

  factory CommentModel.fromJson(String commentId, Map<String, dynamic> json) {
    return CommentModel(
      commentId: commentId,
      commenter:
          UserSummary.fromJson(json['commenter'] as Map<String, dynamic>),
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      replies: (json['replies'] as List<dynamic>? ?? [])
          .map((e) => CommentModel.fromJson(e['commentId'], e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commenter': commenter.toJson(),
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'replies': replies.map((e) => e.toJson()).toList(),
    };
  }
}
