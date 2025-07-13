import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import '../utils/api_endpoints.dart';
import '../utils/http_client.dart';
import 'api_service.dart';

//* AuthService handles authentication API calls
class AuthService extends ApiService {
  final HttpClient _httpClient = HttpClient();

  //* Login with email and password
  Future<ApiResponse<Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    final response = await post<Map<String, dynamic>>(
      ApiEndpoints.login,
      data: {
        'email': email,
        'password': password,
      },
      fromJson: (data) => data as Map<String, dynamic>,
    );

    //* Save token and user ID if login successful
    if (response.success && response.data != null) {
      final token = response.data!['token'];
      final userData = response.data!['user'];

      if (token != null && userData != null) {
        final userId = userData['id'] ?? userData['_id'];
        if (token != null && userId != null) {
          //* Save both token and user ID
          await _httpClient.saveAuthToken(
            token,
          );

          await _httpClient.saveUserData(userId);
        } else {
          //* Fallback: save only token if no user ID
          await _httpClient.saveAuthToken(token);
        }
      }
    }

    return response;
  }

  //* Register new user account with file upload support
  Future<ApiResponse<Map<String, dynamic>>> register({
    required String fullName,
    required String email,
    required String password,
    String? phone,
    File? profilePicture,
  }) async {
    try {
      //* Use FormData for multipart request to support file upload
      FormData formData = FormData.fromMap({
        'fullName': fullName,
        'email': email,
        'password': password,
      });

      //* Add optional phone
      if (phone != null && phone.isNotEmpty) {
        formData.fields.add(MapEntry('phone', phone));
      }

      //* Add profile picture if provided
      if (profilePicture != null) {
        String fileName = profilePicture.path.split('/').last;
        formData.files.add(MapEntry(
          'profilePicture',
          await MultipartFile.fromFile(
            profilePicture.path,
            filename: fileName,
          ),
        ));
      }

      //* Make direct Dio request for FormData
      final response = await _httpClient.dio.post(
        ApiEndpoints.register,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      //* Handle response manually since we're using direct Dio call
      if (response.statusCode == 201) {
        final responseData = response.data;

        //* Save token and user ID if present
        final token = responseData['token'];
        final userData = responseData['user'];

        if (token != null && userData != null) {
          final userId = userData['id'] ?? userData['_id'];
          if (userId != null) {
            await _httpClient.saveAuthToken(token);
            await _httpClient.saveUserData(userId);
          }
        } else if (token != null) {
          await _httpClient.saveAuthToken(token);
        }

        return ApiResponse.success(
          responseData,
          message: responseData['message'] ?? 'User registered successfully',
        );
      } else {
        return ApiResponse.error('Registration failed');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400 && e.response?.data != null) {
        final errorMessage = e.response!.data['error'] ?? 'Registration failed';
        return ApiResponse.error(errorMessage, statusCode: 400);
      }
      return ApiResponse.error('Registration failed: ${e.message}');
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }

  //* Logout user and clear tokens
  Future<ApiResponse<void>> logout(BuildContext context) async {
    final response = await post<void>(ApiEndpoints.logout);

    //* Clear local tokens regardless of server response
    await _httpClient.logout();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/landing_screen',
      (route) => false,
      arguments: {
        'transition': TransitionType.topToBottom,
        'duration': 300,
      },
    );

    return response;
  }

  //* Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await _httpClient.isAuthenticated();
  }
}
