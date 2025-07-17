// post_model.dart
import 'package:social_media_clone/http/models/posts/model_post_customization.dart';

class Post {
  final String? id;
  final String userId;
  final String postType; //* "photo" or "reel"
  final String contentType; //* "normal", "product", "service", "business"
  final String caption;
  final String description;
  final List<String> hashtags;
  final List<String> mentions;
  final MediaContent media;
  final PostCustomization customization;
  final EngagementMetrics engagement;
  final PostSettings settings;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? scheduledAt;
  final DateTime? publishedAt;
  final String
      status; //* "draft", "published", "scheduled", "archived", "deleted"
  final bool isPromoted;
  final bool isFeatured;
  final bool isReported;
  final int reportCount;
  final AnalyticsData? analytics;

  Post({
    this.id,
    required this.userId,
    required this.postType,
    required this.contentType,
    required this.caption,
    required this.description,
    required this.hashtags,
    required this.mentions,
    required this.media,
    required this.customization,
    required this.engagement,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
    this.scheduledAt,
    this.publishedAt,
    required this.status,
    this.isPromoted = false,
    this.isFeatured = false,
    this.isReported = false,
    this.reportCount = 0,
    this.analytics,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id']?.toString(),
      userId: json['userId'] ?? '',
      postType: json['postType'] ?? '',
      contentType: json['contentType'] ?? '',
      caption: json['caption'] ?? '',
      description: json['description'] ?? '',
      hashtags: List<String>.from(json['hashtags'] ?? []),
      mentions: List<String>.from(json['mentions'] ?? []),
      media: MediaContent.fromJson(json['media'] ?? {}),
      customization: PostCustomization.fromJson(json['customization'] ?? {}),
      engagement: EngagementMetrics.fromJson(json['engagement'] ?? {}),
      settings: PostSettings.fromJson(json['settings'] ?? {}),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.parse(json['scheduledAt'])
          : null,
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      status: json['status'] ?? 'draft',
      isPromoted: json['isPromoted'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      isReported: json['isReported'] ?? false,
      reportCount: json['reportCount'] ?? 0,
      analytics: json['analytics'] != null
          ? AnalyticsData.fromJson(json['analytics'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'userId': userId,
      'postType': postType,
      'contentType': contentType,
      'caption': caption,
      'description': description,
      'hashtags': hashtags,
      'mentions': mentions,
      'media': media.toJson(),
      'customization': customization.toJson(),
      'engagement': engagement.toJson(),
      'settings': settings.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      if (scheduledAt != null) 'scheduledAt': scheduledAt!.toIso8601String(),
      if (publishedAt != null) 'publishedAt': publishedAt!.toIso8601String(),
      'status': status,
      'isPromoted': isPromoted,
      'isFeatured': isFeatured,
      'isReported': isReported,
      'reportCount': reportCount,
      if (analytics != null) 'analytics': analytics!.toJson(),
    };
  }
}

class MediaContent {
  final String type; //* "image" or "video"
  final String url;
  final String? thumbnailUrl;
  final int? duration; //* Duration in seconds for reels
  final MediaDimensions dimensions;
  final int? fileSize;
  final String? format;
  final List<AdditionalMedia> additionalMedia;

  MediaContent({
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.duration,
    required this.dimensions,
    this.fileSize,
    this.format,
    this.additionalMedia = const [],
  });

  factory MediaContent.fromJson(Map<String, dynamic> json) {
    return MediaContent(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'],
      duration: json['duration'],
      dimensions: MediaDimensions.fromJson(json['dimensions'] ?? {}),
      fileSize: json['fileSize'],
      format: json['format'],
      additionalMedia: (json['additionalMedia'] as List<dynamic>?)
              ?.map((item) => AdditionalMedia.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      if (duration != null) 'duration': duration,
      'dimensions': dimensions.toJson(),
      if (fileSize != null) 'fileSize': fileSize,
      if (format != null) 'format': format,
      'additionalMedia': additionalMedia.map((item) => item.toJson()).toList(),
    };
  }
}

class MediaDimensions {
  final int width;
  final int height;

  MediaDimensions({
    required this.width,
    required this.height,
  });

  factory MediaDimensions.fromJson(Map<String, dynamic> json) {
    return MediaDimensions(
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
    };
  }
}

class AdditionalMedia {
  final String url;
  final String? thumbnailUrl;
  final MediaDimensions dimensions;
  final int order;

  AdditionalMedia({
    required this.url,
    this.thumbnailUrl,
    required this.dimensions,
    required this.order,
  });

  factory AdditionalMedia.fromJson(Map<String, dynamic> json) {
    return AdditionalMedia(
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'],
      dimensions: MediaDimensions.fromJson(json['dimensions'] ?? {}),
      order: json['order'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'dimensions': dimensions.toJson(),
      'order': order,
    };
  }
}

class EngagementMetrics {
  final int likes;
  final int comments;
  final int shares;
  final int saves;
  final int views;
  final int reach;
  final int impressions;

  EngagementMetrics({
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.saves = 0,
    this.views = 0,
    this.reach = 0,
    this.impressions = 0,
  });

  factory EngagementMetrics.fromJson(Map<String, dynamic> json) {
    return EngagementMetrics(
      likes: json['likes'] ?? 0,
      comments: json['comments'] ?? 0,
      shares: json['shares'] ?? 0,
      saves: json['saves'] ?? 0,
      views: json['views'] ?? 0,
      reach: json['reach'] ?? 0,
      impressions: json['impressions'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'saves': saves,
      'views': views,
      'reach': reach,
      'impressions': impressions,
    };
  }
}

class PostSettings {
  final String visibility; //* "public", "private", "followers", "custom"
  final bool allowComments;
  final bool allowLikes;
  final bool allowShares;
  final bool allowSaves;
  final String commentsFilter; //* "all", "followers", "none"
  final bool hideLikeCount;
  final bool allowDownload;
  final List<String> customAudience;

  PostSettings({
    this.visibility = 'public',
    this.allowComments = true,
    this.allowLikes = true,
    this.allowShares = true,
    this.allowSaves = true,
    this.commentsFilter = 'all',
    this.hideLikeCount = false,
    this.allowDownload = true,
    this.customAudience = const [],
  });

  factory PostSettings.fromJson(Map<String, dynamic> json) {
    return PostSettings(
      visibility: json['visibility'] ?? 'public',
      allowComments: json['allowComments'] ?? true,
      allowLikes: json['allowLikes'] ?? true,
      allowShares: json['allowShares'] ?? true,
      allowSaves: json['allowSaves'] ?? true,
      commentsFilter: json['commentsFilter'] ?? 'all',
      hideLikeCount: json['hideLikeCount'] ?? false,
      allowDownload: json['allowDownload'] ?? true,
      customAudience: List<String>.from(json['customAudience'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visibility': visibility,
      'allowComments': allowComments,
      'allowLikes': allowLikes,
      'allowShares': allowShares,
      'allowSaves': allowSaves,
      'commentsFilter': commentsFilter,
      'hideLikeCount': hideLikeCount,
      'allowDownload': allowDownload,
      'customAudience': customAudience,
    };
  }
}

class AnalyticsData {
  final int clickThroughs;
  final int inquiries;
  final int conversions;
  final List<String> topCountries;
  final List<String> topAgeGroups;
  final GenderDistribution genderDistribution;
  final List<PeakViewingTime> peakViewingTimes;

  AnalyticsData({
    this.clickThroughs = 0,
    this.inquiries = 0,
    this.conversions = 0,
    this.topCountries = const [],
    this.topAgeGroups = const [],
    required this.genderDistribution,
    this.peakViewingTimes = const [],
  });

  factory AnalyticsData.fromJson(Map<String, dynamic> json) {
    return AnalyticsData(
      clickThroughs: json['clickThroughs'] ?? 0,
      inquiries: json['inquiries'] ?? 0,
      conversions: json['conversions'] ?? 0,
      topCountries: List<String>.from(json['topCountries'] ?? []),
      topAgeGroups: List<String>.from(json['topAgeGroups'] ?? []),
      genderDistribution:
          GenderDistribution.fromJson(json['genderDistribution'] ?? {}),
      peakViewingTimes: (json['peakViewingTimes'] as List<dynamic>?)
              ?.map((item) => PeakViewingTime.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clickThroughs': clickThroughs,
      'inquiries': inquiries,
      'conversions': conversions,
      'topCountries': topCountries,
      'topAgeGroups': topAgeGroups,
      'genderDistribution': genderDistribution.toJson(),
      'peakViewingTimes':
          peakViewingTimes.map((item) => item.toJson()).toList(),
    };
  }
}

class GenderDistribution {
  final int male;
  final int female;
  final int other;

  GenderDistribution({
    this.male = 0,
    this.female = 0,
    this.other = 0,
  });

  factory GenderDistribution.fromJson(Map<String, dynamic> json) {
    return GenderDistribution(
      male: json['male'] ?? 0,
      female: json['female'] ?? 0,
      other: json['other'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'male': male,
      'female': female,
      'other': other,
    };
  }
}

class PeakViewingTime {
  final int hour;
  final int count;

  PeakViewingTime({
    required this.hour,
    required this.count,
  });

  factory PeakViewingTime.fromJson(Map<String, dynamic> json) {
    return PeakViewingTime(
      hour: json['hour'] ?? 0,
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hour': hour,
      'count': count,
    };
  }
}
