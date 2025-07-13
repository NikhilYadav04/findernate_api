class SavedPostModel {
  final String postId;
  final DateTime savedAt;

  SavedPostModel({
    required this.postId,
    required this.savedAt,
  });

  factory SavedPostModel.fromJson(String postId, Map<String, dynamic> json) {
    return SavedPostModel(
      postId: postId,
      savedAt: DateTime.parse(json['saved_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'saved_at': savedAt.toIso8601String(),
    };
  }
} 