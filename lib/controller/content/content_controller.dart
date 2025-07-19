import 'package:flutter/foundation.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';
import 'package:social_media_clone/http/services/post_services.dart';

class ContentProvider extends ChangeNotifier {
  //* -----------------------------------------------------------------------------
  //* Current Users Posts
  //* -----------------------------------------------------------------------------
  final PostService _postService = PostService();

  List<PostModel> _photoPosts = [];
  List<PostModel> _videoPosts = [];
  List<PostModel> _reelPosts = [];

  bool _isLoadingPhoto = false;
  bool _isLoadingVideo = false;
  bool _isLoadingReel = false;

  bool _hasMorePhoto = false;
  bool _hasMoreVideo = false;
  bool _hasMoreReel = false;

  bool _initializePhoto = false;
  bool _initializeVideo = false;
  bool _initializeReel = false;

  bool get initializePhoto => _initializePhoto;
  bool get initializeVideo => _initializeVideo;
  bool get initializeReel => _initializeReel;

  bool get isLoadingPhoto => _isLoadingPhoto;
  bool get isLoadingVideo => _isLoadingVideo;
  bool get isLoadingReel => _isLoadingReel;

  List<PostModel> get photoPosts => _photoPosts;
  List<PostModel> get videoPosts => _videoPosts;
  List<PostModel> get reelPosts => _reelPosts;

  int _limit = 5;
  int get limit => _limit;

  int _pagePhoto = 1;
  int _pageVideo = 1;
  int _pageReel = 1;

  //* Fetch current user's photo posts with pagination
  void fetchCurrentUserPhotoPosts() async {
    if (_isLoadingPhoto || !_hasMorePhoto) return;

    if (_photoPosts.isEmpty) {
      _initializePhoto = true;
    }

    _isLoadingPhoto = true;
    notifyListeners();

    try {
      ApiResponse<Map<String, dynamic>> response =
          await _postService.getCurrentUserPosts(
              postType: "photo", page: _pagePhoto, limit: _limit);

      final data = response.data!;
      final rawPosts = data['posts'] as List<dynamic>?;

      final newPosts = rawPosts != null
          ? rawPosts.map((json) => PostModel.fromJson(json)).toList()
          : <PostModel>[];

      if (newPosts.isEmpty) {
        _hasMorePhoto = false;
      } else {
        _photoPosts.addAll(newPosts);
        _pagePhoto++;

        if (newPosts.length < _limit) {
          _hasMorePhoto = false;
        }
      }
    } catch (e) {
      // Handle error (logging, UI feedback, etc.)
    } finally {
      _isLoadingPhoto = false;
      _initializePhoto = false;
      notifyListeners();
    }
  }

  //* Fetch current user's video posts with pagination
  void fetchCurrentUserVideoPosts() async {
    if (_isLoadingVideo || !_hasMoreVideo) return;

    if (_videoPosts.isEmpty) {
      _initializeVideo = true;
    }

    _isLoadingVideo = true;
    notifyListeners();

    try {
      ApiResponse<Map<String, dynamic>> response =
          await _postService.getCurrentUserPosts(
              postType: "video", page: _pageVideo, limit: _limit);

      final data = response.data!;
      final rawPosts = data['posts'] as List<dynamic>?;

      final newPosts = rawPosts != null
          ? rawPosts.map((json) => PostModel.fromJson(json)).toList()
          : <PostModel>[];

      if (newPosts.isEmpty) {
        _hasMoreVideo = false;
      } else {
        _videoPosts.addAll(newPosts);
        _pageVideo++;

        if (newPosts.length < _limit) {
          _hasMoreVideo = false;
        }
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoadingVideo = false;
      _initializeVideo = false;
      notifyListeners();
    }
  }

  //* Fetch current user's reels with pagination
  void fetchCurrentUserReelPosts() async {
    if (_isLoadingReel || !_hasMoreReel) return;

    if (_reelPosts.isEmpty) {
      _initializeReel = true;
    }

    _isLoadingReel = true;
    notifyListeners();

    try {
      ApiResponse<Map<String, dynamic>> response =
          await _postService.getCurrentUserPosts(
              postType: "reel", page: _pageReel, limit: _limit);

      final data = response.data!;
      final rawPosts = data['posts'] as List<dynamic>?;

      final newPosts = rawPosts != null
          ? rawPosts.map((json) => PostModel.fromJson(json)).toList()
          : <PostModel>[];

      if (newPosts.isEmpty) {
        _hasMoreReel = false;
      } else {
        _reelPosts.addAll(newPosts);
        _pageReel++;

        if (newPosts.length < _limit) {
          _hasMoreReel = false;
        }
      }
    } catch (e) {
      // Handle error
    } finally {
      _isLoadingReel = false;
      _initializeReel = false;
      notifyListeners();
    }
  }
}
