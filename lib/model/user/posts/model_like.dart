import 'package:social_media_clone/model/user/model_user_summary.dart';

class LikeModel {
  final String likeId;
  final UserSummary liker;
  final DateTime timestamp;

  LikeModel({
    required this.likeId,
    required this.liker,
    required this.timestamp,
  });

  factory LikeModel.fromJson(String likeId, Map<String, dynamic> json) {
    return LikeModel(
      likeId: likeId,
      liker: UserSummary.fromJson(json['liker'] as Map<String, dynamic>),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'liker': liker.toJson(),
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
