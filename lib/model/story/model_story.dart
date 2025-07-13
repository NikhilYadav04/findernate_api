import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String id;
  final String userId;
  final String imageUrl;
  final DateTime createdAt;

  Story({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.createdAt,
  });

  factory Story.fromMap(Map<String, dynamic> data, String id) {
    return Story(
      id: id,
      userId: data['userId'] as String,
      imageUrl: data['imageUrl'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'imageUrl': imageUrl,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
