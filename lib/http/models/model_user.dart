class UserModel {
  final String uid;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String bio;
  final String profileImageUrl;
  final String location; // Added
  final List<String> followers;
  final List<String> following;
  final List<String> posts;
  final bool isBusinessProfile;
  final bool isEmailVerified;
  final bool isPhoneVerified;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.bio,
    required this.profileImageUrl,
    required this.location, // Added
    required this.followers,
    required this.following,
    required this.posts,
    required this.isBusinessProfile,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
      bio: json['bio'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      location: json['location'] ?? '', // Added
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      posts: List<String>.from(json['posts'] ?? []),
      isBusinessProfile: json['isBusinessProfile'] ?? false,
      isEmailVerified: json['isEmailVerified'] ?? false,
      isPhoneVerified: json['isPhoneVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': uid,
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'location': location, // Added
      'followers': followers,
      'following': following,
      'posts': posts,
      'isBusinessProfile': isBusinessProfile,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
    };
  }
}
