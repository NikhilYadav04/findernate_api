class UserSummary {
  final String uid;
  final String username;
  final String fullName;
  final String profileImageUrl;

  UserSummary({
    required this.uid,
    required this.username,
    required this.fullName,
    required this.profileImageUrl,
  });

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
      uid: json['uid'] as String,
      username: json['username'] as String,
      fullName: json['full_name'] as String,
      profileImageUrl: json['profile_image_url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'full_name': fullName,
      'profile_image_url': profileImageUrl,
    };
  }
}
