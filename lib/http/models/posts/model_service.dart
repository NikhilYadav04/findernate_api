// service_customization_model.dart

class ServiceCustomizationModel {
  final String name;
  final String description;
  final int price;
  final String currency;
  final String category;
  final String? subcategory;
  final int duration;
  final String serviceType;
  final AvailabilityModel availability;
  final ServiceLocationModel location;
  final List<String> requirements;
  final List<String> deliverables;
  final List<String> tags;
  final String? link;

  ServiceCustomizationModel({
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.category,
    this.subcategory,
    required this.duration,
    required this.serviceType,
    required this.availability,
    required this.location,
    required this.requirements,
    required this.deliverables,
    required this.tags,
    this.link,
  });

  factory ServiceCustomizationModel.fromJson(Map<String, dynamic> json) {
    return ServiceCustomizationModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      currency: json['currency'] ?? '',
      category: json['category'] ?? '',
      subcategory: json['subcategory'],
      duration: json['duration'] ?? 0,
      serviceType: json['serviceType'] ?? '',
      availability: AvailabilityModel.fromJson(json['availability'] ?? {}),
      location: ServiceLocationModel.fromJson(json['location'] ?? {}),
      requirements: List<String>.from(json['requirements'] ?? []),
      deliverables: List<String>.from(json['deliverables'] ?? []),
      tags: List<String>.from(json['tags'] ?? []),
      link: json['link'],
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
      'link': link,
    };
  }
}

class AvailabilityModel {
  final List<ScheduleModel> schedule;
  final String timezone;
  final int bookingAdvance;
  final int maxBookingsPerDay;

  AvailabilityModel({
    required this.schedule,
    required this.timezone,
    required this.bookingAdvance,
    required this.maxBookingsPerDay,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) {
    return AvailabilityModel(
      schedule: (json['schedule'] as List? ?? [])
          .map((item) => ScheduleModel.fromJson(item))
          .toList(),
      timezone: json['timezone'] ?? '',
      bookingAdvance: json['bookingAdvance'] ?? 0,
      maxBookingsPerDay: json['maxBookingsPerDay'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schedule': schedule.map((s) => s.toJson()).toList(),
      'timezone': timezone,
      'bookingAdvance': bookingAdvance,
      'maxBookingsPerDay': maxBookingsPerDay,
    };
  }
}

class ScheduleModel {
  final String day;
  final List<TimeSlotModel> timeSlots;

  ScheduleModel({
    required this.day,
    required this.timeSlots,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      day: json['day'] ?? '',
      timeSlots: (json['timeSlots'] as List? ?? [])
          .map((item) => TimeSlotModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'timeSlots': timeSlots.map((t) => t.toJson()).toList(),
    };
  }
}

class TimeSlotModel {
  final String startTime;
  final String endTime;

  TimeSlotModel({
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlotModel.fromJson(Map<String, dynamic> json) {
    return TimeSlotModel(
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

class ServiceLocationModel {
  final String type;
  final String address;
  final String city;
  final String state;
  final String country;
  final CoordinatesModel? coordinates;

  ServiceLocationModel({
    required this.type,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    this.coordinates,
  });

  factory ServiceLocationModel.fromJson(Map<String, dynamic> json) {
    return ServiceLocationModel(
      type: json['type'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      coordinates: json['coordinates'] != null 
          ? CoordinatesModel.fromJson(json['coordinates'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
      'coordinates': coordinates?.toJson(),
    };
  }
}

class CoordinatesModel {
  final String type;
  final List<double> coordinates;

  CoordinatesModel({
    required this.type,
    required this.coordinates,
  });

  factory CoordinatesModel.fromJson(Map<String, dynamic> json) {
    return CoordinatesModel(
      type: json['type'] ?? '',
      coordinates: List<double>.from(json['coordinates'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}