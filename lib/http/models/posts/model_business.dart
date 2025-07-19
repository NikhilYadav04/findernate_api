// business_customization_model.dart

class BusinessCustomizationModel {
  final String businessName;
  final String businessType;
  final String description;
  final String category;
  final String? subcategory;
  final ContactModel contact;
  final BusinessLocationModel location;
  final List<BusinessHoursModel> hours;
  final List<String> features;
  final String? priceRange;
  final double? rating;
  final List<String> tags;
  final String? announcement;
  final List<PromotionModel> promotions;
  final String? link;

  BusinessCustomizationModel({
    required this.businessName,
    required this.businessType,
    required this.description,
    required this.category,
    this.subcategory,
    required this.contact,
    required this.location,
    required this.hours,
    required this.features,
    this.priceRange,
    this.rating,
    required this.tags,
    this.announcement,
    required this.promotions,
    this.link,
  });

  factory BusinessCustomizationModel.fromJson(Map<String, dynamic> json) {
    return BusinessCustomizationModel(
      businessName: json['businessName'] ?? '',
      businessType: json['businessType'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      subcategory: json['subcategory'],
      contact: ContactModel.fromJson(json['contact'] ?? {}),
      location: BusinessLocationModel.fromJson(json['location'] ?? {}),
      hours: (json['hours'] as List? ?? [])
          .map((item) => BusinessHoursModel.fromJson(item))
          .toList(),
      features: List<String>.from(json['features'] ?? []),
      priceRange: json['priceRange'],
      rating: json['rating']?.toDouble(),
      tags: List<String>.from(json['tags'] ?? []),
      announcement: json['announcement'],
      promotions: (json['promotions'] as List? ?? [])
          .map((item) => PromotionModel.fromJson(item))
          .toList(),
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessName': businessName,
      'businessType': businessType,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'contact': contact.toJson(),
      'location': location.toJson(),
      'hours': hours.map((h) => h.toJson()).toList(),
      'features': features,
      'priceRange': priceRange,
      'rating': rating,
      'tags': tags,
      'announcement': announcement,
      'promotions': promotions.map((p) => p.toJson()).toList(),
      'link': link,
    };
  }
}

class ContactModel {
  final String phone;
  final String email;
  final String? website;
  final List<SocialMediaModel> socialMedia;

  ContactModel({
    required this.phone,
    required this.email,
    this.website,
    required this.socialMedia,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      website: json['website'],
      socialMedia: (json['socialMedia'] as List? ?? [])
          .map((item) => SocialMediaModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'website': website,
      'socialMedia': socialMedia.map((s) => s.toJson()).toList(),
    };
  }
}

class SocialMediaModel {
  final String platform;
  final String url;

  SocialMediaModel({
    required this.platform,
    required this.url,
  });

  factory SocialMediaModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaModel(
      platform: json['platform'] ?? '',
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platform': platform,
      'url': url,
    };
  }
}

class BusinessLocationModel {
  final String address;
  final String city;
  final String state;
  final String country;
  final String? postalCode;

  BusinessLocationModel({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    this.postalCode,
  });

  factory BusinessLocationModel.fromJson(Map<String, dynamic> json) {
    return BusinessLocationModel(
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postalCode: json['postalCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
    };
  }
}

class BusinessHoursModel {
  final String day;
  final String openTime;
  final String closeTime;
  final bool isClosed;

  BusinessHoursModel({
    required this.day,
    required this.openTime,
    required this.closeTime,
    required this.isClosed,
  });

  factory BusinessHoursModel.fromJson(Map<String, dynamic> json) {
    return BusinessHoursModel(
      day: json['day'] ?? '',
      openTime: json['openTime'] ?? '',
      closeTime: json['closeTime'] ?? '',
      isClosed: json['isClosed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'openTime': openTime,
      'closeTime': closeTime,
      'isClosed': isClosed,
    };
  }
}

class PromotionModel {
  final String title;
  final String description;
  final int discount;
  final DateTime validUntil;
  final bool isActive;

  PromotionModel({
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
    required this.isActive,
  });

  factory PromotionModel.fromJson(Map<String, dynamic> json) {
    return PromotionModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discount: json['discount'] ?? 0,
      validUntil: DateTime.parse(json['validUntil'] ?? DateTime.now().toIso8601String()),
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'discount': discount,
      'validUntil': validUntil.toIso8601String(),
      'isActive': isActive,
    };
  }
}