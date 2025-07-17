// post_enums_constants.dart

// Post Type Enums
enum PostType {
  photo,
  reel,
}

extension PostTypeExtension on PostType {
  String get value {
    switch (this) {
      case PostType.photo:
        return 'photo';
      case PostType.reel:
        return 'reel';
    }
  }

  static PostType fromString(String value) {
    switch (value) {
      case 'photo':
        return PostType.photo;
      case 'reel':
        return PostType.reel;
      default:
        return PostType.photo;
    }
  }
}

// Content Type Enums
enum ContentType {
  normal,
  product,
  service,
  business,
}

extension ContentTypeExtension on ContentType {
  String get value {
    switch (this) {
      case ContentType.normal:
        return 'normal';
      case ContentType.product:
        return 'product';
      case ContentType.service:
        return 'service';
      case ContentType.business:
        return 'business';
    }
  }

  String get displayName {
    switch (this) {
      case ContentType.normal:
        return 'Normal Post';
      case ContentType.product:
        return 'Product Post';
      case ContentType.service:
        return 'Service Post';
      case ContentType.business:
        return 'Business Post';
    }
  }

  static ContentType fromString(String value) {
    switch (value) {
      case 'normal':
        return ContentType.normal;
      case 'product':
        return ContentType.product;
      case 'service':
        return ContentType.service;
      case 'business':
        return ContentType.business;
      default:
        return ContentType.normal;
    }
  }
}

// Post Status Enums
enum PostStatus {
  draft,
  published,
  scheduled,
  archived,
  deleted,
}

extension PostStatusExtension on PostStatus {
  String get value {
    switch (this) {
      case PostStatus.draft:
        return 'draft';
      case PostStatus.published:
        return 'published';
      case PostStatus.scheduled:
        return 'scheduled';
      case PostStatus.archived:
        return 'archived';
      case PostStatus.deleted:
        return 'deleted';
    }
  }

  String get displayName {
    switch (this) {
      case PostStatus.draft:
        return 'Draft';
      case PostStatus.published:
        return 'Published';
      case PostStatus.scheduled:
        return 'Scheduled';
      case PostStatus.archived:
        return 'Archived';
      case PostStatus.deleted:
        return 'Deleted';
    }
  }

  static PostStatus fromString(String value) {
    switch (value) {
      case 'draft':
        return PostStatus.draft;
      case 'published':
        return PostStatus.published;
      case 'scheduled':
        return PostStatus.scheduled;
      case 'archived':
        return PostStatus.archived;
      case 'deleted':
        return PostStatus.deleted;
      default:
        return PostStatus.draft;
    }
  }
}

// Visibility Enums
enum PostVisibility {
  public,
  private,
  followers,
  custom,
}

extension PostVisibilityExtension on PostVisibility {
  String get value {
    switch (this) {
      case PostVisibility.public:
        return 'public';
      case PostVisibility.private:
        return 'private';
      case PostVisibility.followers:
        return 'followers';
      case PostVisibility.custom:
        return 'custom';
    }
  }

  String get displayName {
    switch (this) {
      case PostVisibility.public:
        return 'Public';
      case PostVisibility.private:
        return 'Private';
      case PostVisibility.followers:
        return 'Followers Only';
      case PostVisibility.custom:
        return 'Custom';
    }
  }

  static PostVisibility fromString(String value) {
    switch (value) {
      case 'public':
        return PostVisibility.public;
      case 'private':
        return PostVisibility.private;
      case 'followers':
        return PostVisibility.followers;
      case 'custom':
        return PostVisibility.custom;
      default:
        return PostVisibility.public;
    }
  }
}

// Media Type Enums
enum MediaType {
  image,
  video,
}

extension MediaTypeExtension on MediaType {
  String get value {
    switch (this) {
      case MediaType.image:
        return 'image';
      case MediaType.video:
        return 'video';
    }
  }

  static MediaType fromString(String value) {
    switch (value) {
      case 'image':
        return MediaType.image;
      case 'video':
        return MediaType.video;
      default:
        return MediaType.image;
    }
  }
}

// Product Availability Enums
enum ProductAvailability {
  inStock,
  outOfStock,
  limited,
}

extension ProductAvailabilityExtension on ProductAvailability {
  String get value {
    switch (this) {
      case ProductAvailability.inStock:
        return 'in_stock';
      case ProductAvailability.outOfStock:
        return 'out_of_stock';
      case ProductAvailability.limited:
        return 'limited';
    }
  }

  String get displayName {
    switch (this) {
      case ProductAvailability.inStock:
        return 'In Stock';
      case ProductAvailability.outOfStock:
        return 'Out of Stock';
      case ProductAvailability.limited:
        return 'Limited Stock';
    }
  }

  static ProductAvailability fromString(String value) {
    switch (value) {
      case 'in_stock':
        return ProductAvailability.inStock;
      case 'out_of_stock':
        return ProductAvailability.outOfStock;
      case 'limited':
        return ProductAvailability.limited;
      default:
        return ProductAvailability.inStock;
    }
  }
}

// Service Type Enums
enum ServiceType {
  videoCall,
  audioCall,
  videoMessage,
  inPerson,
  hybrid,
}

extension ServiceTypeExtension on ServiceType {
  String get value {
    switch (this) {
      case ServiceType.videoCall:
        return 'video_call';
      case ServiceType.audioCall:
        return 'audio_call';
      case ServiceType.videoMessage:
        return 'video_message';
      case ServiceType.inPerson:
        return 'in_person';
      case ServiceType.hybrid:
        return 'hybrid';
    }
  }

