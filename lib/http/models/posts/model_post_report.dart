// post_reports_model.dart
class PostReport {
  final String? id;
  final String postId;
  final String reportedBy;
  final String reason;
  final String description;
  final String status;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  final String? action;
  final DateTime createdAt;

  PostReport({
    this.id,
    required this.postId,
    required this.reportedBy,
    required this.reason,
    required this.description,
    this.status = 'pending',
    this.reviewedBy,
    this.reviewedAt,
    this.action,
    required this.createdAt,
  });

  factory PostReport.fromJson(Map<String, dynamic> json) {
    return PostReport(
      id: json['_id']?.toString(),
      postId: json['postId'] ?? '',
      reportedBy: json['reportedBy'] ?? '',
      reason: json['reason'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      reviewedBy: json['reviewedBy'],
      reviewedAt: json['reviewedAt'] != null
          ? DateTime.parse(json['reviewedAt'])
          : null,
      action: json['action'],
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'postId': postId,
      'reportedBy': reportedBy,
      'reason': reason,
      'description': description,
      'status': status,
      if (reviewedBy != null) 'reviewedBy': reviewedBy,
      if (reviewedAt != null) 'reviewedAt': reviewedAt!.toIso8601String(),
      if (action != null) 'action': action,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

// Enum for report reasons
enum ReportReason {
  spam,
  inappropriate,
  copyright,
  harassment,
  misinformation,
  violentContent,
  hateSpeech,
  nudity,
  selfHarm,
  terrorismViolentExtremism,
  other,
}

extension ReportReasonExtension on ReportReason {
  String get value {
    switch (this) {
      case ReportReason.spam:
        return 'spam';
      case ReportReason.inappropriate:
        return 'inappropriate';
      case ReportReason.copyright:
        return 'copyright';
      case ReportReason.harassment:
        return 'harassment';
      case ReportReason.misinformation:
        return 'misinformation';
      case ReportReason.violentContent:
        return 'violent_content';
      case ReportReason.hateSpeech:
        return 'hate_speech';
      case ReportReason.nudity:
        return 'nudity';
      case ReportReason.selfHarm:
        return 'self_harm';
      case ReportReason.terrorismViolentExtremism:
        return 'terrorism_violent_extremism';
      case ReportReason.other:
        return 'other';
    }
  }

  String get displayName {
    switch (this) {
      case ReportReason.spam:
        return 'Spam';
      case ReportReason.inappropriate:
        return 'Inappropriate Content';
      case ReportReason.copyright:
        return 'Copyright Violation';
      case ReportReason.harassment:
        return 'Harassment or Bullying';
      case ReportReason.misinformation:
        return 'False Information';
      case ReportReason.violentContent:
        return 'Violent Content';
      case ReportReason.hateSpeech:
        return 'Hate Speech';
      case ReportReason.nudity:
        return 'Nudity or Sexual Content';
      case ReportReason.selfHarm:
        return 'Self-Harm or Suicide';
      case ReportReason.terrorismViolentExtremism:
        return 'Terrorism or Violent Extremism';
      case ReportReason.other:
        return 'Other';
    }
  }

  static ReportReason fromString(String value) {
    switch (value) {
      case 'spam':
        return ReportReason.spam;
      case 'inappropriate':
        return ReportReason.inappropriate;
      case 'copyright':
        return ReportReason.copyright;
      case 'harassment':
        return ReportReason.harassment;
      case 'misinformation':
        return ReportReason.misinformation;
      case 'violent_content':
        return ReportReason.violentContent;
      case 'hate_speech':
        return ReportReason.hateSpeech;
      case 'nudity':
        return ReportReason.nudity;
      case 'self_harm':
        return ReportReason.selfHarm;
      case 'terrorism_violent_extremism':
        return ReportReason.terrorismViolentExtremism;
      default:
        return ReportReason.other;
    }
  }
}

// Enum for report status
enum ReportStatus {
  pending,
  reviewed,
  resolved,
  dismissed,
}

extension ReportStatusExtension on ReportStatus {
  String get value {
    switch (this) {
      case ReportStatus.pending:
        return 'pending';
      case ReportStatus.reviewed:
        return 'reviewed';
      case ReportStatus.resolved:
        return 'resolved';
      case ReportStatus.dismissed:
        return 'dismissed';
    }
  }

  String get displayName {
    switch (this) {
      case ReportStatus.pending:
        return 'Pending Review';
      case ReportStatus.reviewed:
        return 'Under Review';
      case ReportStatus.resolved:
        return 'Resolved';
      case ReportStatus.dismissed:
        return 'Dismissed';
    }
  }

  static ReportStatus fromString(String value) {
    switch (value) {
      case 'pending':
        return ReportStatus.pending;
      case 'reviewed':
        return ReportStatus.reviewed;
      case 'resolved':
        return ReportStatus.resolved;
      case 'dismissed':
        return ReportStatus.dismissed;
      default:
        return ReportStatus.pending;
    }
  }
}

// Enum for moderation actions
enum ModerationAction {
  noAction,
  warning,
  postRemoved,
  userSuspended,
  userBanned,
  postHidden,
  contentRestricted,
}

extension ModerationActionExtension on ModerationAction {
  String get value {
    switch (this) {
      case ModerationAction.noAction:
        return 'no_action';
      case ModerationAction.warning:
        return 'warning';
      case ModerationAction.postRemoved:
        return 'post_removed';
      case ModerationAction.userSuspended:
        return 'user_suspended';
      case ModerationAction.userBanned:
        return 'user_banned';
      case ModerationAction.postHidden:
        return 'post_hidden';
      case ModerationAction.contentRestricted:
        return 'content_restricted';
    }
  }

  String get displayName {
    switch (this) {
      case ModerationAction.noAction:
        return 'No Action Required';
      case ModerationAction.warning:
        return 'Warning Issued';
      case ModerationAction.postRemoved:
        return 'Post Removed';
      case ModerationAction.userSuspended:
        return 'User Suspended';
      case ModerationAction.userBanned:
        return 'User Banned';
      case ModerationAction.postHidden:
        return 'Post Hidden';
      case ModerationAction.contentRestricted:
        return 'Content Restricted';
    }
  }

  static ModerationAction fromString(String value) {
    switch (value) {
      case 'no_action':
        return ModerationAction.noAction;
      case 'warning':
        return ModerationAction.warning;
      case 'post_removed':
        return ModerationAction.postRemoved;
      case 'user_suspended':
        return ModerationAction.userSuspended;
      case 'user_banned':
        return ModerationAction.userBanned;
      case 'post_hidden':
        return ModerationAction.postHidden;
      case 'content_restricted':
        return ModerationAction.contentRestricted;
      default:
        return ModerationAction.noAction;
    }
  }
}
