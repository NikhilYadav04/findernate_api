// normal_customization_model.dart

class NormalCustomizationModel {
  final String? mood;
  final String? activity;
  final LocationModel? location;
  final List<String> tags;

  NormalCustomizationModel({
    this.mood,
    this.activity,
    this.location,
    required this.tags,
  });

  factory NormalCustomizationModel.fromJson(Map<String, dynamic> json) {
    return NormalCustomizationModel(
      mood: json['mood'],
      activity: json['activity'],
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mood': mood,
      'activity': activity,
      'location': location?.toJson(),
      'tags': tags,
    };
  }
}

class LocationModel {
  final String name;
  final CoordinatesModel? coordinates;

  LocationModel({
    required this.name,
    this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] ?? '',
      coordinates: json['coordinates'] != null
          ? CoordinatesModel.fromJson(json['coordinates'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
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
