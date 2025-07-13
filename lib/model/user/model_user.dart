// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:social_media_clone/model/user/posts/model_post_saved.dart';

class UserModel {
  final String uid;
  final String username;
  final String email;
  final String fullName;
  final String fullNameLower;
  final String phoneNumber;
  final String dateOfBirth;
  final String gender;
  final String bio;
  final String profileImageUrl;
  final List<String> followers;
  final List<String> following;
  final List<String> posts;
  final List<String> unReadChats;
  final List<SavedPostModel> postsSaved;
  final DateTime createdAt;
  final bool isBusinessProfile;
  final bool isBusinessDetails;

  //* Online status tracking
  final bool isOnline;
  final DateTime lastSeen;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.fullName,
    required this.fullNameLower,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.gender,
    required this.bio,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
    required this.posts,
    required this.unReadChats,
    required this.postsSaved,
    required this.createdAt,
    required this.isBusinessProfile,
    required this.isBusinessDetails,
    required this.isOnline,
    required this.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String,
      fullNameLower: json['full_name_lower'] as String,
      phoneNumber: json['phone_number'] as String,
      dateOfBirth: json['date_of_birth'] as String,
      gender: json['gender'] as String,
      bio: json['bio'] as String,
      profileImageUrl: json['profile_image_url'] as String,
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      posts: List<String>.from(json['posts'] ?? []),
      postsSaved: (json['posts_saved'] as List<dynamic>? ?? [])
          .map((e) => SavedPostModel.fromJson(
                e['postId'] as String,
                e as Map<String, dynamic>,
              ))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),

      //* new fields
      isOnline: json['is_online'] ?? false,
      lastSeen: DateTime.parse(json['last_seen'] as String),
      unReadChats: List<String>.from(json['unread'] ?? []),
      isBusinessProfile: json['isBusinessProfile'] ?? false,
      isBusinessDetails: json['isBusinessDetails'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'full_name': fullName,
      'full_name_lower': fullNameLower,
      'phone_number': phoneNumber,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'bio': bio,
      'profile_image_url': profileImageUrl,
      'followers': followers,
      'following': following,
      'posts': posts,
      'posts_saved': postsSaved.map((e) => e.toJson()).toList(),
      'created_at': createdAt.toIso8601String(),

      //* new fields
      'is_online': isOnline,
      'last_seen': lastSeen.toIso8601String(),
      'unread': unReadChats,
      'isBusinessProfile': isBusinessProfile,
      'isBusinessDetails': isBusinessDetails
    };
  }
}
