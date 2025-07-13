// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostModel {
  final String authorId;
  final String postId;
  final List<String> mediaUrl;
  final String mediaType;
  final String caption;
  final String location;
  final DateTime timestamp;
  final List<String> taggedUsers;
  final String createdBy;
  final String createdByImageURL;
  final String first_liker_username;
  final String first_liker_profileURL;
  final int likeCount;
  final int commentCount;
  final String videoThumbnail; // ✅ NEW FIELD

  PostModel({
    required this.authorId,
    required this.postId,
    required this.mediaUrl,
    required this.mediaType,
    required this.caption,
    required this.location,
    required this.timestamp,
    required this.taggedUsers,
    required this.createdBy,
    required this.createdByImageURL,
    required this.first_liker_username,
    required this.first_liker_profileURL,
    required this.likeCount,
    required this.commentCount,
    required this.videoThumbnail,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['post_id'] as String,
      mediaUrl: List<String>.from(json['media_url'] ?? []),
      mediaType: json['media_type'] as String,
      caption: json['caption'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      taggedUsers: List<String>.from(json['tagged_users'] ?? []),
      createdBy: json['created_by'] as String,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
      location: json['location'] as String,
      createdByImageURL: json['createdByImageURL'] as String,
      authorId: json['authorId'] as String,
      first_liker_username: json['first_liker_username'] as String,
      first_liker_profileURL: json['first_liker_profile_url'] as String,
      videoThumbnail: json['video_thumbnail'] as String? ?? '', // ✅ READ FIELD
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'media_url': mediaUrl,
      'media_type': mediaType,
      'caption': caption,
      'timestamp': timestamp.toIso8601String(),
      'tagged_users': taggedUsers,
      'created_by': createdBy,
      'like_count': likeCount,
      'comment_count': commentCount,
      'location': location,
      'createdByImageURL': createdByImageURL,
      'authorId': authorId,
      'first_liker_username': first_liker_username,
      'first_liker_profile_url': first_liker_profileURL,
      'video_thumbnail': videoThumbnail, // ✅ WRITE FIELD
    };
  }
}
