import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/services/api_service.dart';
import 'package:social_media_clone/http/utils/api_endpoints.dart';

class PostService extends ApiService {
  //* Create Normal Post
  Future<ApiResponse<Map<String, dynamic>>> createNormalPost({
    required dynamic media,
    required String postType,
    required String caption,
    required String description,
    required String mood,
    required String activity,
    required Map<String, String> location,
    required List<String> tags,
    required List<String> mentions,
    required Map<String, dynamic> settings,
    required String status,
  }) async {
    Map<String, dynamic> formDataMap = {};

    if (media is List<File>) {
      for (int i = 0; i < media.length; i++) {
        String fieldName = postType == 'photo' ? 'image[$i]' : 'video[$i]';
        formDataMap[fieldName] = await MultipartFile.fromFile(
          media[i].path,
          filename: media[i].path.split('/').last,
        );
      }
    } else if (media is File) {
      String fieldName = postType == 'photo' ? 'image' : 'video';
      formDataMap[fieldName] = await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      );
    }

    //* Add other form fields
    formDataMap.addAll({
      'postType': postType,
      'caption': caption,
      'description': description,
      'mood': mood,
      'activity': activity,
      'location': jsonEncode(location),
      'tags': jsonEncode(tags),
      'mentions': jsonEncode(mentions),
      'settings': jsonEncode(settings),
      'status': status,
    });

    final formData = FormData.fromMap(formDataMap);

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createPost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Create Business Post
  Future<ApiResponse<Map<String, dynamic>>> createBusinessPost({
    required dynamic media,
    required String postType,
    required String caption,
    required String description,
    required List<String> mentions,
    required Map<String, dynamic> business,
    required Map<String, dynamic> settings,
    required String status,
  }) async {
    Map<String, dynamic> formDataMap = {};

    if (media is List<File>) {
      for (int i = 0; i < media.length; i++) {
        String fieldName = postType == 'photo' ? 'image[$i]' : 'video[$i]';
        formDataMap[fieldName] = await MultipartFile.fromFile(
          media[i].path,
          filename: media[i].path.split('/').last,
        );
      }
    } else if (media is File) {
      String fieldName = postType == 'photo' ? 'image' : 'video';
      formDataMap[fieldName] = await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      );
    }

    formDataMap.addAll({
      'postType': postType,
      'caption': caption,
      'description': description,
      'mentions': jsonEncode(mentions),
      'business': jsonEncode(business),
      'settings': jsonEncode(settings),
      'status': status,
    });

    final formData = FormData.fromMap(formDataMap);

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createBusinessPost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Create Service Post
  Future<ApiResponse<Map<String, dynamic>>> createServicePost({
    required dynamic media,
    required String postType,
    required String caption,
    required String description,
    required List<String> mentions,
    required Map<String, dynamic> settings,
    required Map<String, String> location,
    required String status,
    required Map<String, dynamic> service,
  }) async {
    Map<String, dynamic> formDataMap = {};

    if (media is List<File>) {
      for (int i = 0; i < media.length; i++) {
        String fieldName = postType == 'photo' ? 'image[$i]' : 'video[$i]';
        formDataMap[fieldName] = await MultipartFile.fromFile(
          media[i].path,
          filename: media[i].path.split('/').last,
        );
      }
    } else if (media is File) {
      String fieldName = postType == 'photo' ? 'image' : 'video';
      formDataMap[fieldName] = await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      );
    }

    formDataMap.addAll({
      'postType': postType,
      'caption': caption,
      'description': description,
      'mentions': jsonEncode(mentions),
      'settings': jsonEncode(settings),
      'location': jsonEncode(location),
      'status': status,
      'service': jsonEncode(service),
    });

    final formData = FormData.fromMap(formDataMap);

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createServicePost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Create Product Post
  Future<ApiResponse<Map<String, dynamic>>> createProductPost({
    required dynamic media,
    required String postType,
    required String caption,
    required String description,
    required List<String> mentions,
    required String mood,
    required String activity,
    required List<String> tags,
    required Map<String, dynamic> settings,
    required Map<String, String> location,
    required Map<String, dynamic> product,
    required String status,
  }) async {
    Map<String, dynamic> formDataMap = {};

    if (media is List<File>) {
      for (int i = 0; i < media.length; i++) {
        String fieldName = postType == 'photo' ? 'image[$i]' : 'video[$i]';
        formDataMap[fieldName] = await MultipartFile.fromFile(
          media[i].path,
          filename: media[i].path.split('/').last,
        );
      }
    } else if (media is File) {
      String fieldName = postType == 'photo' ? 'image' : 'video';
      formDataMap[fieldName] = await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      );
    }

    formDataMap.addAll({
      'postType': postType,
      'caption': caption,
      'description': description,
      'mentions': jsonEncode(mentions),
      'mood': mood,
      'activity': activity,
      'tags': jsonEncode(tags),
      'settings': jsonEncode(settings),
      'location': jsonEncode(location),
      'product': jsonEncode(product),
      'status': status,
    });

    final formData = FormData.fromMap(formDataMap);

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createProductPost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Get home post feed with pagination
  Future<ApiResponse<Map<String, dynamic>>> getHomeFeed({
    int page = 1,
    int limit = 10,
  }) async {
    final response = await get<Map<String, dynamic>>(
      '${ApiEndpoints.HomeFeedPosts}?page=$page&limit=$limit',
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Get Current User Posts with pagination
  Future<ApiResponse<Map<String, dynamic>>> getCurrentUserPosts({
    String postType = "photo",
    int page = 1,
    int limit = 10,
  }) async {
    final response = await get<Map<String, dynamic>>(
      '${ApiEndpoints.CurrentUserPosts}??postType=$postType&page=$page&limit=$limit',
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }
}
