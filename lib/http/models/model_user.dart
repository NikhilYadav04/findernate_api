class UserModel {
  final String uid;
  final String username;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
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
    required this.followers,
    required this.following,
    required this.posts,
    required this.isBusinessProfile,
    required this.isEmailVerified,
    required this.isPhoneVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      fullName: json['fullName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      gender: json['gender'] ?? '',
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
      'uid': uid,
      'username': username,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'followers': followers,
      'following': following,
      'posts': posts,
      'isBusinessProfile': isBusinessProfile,
      'isEmailVerified': isEmailVerified,
      'isPhoneVerified': isPhoneVerified,
    };
  }
}
