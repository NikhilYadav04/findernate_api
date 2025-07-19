// Main Post Model
import 'package:social_media_clone/http/models/posts/model_business.dart';
import 'package:social_media_clone/http/models/posts/model_normal.dart';
import 'package:social_media_clone/http/models/posts/model_product.dart';
import 'package:social_media_clone/http/models/posts/model_service.dart';

class PostModel {
  final String id;
  final UserModel userId;
  final String postType;
  final String contentType;
  final String caption;
  final String? description;
  final List<String> hashtags;
  final List<String> mentions;
  final List<MediaModel> media;
  final CustomizationModel customization;
  final EngagementModel engagement;
  final SettingsModel settings;
  final String status;
  final bool isPromoted;
  final bool isFeatured;
  final bool isReported;
  final int reportCount;
  final AnalyticsModel analytics;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final double? score;

  PostModel({
    required this.id,
    required this.userId,
    required this.postType,
    required this.contentType,
    required this.caption,
    this.description,
    required this.hashtags,
    required this.mentions,
    required this.media,
    required this.customization,
    required this.engagement,
    required this.settings,
    required this.status,
    required this.isPromoted,
    required this.isFeatured,
    required this.isReported,
    required this.reportCount,
    required this.analytics,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.score,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] ?? '',
      userId: UserModel.fromJson(json['userId'] ?? {}),
      postType: json['postType'] ?? '',
      contentType: json['contentType'] ?? '',
      caption: json['caption'] ?? '',
      description: json['description'],
      hashtags: List<String>.from(json['hashtags'] ?? []),
      mentions: List<String>.from(json['mentions'] ?? []),
      media: (json['media'] as List? ?? [])
          .map((item) => MediaModel.fromJson(item))
          .toList(),
      customization: CustomizationModel.fromJson(json['customization'] ?? {}),
      engagement: EngagementModel.fromJson(json['engagement'] ?? {}),
      settings: SettingsModel.fromJson(json['settings'] ?? {}),
      status: json['status'] ?? '',
      isPromoted: json['isPromoted'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      isReported: json['isReported'] ?? false,
      reportCount: json['reportCount'] ?? 0,
      analytics: AnalyticsModel.fromJson(json['analytics'] ?? {}),
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      version: json['__v'] ?? 0,
      score: json['_score']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId.toJson(),
      'postType': postType,
      'contentType': contentType,
      'caption': caption,
      'description': description,
      'hashtags': hashtags,
      'mentions': mentions,
      'media': media.map((m) => m.toJson()).toList(),
      'customization': customization.toJson(),
      'engagement': engagement.toJson(),
      'settings': settings.toJson(),
      'status': status,
      'isPromoted': isPromoted,
      'isFeatured': isFeatured,
      'isReported': isReported,
      'reportCount': reportCount,
      'analytics': analytics.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': version,
      '_score': score,
    };
  }
}

// Customization Model (handles all content types)
class CustomizationModel {
  final NormalCustomizationModel? normal;
  final BusinessCustomizationModel? business;
  final ServiceCustomizationModel? service;
  final ProductCustomizationModel? product;

  CustomizationModel({
    this.normal,
    this.business,
    this.service,
    this.product,
  });

