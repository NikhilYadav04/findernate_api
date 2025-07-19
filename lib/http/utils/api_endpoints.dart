//* API endpoints matching your Node.js backend routes exactly
import 'package:social_media_clone/http/config/api_config.dart';

class ApiEndpoints {
  //* Authentication endpoints
  static String get login => '${ApiConfig.baseUrl}/api/v1/users/login';
  static String get register => '${ApiConfig.baseUrl}/api/v1/users/register';
  static String get logout => '${ApiConfig.baseUrl}/api/v1/users/logout';
  static String get verifyUserRegister =>
      '${ApiConfig.baseUrl}/api/v1/users/register/verify';
  static String get sendVerificationOtp =>
      '${ApiConfig.baseUrl}/api/v1/users/send-verification-otp';
  static String get verifyEmailOtp =>
      '${ApiConfig.baseUrl}/api/v1/users/verify-email-otp';
  static String get changePassword =>
      '${ApiConfig.baseUrl}/api/v1/users/profile/change-password';
  static String get refreshToken => '${ApiConfig.baseUrl}/auth/refresh';
  static String get deleteAccount =>
      '${ApiConfig.baseUrl}/api/v1/users/profile';

  //* User Endpoint
  static String get getUserStats => '${ApiConfig.baseUrl}/api/v1/users/profile';
  static String get editUserProfile =>
      '${ApiConfig.baseUrl}/api/v1/users/profile';
  static String get uploadProfilePhoto =>
      '${ApiConfig.baseUrl2}/api/v1/users/profile/upload-image';

  //* Post Creation Endpoints
  static String get createPost =>
      '${ApiConfig.baseUrl2}/api/v1/posts/create/normal';
  static String get createBusinessPost =>
      '${ApiConfig.baseUrl2}/api/v1/posts/create/business';
  static String get createServicePost =>
      '${ApiConfig.baseUrl2}/api/v1/posts/create/service';
  static String get createProductPost =>
      '${ApiConfig.baseUrl2}/api/v1/posts/create/product';

  //* Home Feed
  static String get HomeFeedPosts =>
      '${ApiConfig.baseUrl2}/api/v1/posts/home-feed';
  

  //* Profile
  static String get CurrentUserPosts =>
      '${ApiConfig.baseUrl2}/api/v1/posts/myPosts';
}
