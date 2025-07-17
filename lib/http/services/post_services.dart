import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/services/api_service.dart';
import 'package:social_media_clone/http/utils/api_endpoints.dart';

class PostService extends ApiService {
  //* Create Normal Post

  //* Create Normal Post
  Future<ApiResponse<Map<String, dynamic>>> createNormalPost({
    required File media,
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
    final formData = FormData.fromMap({
      'media': await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      ),
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

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createPost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Create Business Post
  Future<ApiResponse<Map<String, dynamic>>> createBusinessPost({
    required File media,
    required String postType,
    required String caption,
    required String description,
    required List<String> mentions,
    required Map<String, dynamic> business,
    required Map<String, dynamic> settings,
    required String status,
  }) async {
    final formData = FormData.fromMap({
      'media': await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      ),
      'postType': postType,
      'caption': caption,
      'description': description,
      'mentions': jsonEncode(mentions),
      'business': jsonEncode(business),
      'settings': jsonEncode(settings),
      'status': status,
    });

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createBusinessPost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Create Service Post
  Future<ApiResponse<Map<String, dynamic>>> createServicePost({
    required File media,
    required String postType,
    required String caption,
    required String description,
    required List<String> mentions,
    required Map<String, dynamic> settings,
    required Map<String, String> location,
    required String status,
    required Map<String, dynamic> service,
  }) async {
    final formData = FormData.fromMap({
      'media': await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      ),
      'postType': postType,
      'caption': caption,
      'description': description,
      'mentions': jsonEncode(mentions),
      'settings': jsonEncode(settings),
      'location': jsonEncode(location),
      'status': status,
      'service': jsonEncode(service),
    });

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createServicePost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Create Product Post
  Future<ApiResponse<Map<String, dynamic>>> createProductPost({
    required File media,
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
    final formData = FormData.fromMap({
      'media': await MultipartFile.fromFile(
        media.path,
        filename: media.path.split('/').last,
      ),
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

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.createProductPost,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Get all home post feed
  Future<ApiResponse<Map<String, dynamic>>> getHomeFeed() async {
    final response = await get<Map<String, dynamic>>(
      ApiEndpoints.getUserStats,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }
}
