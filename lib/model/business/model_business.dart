class BusinessModel {
  final String businessName;
  final String businessDescription;
  final String operatingHoursMonday;
  final String operatingHoursFriday;
  final String businessAddress1;
  final String businessAddress2;
  final String street;
  final String country;
  final String city;
  final String zipCode;
  final String phoneNumber;
  final String businessLogo;
  final String businessOwnerId; // ✅ NEW FIELD

  BusinessModel({
    required this.businessName,
    required this.businessDescription,
    required this.operatingHoursMonday,
    required this.operatingHoursFriday,
    required this.businessAddress1,
    required this.businessAddress2,
    required this.street,
    required this.country,
    required this.city,
    required this.zipCode,
    required this.phoneNumber,
    required this.businessLogo,
    required this.businessOwnerId, // ✅ NEW
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
        businessName: json['businessName'] ?? '',
        businessDescription: json['businessDescription'] ?? '',
        operatingHoursMonday: json['operatingHoursMonday'] ?? '',
        operatingHoursFriday: json['operatingHoursFriday'] ?? '',
        businessAddress1: json['businessAddress1'] ?? '',
        businessAddress2: json['businessAddress2'] ?? '',
        street: json['street'] ?? '',
        country: json['country'] ?? '',
        city: json['city'] ?? '',
        zipCode: json['zipCode'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        businessLogo: json['businessLogo'] ?? '',
        businessOwnerId: json['businessOwnerId'] ?? '', // ✅ NEW
      );

  Map<String, dynamic> toJson() => {
        'businessName': businessName,
        'businessDescription': businessDescription,
        'operatingHoursMonday': operatingHoursMonday,
        'operatingHoursFriday': operatingHoursFriday,
        'businessAddress1': businessAddress1,
        'businessAddress2': businessAddress2,
        'street': street,
        'country': country,
        'city': city,
        'zipCode': zipCode,
        'phoneNumber': phoneNumber,
        'businessLogo': businessLogo,
        'businessOwnerId': businessOwnerId, // ✅ NEW
      };
}
