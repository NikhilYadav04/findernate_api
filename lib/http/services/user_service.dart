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

  //* Upload Profile Photo
  

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
