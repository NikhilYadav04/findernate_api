import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/services/user_service.dart';
import 'package:social_media_clone/view/content/screens/post/display/mock_data.dart';

class HomeProvider extends ChangeNotifier {
  int _page = 1;
  final int _limit = 10;

  List<PostModel> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;

  //* Getters
  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  final UserService _userService = UserService();

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse<List<Map<String, dynamic>>> response =
          await _userService.getPosts(page: _page, limit: _limit);
      if (response.data == null) {
        return;
      } else {
        final newPosts =
            response.data!.map((json) => PostModel.fromJson(json)).toList();

        Logger().d(posts.length);

        if (newPosts.isEmpty) {
          _hasMore = false;
        } else {
          _posts.addAll(newPosts);
          _page++;
        }
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshPosts() async {
    _isLoading = true;
    _posts.clear();
    _page = 1;
    _hasMore = true;
    notifyListeners();

    try {
      ApiResponse<List<Map<String, dynamic>>> response =
          await _userService.getPosts(page: _page, limit: _limit);
      if (response.data == null) {
        return;
      } else {
        final newPosts =
            response.data!.map((json) => PostModel.fromJson(json)).toList();
        _posts = newPosts;
        if (newPosts.isNotEmpty) {
          _page++;
        }
      }
    } catch (e) {
      print('Error refreshing posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //* Post card Data
  int _pageCard = 1;
  final int _limitCard = 2;

  List<Map<String, dynamic>> _postsCard = [];
  bool _isLoadingCard = false;
  bool _hasMoreCard = true;

//* Getters
  List<Map<String, dynamic>> get postsCard => _postsCard;
  bool get isLoadingCard => _isLoadingCard;
  bool get hasMoreCard => _hasMoreCard;

  Future<void> fetchPostsData() async {
    // Prevent multiple simultaneous calls
    if (_isLoadingCard || !_hasMoreCard) return;

    _isLoadingCard = true;
    notifyListeners();

    try {
      // Simulate API delay
      await Future.delayed(Duration(milliseconds: 800));

      // Get all mock posts
      final allMockPosts = MockData.all8Posts;

      // Calculate pagination
      final startIndex = (_pageCard - 1) * _limitCard;
      final endIndex = startIndex + _limitCard;

      Logger().d(
          "Fetching posts - Page: $_pageCard, Start: $startIndex, End: $endIndex");

      // Get posts for current page
      List<Map<String, dynamic>> currentPagePosts = [];

      if (startIndex < allMockPosts.length) {
        final actualEndIndex =
            endIndex > allMockPosts.length ? allMockPosts.length : endIndex;
        currentPagePosts = allMockPosts.sublist(startIndex, actualEndIndex);
      }

      // Simulate API response structure
      final response = {
        "data": currentPagePosts.map((post) => {"data": post['data']}).toList(),
        "success": true,
        "statusCode": 200
      };

      if (response["data"] == null || (response["data"] as List).isEmpty) {
        _hasMoreCard = false;
        Logger().d("No more data available");
        return;
      } else {
        final newPostsData = (response["data"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();

        Logger().d("Current posts count: ${_postsCard.length}");
        Logger().d("New posts fetched: ${newPostsData.length}");

        if (newPostsData.isEmpty) {
          _hasMoreCard = false;
          notifyListeners();
          Logger().d("Empty response - no more data");
        } else {
          _postsCard.addAll(newPostsData);
          _pageCard++;
          Logger().d("Updated page to: $_pageCard");
          Logger().d("Total posts now: ${_postsCard.length}");

          // Check if we've reached the end of mock data
          if (_postsCard.length >= allMockPosts.length) {
            _hasMoreCard = false;
            notifyListeners();
            Logger().d("Reached end of all mock data - hasMore set to false");
          }
        }
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      _isLoadingCard = false;
      notifyListeners();
    }
  }

  Future<void> refreshPostsData() async {
    _isLoadingCard = true;
    _postsCard.clear();
    _pageCard = 1;
    _hasMoreCard = true;
    notifyListeners();

    try {
      // Simulate API delay
      await Future.delayed(Duration(milliseconds: 500));

      // Get first page of mock data (first 2 posts)
      final allMockPosts = MockData.all8Posts;
      final firstPagePosts = allMockPosts.take(_limitCard).toList();

      final response = {
        "data": firstPagePosts.map((post) => {"data": post['data']}).toList(),
        "success": true,
        "statusCode": 200
      };

      if (response["data"] != null && (response["data"] as List).isNotEmpty) {
        final newPostsData = (response["data"] as List)
            .map((item) => item as Map<String, dynamic>)
            .toList();

        _postsCard = newPostsData;
        _pageCard = 2; // Set to 2 because we loaded page 1

        // Check if there's more data after the first page
        _hasMoreCard = allMockPosts.length > _limitCard;

        Logger().d("Refreshed with ${newPostsData.length} posts");
        Logger().d("Page set to: $_pageCard");
        Logger().d("Has more data: $_hasMoreCard");
      }
    } catch (e) {
      print('Error refreshing posts: $e');
    } finally {
      _isLoadingCard = false;
      notifyListeners();
    }
  }
}

class PostModel {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userId: json['userId'] ?? 0,
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  @override
  String toString() {
    return 'PostModel(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostModel &&
        other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
  }

  // Copy with method for creating modified copies
  PostModel copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return PostModel(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
