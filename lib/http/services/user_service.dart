import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/models/model_expert.dart';
import 'package:social_media_clone/http/models/model_user.dart';
import 'package:social_media_clone/http/services/api_service.dart';
import 'package:social_media_clone/http/utils/api_endpoints.dart';
import 'package:social_media_clone/http/utils/http_client.dart';

class UserService extends ApiService {
  final HttpClient _httpClient = HttpClient();

  //* Get user stats/details by user ID
  Future<ApiResponse<UserModel>> getUserStats() async {
    final userId = await _httpClient.getUserData();

    final response = await get<UserModel>(
      ApiEndpoints.getUserById(userId!),
      fromJson: (data) => UserModel.fromJson(data as Map<String, dynamic>),
    );

    return response;
  }

  //* Get ALl Experts List
  Future<ApiResponse<List<ExpertModel>>> getAllExperts() async {
    final response = await get<List<ExpertModel>>(
      ApiEndpoints.getAllExperts,
      fromJson: (data) {
        if (data is List) {
          return data
              .map((item) => ExpertModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
        throw Exception('Invalid experts data format');
      },
    );

    return response;
  }
}
