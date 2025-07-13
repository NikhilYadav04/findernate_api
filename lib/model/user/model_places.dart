class AutocompletePrediction {
  final String description;
  final String placeId;

  AutocompletePrediction({
    required this.description,
    required this.placeId,
  });

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
    );
  }
}