  String get displayName {
    switch (this) {
      case ServiceType.videoCall:
        return 'Video Call';
      case ServiceType.audioCall:
        return 'Audio Call';
      case ServiceType.videoMessage:
        return 'Video Message';
      case ServiceType.inPerson:
        return 'In Person';
      case ServiceType.hybrid:
        return 'Hybrid';
    }
  }

  static ServiceType fromString(String value) {
    switch (value) {
      case 'video_call':
        return ServiceType.videoCall;
      case 'audio_call':
        return ServiceType.audioCall;
      case 'video_message':
        return ServiceType.videoMessage;
      case 'in_person':
        return ServiceType.inPerson;
      case 'hybrid':
        return ServiceType.hybrid;
      default:
        return ServiceType.inPerson;
    }
  }
}

// Interaction Type Enums
enum InteractionType {
  like,
  comment,
  share,
  save,
  view,
}

extension InteractionTypeExtension on InteractionType {
  String get value {
    switch (this) {
      case InteractionType.like:
        return 'like';
      case InteractionType.comment:
        return 'comment';
      case InteractionType.share:
        return 'share';
      case InteractionType.save:
        return 'save';
      case InteractionType.view:
        return 'view';
    }
  }

  String get displayName {
    switch (this) {
      case InteractionType.like:
        return 'Like';
      case InteractionType.comment:
        return 'Comment';
      case InteractionType.share:
        return 'Share';
      case InteractionType.save:
        return 'Save';
      case InteractionType.view:
        return 'View';
    }
  }

  static InteractionType fromString(String value) {
    switch (value) {
      case 'like':
        return InteractionType.like;
      case 'comment':
        return InteractionType.comment;
      case 'share':
        return InteractionType.share;
      case 'save':
        return InteractionType.save;
      case 'view':
        return InteractionType.view;
      default:
        return InteractionType.view;
    }
  }
}

// Share Type Enums
enum ShareType {
  story,
  directMessage,
  external,
}

extension ShareTypeExtension on ShareType {
  String get value {
    switch (this) {
      case ShareType.story:
        return 'story';
      case ShareType.directMessage:
        return 'direct_message';
      case ShareType.external:
        return 'external';
    }
  }

  String get displayName {
    switch (this) {
      case ShareType.story:
        return 'Share to Story';
      case ShareType.directMessage:
        return 'Direct Message';
      case ShareType.external:
        return 'External Share';
    }
  }

  static ShareType fromString(String value) {
    switch (value) {
      case 'story':
        return ShareType.story;
      case 'direct_message':
        return ShareType.directMessage;
      case 'external':
        return ShareType.external;
      default:
        return ShareType.directMessage;
    }
  }
}

// Constants
class PostConstants {
  // Post Categories
  static const List<String> postCategories = [
    'Personal Life',
    'Travel',
    'Food & Dining',
    'Fashion & Style',
    'Health & Fitness',
    'Technology',
    'Art & Culture',
    'Sports',
    'Entertainment',
    'Education',
    'Business',
    'Other'
  ];

  // Product Categories
  static const List<String> productCategories = [
    'Electronics',
    'Clothing',
    'Home & Garden',
    'Sports & Outdoors',
    'Beauty & Health',
    'Books & Media',
    'Toys & Games',
    'Automotive',
    'Food & Beverages',
    'Jewelry & Accessories',
    'Other'
  ];

  // Service Categories
  static const List<String> serviceCategories = [
    'Health & Wellness',
    'Education & Training',
    'Technology & IT',
    'Business & Finance',
    'Creative Services',
    'Home & Maintenance',
    'Beauty & Personal Care',
    'Transportation',
    'Entertainment',
    'Legal Services',
    'Other'
  ];

  // Business Types
  static const List<String> businessTypes = [
    'Restaurant',
    'Retail Store',
    'Service Provider',
    'Healthcare',
    'Education',
    'Technology',
    'Real Estate',
    'Entertainment',
    'Non-Profit',
    'Manufacturing',
    'Other'
  ];

  // Currencies
  static const List<String> currencies = [
    'USD',
    'EUR',
    'GBP',
    'INR',
    'JPY',
    'AUD',
    'CAD',
    'CHF',
    'CNY',
    'BRL'
  ];

  // Price Ranges
  static const List<String> priceRanges = [
    '\$', // Budget
    '\$\$', // Moderate
    '\$\$\$', // Expensive
    '\$\$\$\$' // Very Expensive
  ];

  // Common Moods
  static const List<String> moods = [
    'Happy',
    'Excited',
    'Grateful',
    'Motivated',
    'Relaxed',
    'Confident',
    'Inspired',
    'Peaceful',
    'Energetic',
    'Content'
  ];

  // Common Activities
  static const List<String> activities = [
    'Traveling',
    'Working',
    'Relaxing',
    'Exercising',
    'Cooking',
    'Reading',
    'Shopping',
    'Studying',
    'Socializing',
    'Creating'
  ];

  // Common Features for Business
  static const List<String> businessFeatures = [
    'WiFi',
    'Parking',
    'Delivery',
    'Takeout',
    'Wheelchair Accessible',
    'Pet Friendly',
    'Outdoor Seating',
    'Air Conditioning',
    'Credit Cards Accepted',
    'Reservations'
  ];

  // Maximum limits
  static const int maxHashtagsPerPost = 30;
  static const int maxMentionsPerPost = 20;
  static const int maxCaptionLength = 2200;
  static const int maxDescriptionLength = 500;
  static const int maxCommentLength = 2200;
  static const int maxProductVariants = 10;
  static const int maxProductImages = 10;
  static const int maxBusinessPromotions = 5;
}
