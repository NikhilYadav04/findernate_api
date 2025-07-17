class PostInteraction {
  final String? id;
  final String postId;
  final String userId;
  final String interactionType; //* "like", "comment", "share", "save", "view"
  final CommentData? comment;
  final ShareData? share;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDeleted;

  PostInteraction({
    this.id,
    required this.postId,
    required this.userId,
    required this.interactionType,
    this.comment,
    this.share,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
  });

  factory PostInteraction.fromJson(Map<String, dynamic> json) {
    return PostInteraction(
      id: json['_id']?.toString(),
      postId: json['postId'] ?? '',
      userId: json['userId'] ?? '',
      interactionType: json['interactionType'] ?? '',
      comment: json['comment'] != null
          ? CommentData.fromJson(json['comment'])
          : null,
      share: json['share'] != null ? ShareData.fromJson(json['share']) : null,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      isDeleted: json['isDeleted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'postId': postId,
      'userId': userId,
      'interactionType': interactionType,
      if (comment != null) 'comment': comment!.toJson(),
      if (share != null) 'share': share!.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isDeleted': isDeleted,
    };
  }
}

class CommentData {
  final String text;
  final String? parentCommentId;
  final List<String> mentions;
  final int likes;
  final int replies;
  final bool isEdited;
  final DateTime? editedAt;

  CommentData({
    required this.text,
    this.parentCommentId,
    this.mentions = const [],
    this.likes = 0,
    this.replies = 0,
    this.isEdited = false,
    this.editedAt,
  });

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      text: json['text'] ?? '',
      parentCommentId: json['parentCommentId'],
      mentions: List<String>.from(json['mentions'] ?? []),
      likes: json['likes'] ?? 0,
      replies: json['replies'] ?? 0,
      isEdited: json['isEdited'] ?? false,
      editedAt:
          json['editedAt'] != null ? DateTime.parse(json['editedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
      'mentions': mentions,
      'likes': likes,
      'replies': replies,
      'isEdited': isEdited,
      if (editedAt != null) 'editedAt': editedAt!.toIso8601String(),
    };
  }
}

class ShareData {
  final String shareType; // "story", "direct_message", "external"
  final String? platform; // "facebook", "twitter", etc.
  final String? recipientId;
  final String? message;

  ShareData({
    required this.shareType,
    this.platform,
    this.recipientId,
    this.message,
  });

  factory ShareData.fromJson(Map<String, dynamic> json) {
    return ShareData(
      shareType: json['shareType'] ?? '',
      platform: json['platform'],
      recipientId: json['recipientId'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shareType': shareType,
      if (platform != null) 'platform': platform,
      if (recipientId != null) 'recipientId': recipientId,
      if (message != null) 'message': message,
    };
  }
}
