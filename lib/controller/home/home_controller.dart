import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';
import 'package:social_media_clone/http/services/post_services.dart';

class HomeProvider extends ChangeNotifier {
  int _page = 1;
  final int _limit = 2;

  List<PostModel> _posts = [];
  bool _isLoading = false;
  bool _hasMore = true;
  bool _isInitializing = false;

  //* Getters
  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  bool get isInitializing => _isInitializing;

  final PostService _postservice = PostService();

  //* Initialize posts - runs only once with shimmer
  Future<void> initializePosts() async {
    if (_posts.isNotEmpty) return;

    _isInitializing = true;
    notifyListeners();

    await fetchPosts();

    _isInitializing = false;
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    if (_isLoading || !_hasMore) return;

    if (_posts.isEmpty) {
      _isInitializing = true;
    }

    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse<Map<String, dynamic>> response =
          await _postservice.getHomeFeed(page: _page, limit: _limit);

      final data = response.data!;

      final rawFeed = data['feed'] as List<dynamic>?;
      final newPosts = rawFeed != null
          ? rawFeed.map((json) => PostModel.fromJson(json)).toList()
          : <PostModel>[];

      if (newPosts.isEmpty) {
        _hasMore = false;
        Logger().d("Empty response - no more data");
      } else {
        _posts.addAll(newPosts);
        _page++;
        Logger().d(_posts);
        Logger().d("Updated page to: $_page");
        Logger().d("Total posts now: ${_posts.length}");

        if (newPosts.length < _limit) {
          _hasMore = false;
          Logger().d("Fetched less than limit - hasMore set to false");
        }
      }
    } catch (e) {
      Logger().e('Error fetching posts: $e');
    } finally {
      _isLoading = false;
      _isInitializing = false;
      notifyListeners();
    }
  }

  Future<void> refreshPosts() async {
    _isInitializing = true;
    _isLoading = true;
    _posts.clear();
    _page = 1;
    _hasMore = true;
    notifyListeners();

    try {
      ApiResponse<Map<String, dynamic>> response =
          await _postservice.getHomeFeed(page: _page, limit: _limit);

      final data = response.data!;
      final rawFeed = data['feed'] as List<dynamic>?;
      final newPosts = rawFeed != null
          ? rawFeed
              .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
              .toList()
          : <PostModel>[];

      _posts = newPosts;
      if (newPosts.isNotEmpty) _page++;
      _hasMore = newPosts.length >= _limit;

      Logger().d("Refreshed with ${newPosts.length} posts");
      Logger().d("Page set to: $_page");
      Logger().d("Has more data: $_hasMore");
    } catch (e) {
      Logger().e('Error refreshing posts: $e');
    } finally {
      _isInitializing = false;
      _isLoading = false;
      notifyListeners();
    }
  }
}
