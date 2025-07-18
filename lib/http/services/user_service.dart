import 'package:dio/dio.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/services/api_service.dart';
import 'package:social_media_clone/http/utils/api_endpoints.dart';

class UserService extends ApiService {
  //* Get user stats/details by user ID
  Future<ApiResponse<Map<String, dynamic>>> getUserStats() async {
    final response = await get<Map<String, dynamic>>(
      ApiEndpoints.getUserStats,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Get dummy data for testing
  Future<ApiResponse<List<Map<String, dynamic>>>> getPosts(
      {int page = 1, int limit = 10}) async {
    final response = await get<List<Map<String, dynamic>>>(
        'https://jsonplaceholder.typicode.com/posts?_page=$page&_limit=$limit',
        fromJson: (data) => List<Map<String, dynamic>>.from(data),
        isDirectJson: true);

    return response;
  }

  //* Upload Profile Photo
  Future<ApiResponse<Map<String, dynamic>>> uploadProfilePhoto({
    required String imagePath,
  }) async {
    final formData = FormData.fromMap({
      'profileImage': await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      ),
    });

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.uploadProfilePhoto,
      data: formData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Edit User Profile
  Future<ApiResponse<Map<String, dynamic>>> editUserProfile({
    required Map<String, dynamic> profileData,
  }) async {
    final response = await put<Map<String, dynamic>>(
      ApiEndpoints.editUserProfile,
      data: profileData,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }
}
