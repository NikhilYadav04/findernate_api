// post_customization_model.dart
class PostCustomization {
  final ProductCustomization? product;
  final ServiceCustomization? service;
  final BusinessCustomization? business;
  final NormalCustomization? normal;

  PostCustomization({
    this.product,
    this.service,
    this.business,
    this.normal,
  });

  factory PostCustomization.fromJson(Map<String, dynamic> json) {
    return PostCustomization(
      product: json['product'] != null
          ? ProductCustomization.fromJson(json['product'])
          : null,
      service: json['service'] != null
          ? ServiceCustomization.fromJson(json['service'])
          : null,
      business: json['business'] != null
          ? BusinessCustomization.fromJson(json['business'])
          : null,
      normal: json['normal'] != null
          ? NormalCustomization.fromJson(json['normal'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (product != null) 'product': product!.toJson(),
      if (service != null) 'service': service!.toJson(),
      if (business != null) 'business': business!.toJson(),
      if (normal != null) 'normal': normal!.toJson(),
    };
  }
}

// Product Customization
class ProductCustomization {
  final String name;
  final String description;
  final double price;
  final String currency;
  final String category;
  final String subcategory;
  final String brand;
  final String sku;
  final String availability; //* "in_stock", "out_of_stock", "limited"
  final List<ProductVariant> variants;
  final List<ProductSpecification> specifications;
  final List<String> images;
  final List<String> tags;
  final double? weight;
  final ProductDimensions? dimensions;

  ProductCustomization({
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.category,
    required this.subcategory,
    required this.brand,
    required this.sku,
    required this.availability,
    this.variants = const [],
    this.specifications = const [],
    this.images = const [],
    this.tags = const [],
    this.weight,
    this.dimensions,
  });

  factory ProductCustomization.fromJson(Map<String, dynamic> json) {
    return ProductCustomization(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency'] ?? '',
      category: json['category'] ?? '',
      subcategory: json['subcategory'] ?? '',
      brand: json['brand'] ?? '',
      sku: json['sku'] ?? '',
      availability: json['availability'] ?? 'in_stock',
      variants: (json['variants'] as List<dynamic>?)
              ?.map((item) => ProductVariant.fromJson(item))
              .toList() ??
          [],
      specifications: (json['specifications'] as List<dynamic>?)
              ?.map((item) => ProductSpecification.fromJson(item))
              .toList() ??
          [],
      images: List<String>.from(json['images'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      weight: json['weight']?.toDouble(),
      dimensions: json['dimensions'] != null
          ? ProductDimensions.fromJson(json['dimensions'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'category': category,
      'subcategory': subcategory,
      'brand': brand,
      'sku': sku,
      'availability': availability,
      'variants': variants.map((item) => item.toJson()).toList(),
      'specifications': specifications.map((item) => item.toJson()).toList(),
      'images': images,
      'tags': tags,
      if (weight != null) 'weight': weight,
      if (dimensions != null) 'dimensions': dimensions!.toJson(),
    };
  }
}

class ProductVariant {
  final String name;
  final List<String> options;

  ProductVariant({
    required this.name,
    required this.options,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      name: json['name'] ?? '',
      options: List<String>.from(json['options'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'options': options,
    };
  }
}

class ProductSpecification {
  final String key;
  final String value;

  ProductSpecification({
    required this.key,
    required this.value,
  });

  factory ProductSpecification.fromJson(Map<String, dynamic> json) {
    return ProductSpecification(
      key: json['key'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}

class ProductDimensions {
  final double length;
  final double width;
  final double height;
  final String unit;

  ProductDimensions({
    required this.length,
    required this.width,
    required this.height,
    required this.unit,
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) {
    return ProductDimensions(
      length: (json['length'] ?? 0).toDouble(),
      width: (json['width'] ?? 0).toDouble(),
      height: (json['height'] ?? 0).toDouble(),
      unit: json['unit'] ?? 'cm',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'width': width,
      'height': height,
      'unit': unit,
    };
  }
}

// Service Customization
class ServiceCustomization {
  final String name;
  final String description;
  final double price;
  final String currency;
  final String category;
  final String subcategory;
  final int duration; // Duration in minutes
  final String
      serviceType; // "video_call", "audio_call", "video_message", "in_person"
  final ServiceAvailability availability;
  final ServiceLocation location;
  final List<String> requirements;
  final List<String> deliverables;
  final List<String> tags;

  ServiceCustomization({
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.category,
    required this.subcategory,
    required this.duration,
    required this.serviceType,
    required this.availability,
    required this.location,
    this.requirements = const [],
    this.deliverables = const [],
    this.tags = const [],
  });

  factory ServiceCustomization.fromJson(Map<String, dynamic> json) {
    return ServiceCustomization(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      currency: json['currency'] ?? '',
      category: json['category'] ?? '',
      subcategory: json['subcategory'] ?? '',
      duration: json['duration'] ?? 0,
      serviceType: json['serviceType'] ?? '',
      availability: ServiceAvailability.fromJson(json['availability'] ?? {}),
      location: ServiceLocation.fromJson(json['location'] ?? {}),
      requirements: List<String>.from(json['requirements'] ?? []),
      deliverables: List<String>.from(json['deliverables'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'currency': currency,
      'category': category,
      'subcategory': subcategory,
      'duration': duration,
      'serviceType': serviceType,
      'availability': availability.toJson(),
      'location': location.toJson(),
      'requirements': requirements,
      'deliverables': deliverables,
      'tags': tags,
    };
  }
}

class ServiceAvailability {
  final List<ServiceSchedule> schedule;
  final String timezone;
  final int bookingAdvance;
  final int maxBookingsPerDay;

  ServiceAvailability({
    required this.schedule,
    required this.timezone,
    required this.bookingAdvance,
    required this.maxBookingsPerDay,
  });

  factory ServiceAvailability.fromJson(Map<String, dynamic> json) {
    return ServiceAvailability(
      schedule: (json['schedule'] as List<dynamic>?)
              ?.map((item) => ServiceSchedule.fromJson(item))
              .toList() ??
          [],
      timezone: json['timezone'] ?? '',
      bookingAdvance: json['bookingAdvance'] ?? 0,
      maxBookingsPerDay: json['maxBookingsPerDay'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schedule': schedule.map((item) => item.toJson()).toList(),
      'timezone': timezone,
      'bookingAdvance': bookingAdvance,
      'maxBookingsPerDay': maxBookingsPerDay,
    };
  }
}

class ServiceSchedule {
  final String day;
  final List<TimeSlot> timeSlots;

  ServiceSchedule({
    required this.day,
    required this.timeSlots,
  });

  factory ServiceSchedule.fromJson(Map<String, dynamic> json) {
    return ServiceSchedule(
      day: json['day'] ?? '',
      timeSlots: (json['timeSlots'] as List<dynamic>?)
              ?.map((item) => TimeSlot.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'timeSlots': timeSlots.map((item) => item.toJson()).toList(),
    };
  }
}

class TimeSlot {
  final String startTime;
  final String endTime;

  TimeSlot({
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}

class ServiceLocation {
  final String type; //* "online", "in_person", "hybrid"
  final String address;
  final String city;
  final String state;
  final String country;
  final LocationCoordinates coordinates;

  ServiceLocation({
    required this.type,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.coordinates,
  });

  factory ServiceLocation.fromJson(Map<String, dynamic> json) {
    return ServiceLocation(
      type: json['type'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      coordinates: LocationCoordinates.fromJson(json['coordinates'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'coordinates': coordinates.toJson(),
    };
  }
}

class LocationCoordinates {
  final double latitude;
  final double longitude;

  LocationCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) {
    return LocationCoordinates(
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

// Business Customization
class BusinessCustomization {
  final String businessName;
  final String businessType;
  final String description;
  final String category;
  final String subcategory;
  final BusinessContact contact;
  final BusinessLocation location;
  final List<BusinessHours> hours;
  final List<String> features;
  final String priceRange;
  final double rating;
  final List<String> tags;
  final String announcement;
  final List<BusinessPromotion> promotions;

  BusinessCustomization({
    required this.businessName,
    required this.businessType,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.contact,
    required this.location,
    this.hours = const [],
    this.features = const [],
    required this.priceRange,
    this.rating = 0.0,
    this.tags = const [],
    required this.announcement,
    this.promotions = const [],
  });

  factory BusinessCustomization.fromJson(Map<String, dynamic> json) {
    return BusinessCustomization(
      businessName: json['businessName'] ?? '',
      businessType: json['businessType'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      subcategory: json['subcategory'] ?? '',
      contact: BusinessContact.fromJson(json['contact'] ?? {}),
      location: BusinessLocation.fromJson(json['location'] ?? {}),
      hours: (json['hours'] as List<dynamic>?)
              ?.map((item) => BusinessHours.fromJson(item))
              .toList() ??
          [],
      features: List<String>.from(json['features'] ?? []),
      priceRange: json['priceRange'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      tags: List<String>.from(json['tags'] ?? []),
      announcement: json['announcement'] ?? '',
      promotions: (json['promotions'] as List<dynamic>?)
              ?.map((item) => BusinessPromotion.fromJson(item))
              .toList() ??
          [],
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
      'hours': hours.map((item) => item.toJson()).toList(),
      'features': features,
      'priceRange': priceRange,
      'rating': rating,
      'tags': tags,
      'announcement': announcement,
      'promotions': promotions.map((item) => item.toJson()).toList(),
    };
  }
}

class BusinessContact {
  final String phone;
  final String email;
  final String website;
  final List<SocialMediaLink> socialMedia;

  BusinessContact({
    required this.phone,
    required this.email,
    required this.website,
    this.socialMedia = const [],
  });

  factory BusinessContact.fromJson(Map<String, dynamic> json) {
    return BusinessContact(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      socialMedia: (json['socialMedia'] as List<dynamic>?)
              ?.map((item) => SocialMediaLink.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'email': email,
      'website': website,
      'socialMedia': socialMedia.map((item) => item.toJson()).toList(),
    };
  }
}

class SocialMediaLink {
  final String platform;
  final String url;

  SocialMediaLink({
    required this.platform,
    required this.url,
  });

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
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

class BusinessLocation {
  final String address;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final LocationCoordinates coordinates;

  BusinessLocation({
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    required this.coordinates,
  });

  factory BusinessLocation.fromJson(Map<String, dynamic> json) {
    return BusinessLocation(
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      postalCode: json['postalCode'] ?? '',
      coordinates: LocationCoordinates.fromJson(json['coordinates'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'coordinates': coordinates.toJson(),
    };
  }
}

class BusinessHours {
  final String day;
  final String openTime;
  final String closeTime;
  final bool isClosed;

  BusinessHours({
    required this.day,
    required this.openTime,
    required this.closeTime,
    this.isClosed = false,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) {
    return BusinessHours(
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

class BusinessPromotion {
  final String title;
  final String description;
  final double discount;
  final DateTime validUntil;
  final bool isActive;

  BusinessPromotion({
    required this.title,
    required this.description,
    required this.discount,
    required this.validUntil,
    this.isActive = true,
  });

  factory BusinessPromotion.fromJson(Map<String, dynamic> json) {
    return BusinessPromotion(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discount: (json['discount'] ?? 0).toDouble(),
      validUntil: DateTime.parse(
          json['validUntil'] ?? DateTime.now().toIso8601String()),
      isActive: json['isActive'] ?? true,
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

// Normal Post Customization
class NormalCustomization {
  final String mood;
  final String activity;
  final NormalPostLocation location;
  final List<String> tags;

  NormalCustomization({
    required this.mood,
    required this.activity,
    required this.location,
    this.tags = const [],
  });

  factory NormalCustomization.fromJson(Map<String, dynamic> json) {
    return NormalCustomization(
      mood: json['mood'] ?? '',
      activity: json['activity'] ?? '',
      location: NormalPostLocation.fromJson(json['location'] ?? {}),
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'activity': activity,
      'location': location.toJson(),
      'tags': tags,
    };
  }
}

class NormalPostLocation {
  final String name;
  final String address;
  final LocationCoordinates coordinates;

  NormalPostLocation({
    required this.name,
    required this.address,
    required this.coordinates,
  });

  factory NormalPostLocation.fromJson(Map<String, dynamic> json) {
    return NormalPostLocation(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      coordinates: LocationCoordinates.fromJson(json['coordinates'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'coordinates': coordinates.toJson(),
    };
  }
}