  factory CustomizationModel.fromJson(Map<String, dynamic> json) {
    return CustomizationModel(
      normal: json['normal'] != null
          ? NormalCustomizationModel.fromJson(json['normal'])
          : null,
      business: json['business'] != null
          ? BusinessCustomizationModel.fromJson(json['business'])
          : null,
      service: json['service'] != null
          ? ServiceCustomizationModel.fromJson(json['service'])
          : null,
      product: json['product'] != null
          ? ProductCustomizationModel.fromJson(json['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'normal': normal?.toJson(),
      'business': business?.toJson(),
      'service': service?.toJson(),
      'product': product?.toJson(),
    }..removeWhere((key, value) => value == null);
  }
}

// User Model
class UserModel {
  final String id;
  final String username;
  final String? profileImageUrl;

  UserModel({
    required this.id,
    required this.username,
    this.profileImageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'username': username,
      'profileImageUrl': profileImageUrl,
    };
  }
}

// Media Model
class MediaModel {
  final String type;
  final String url;
  final String? thumbnailUrl;
  final double? duration;
  final DimensionsModel? dimensions;
  final int? fileSize;
  final String? format;
  final List<dynamic> additionalMedia;

  MediaModel({
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.duration,
    this.dimensions,
    this.fileSize,
    this.format,
    required this.additionalMedia,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      type: json['type'] ?? '',
      url: json['url'] ?? '',
      thumbnailUrl: json['thumbnailUrl'],
      duration: json['duration']?.toDouble(),
      dimensions: json['dimensions'] != null
          ? DimensionsModel.fromJson(json['dimensions'])
          : null,
      fileSize: json['fileSize'],
      format: json['format'],
      additionalMedia: json['additionalMedia'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'dimensions': dimensions?.toJson(),
      'fileSize': fileSize,
      'format': format,
      'additionalMedia': additionalMedia,
    };
  }
}

// Dimensions Model
class DimensionsModel {
  final int width;
  final int height;

  DimensionsModel({
    required this.width,
    required this.height,
  });

  factory DimensionsModel.fromJson(Map<String, dynamic> json) {
    return DimensionsModel(
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

// Engagement Model
class EngagementModel {
  final int likes;
  final int comments;
  final int shares;
  final int saves;
  final int views;
  final int reach;
  final int impressions;

  EngagementModel({
    required this.likes,
    required this.comments,
    required this.shares,
    required this.saves,
    required this.views,
    required this.reach,
    required this.impressions,
  });

  factory EngagementModel.fromJson(Map<String, dynamic> json) {
    return EngagementModel(
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

// Settings Model
class SettingsModel {
  final String visibility;
  final bool allowComments;
  final bool allowLikes;
  final bool? allowShares;
  final List<dynamic> customAudience;

  SettingsModel({
    required this.visibility,
    required this.allowComments,
    required this.allowLikes,
    this.allowShares,
    required this.customAudience,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      visibility: json['visibility'] ?? '',
      allowComments: json['allowComments'] ?? false,
      allowLikes: json['allowLikes'] ?? false,
      allowShares: json['allowShares'],
      customAudience: json['customAudience'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visibility': visibility,
      'allowComments': allowComments,
      'allowLikes': allowLikes,
      'allowShares': allowShares,
      'customAudience': customAudience,
    };
  }
}

// Analytics Model
class AnalyticsModel {
  final List<dynamic> topCountries;
  final List<dynamic> topAgeGroups;
  final List<dynamic> peakViewingTimes;

  AnalyticsModel({
    required this.topCountries,
    required this.topAgeGroups,
    required this.peakViewingTimes,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic> json) {
    return AnalyticsModel(
      topCountries: json['topCountries'] ?? [],
      topAgeGroups: json['topAgeGroups'] ?? [],
      peakViewingTimes: json['peakViewingTimes'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topCountries': topCountries,
      'topAgeGroups': topAgeGroups,
      'peakViewingTimes': peakViewingTimes,
    };
  }
}

// API Response Models
class PostsResponseModel {
  final int statusCode;
  final PostsDataModel data;
  final String message;
  final bool success;

  PostsResponseModel({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory PostsResponseModel.fromJson(Map<String, dynamic> json) {
    return PostsResponseModel(
      statusCode: json['statusCode'] ?? 0,
      data: PostsDataModel.fromJson(json['data'] ?? {}),
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusCode': statusCode,
      'data': data.toJson(),
      'message': message,
      'success': success,
    };
  }
}

class PostsDataModel {
  final List<dynamic> stories;
  final List<PostModel> feed;
  final PaginationModel? pagination;

  PostsDataModel({
    required this.stories,
    required this.feed,
    this.pagination,
  });

  factory PostsDataModel.fromJson(Map<String, dynamic> json) {
    return PostsDataModel(
      stories: json['stories'] ?? [],
      feed: (json['feed'] as List? ?? [])
          .map((item) => PostModel.fromJson(item))
          .toList(),
      pagination: json['pagination'] != null
          ? PaginationModel.fromJson(json['pagination'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stories': stories,
      'feed': feed.map((p) => p.toJson()).toList(),
      'pagination': pagination?.toJson(),
    };
  }
}

class PaginationModel {
  final int page;
  final int limit;
  final int total;
  final int pages;

  PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.pages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: json['page'] ?? 0,
      limit: json['limit'] ?? 0,
      total: json['total'] ?? 0,
      pages: json['pages'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'limit': limit,
      'total': total,
      'pages': pages,
    };
  }
}
