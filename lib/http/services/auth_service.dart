import 'package:social_media_clone/http/models/api_reponse.dart';
import '../utils/api_endpoints.dart';
import '../utils/http_client.dart';
import 'api_service.dart';

//* AuthService handles authentication API calls
class AuthService extends ApiService {
  final HttpClient _httpClient = HttpClient();

  //* Login with username/email and password
  Future<ApiResponse<Map<String, dynamic>>> login({
    required String usernameOrEmail,
    required String password,
  }) async {
    //* Check if input is email or username
    bool isEmail = usernameOrEmail.contains('@');

    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: isEmail
          ? {
              'email': usernameOrEmail,
              'username': '',
              'password': password,
            }
          : {
              'username': usernameOrEmail,
              'email': '',
              'password': password,
            },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    //* Save token and user ID if login successful
    if (response.success && response.data != null) {
      final token = response.data!['accessToken'];
      final userData = response.data!['user'];

      if (token != null && userData != null) {
        final userId = userData['uid'];
        if (token != null && userId != null) {
          await _httpClient.saveAuthToken(token);
          await _httpClient.saveTokens(token, token);
          await _httpClient.saveUserData(userId);
        } else {
          await _httpClient.saveAuthToken(token);
          await _httpClient.saveTokens(token, token);
        }
      }
    }

    return response;
  }

  //* Register new user account
  Future<ApiResponse<Map<String, dynamic>>> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String dateOfBirth,
    required String gender,
    String? bio,
    String? link,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.register,
      data: {
        'fullName': fullName,
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
        'phoneNumber': phoneNumber,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        if (bio != null) 'bio': bio,
        if (link != null) 'link': link,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Logout user and clear tokens
  Future<ApiResponse<Map<String, dynamic>>> logout() async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.logout,
      fromJson: (data) => data as Map<String, dynamic>,
    );

    //* Clear local tokens regardless of server response
    await _httpClient.logout();

    return response;
  }

  //* Verify email with OTP
  Future<ApiResponse<Map<String, dynamic>>> verifyUserRegister({
    required String email,
    required String otp,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.verifyUserRegister,
      data: {
        'email': email,
        'otp': otp,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    //* Save token and user ID if login successful
    if (response.success && response.data != null) {
      final token = response.data!['accessToken'];
      final refreshToken = response.data!['refreshToken'];
      final userData = response.data!['user'];

      if (token != null && userData != null) {
        final userId = userData['uid'];
        if (token != null && userId != null) {
          await _httpClient.saveAuthToken(token);
          await _httpClient.saveTokens(token, refreshToken);
          await _httpClient.saveUserData(userId);
        } else {
          await _httpClient.saveAuthToken(token);
          await _httpClient.saveTokens(token, refreshToken);
        }
      }
    }

    return response;
  }

  //* Send verification OTP to email
  Future<ApiResponse<Map<String, dynamic>>> sendVerificationOtp({
    required String email,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.sendVerificationOtp,
      data: {
        'email': email,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Verify email with OTP
  Future<ApiResponse<Map<String, dynamic>>> verifyEmailOtp({
    required String email,
    required String otp,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.verifyEmailOtp,
      data: {
        'email': email,
        'otp': otp,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Change password
  Future<ApiResponse<Map<String, dynamic>>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await put<Map<String, dynamic>>(
      ApiEndpoints.changePassword,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    return response;
  }

  //* Delete Account
  Future<ApiResponse<Map<String, dynamic>>> deleteAccount(
      {required String password}) async {
    final response = await delete<Map<String, dynamic>>(
      ApiEndpoints.deleteAccount,
      data: {"password": password},
      fromJson: (data) => data as Map<String, dynamic>,
    );

    //* Clear local tokens regardless of server response
    await _httpClient.logout();

    return response;
  }


}
