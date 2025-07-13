

class ApiEndpoints {
  // static String? baseUrl;

  // //* Call this once after dotenv.load() in main()
  // static Future<void> initialize() async {
  //   baseUrl = await dotenv.env['BASE_URL'] ?? "https://social-media-clone-mqnv.onrender.com";
  // }

  static String baseUrl = "https://findernate-server.onrender.com";
  //static String baseUrl = "http://192.168.0.1:3000";

  static String get storeUsernameRedisURL =>
      '$baseUrl/api/username/store-username';
  static String getUsernameRedisURL(String username) =>
      '$baseUrl/api/username/check/$username';

  static String get storePhoneRedisURL => '$baseUrl/api/phone/store-phone';
  static String getPhoneRedisURL(String phone) =>
      '$baseUrl/api/phone/check/$phone';

  static String get sendOTPTwilioURL => '$baseUrl/api/otp/send-otp';
  static String get verifyOTPTwilioURL => '$baseUrl/api/otp/verify-otp';

  static String get storeUserDataRedisURl => '$baseUrl/api/user/store-data';
  static String get updateUserDataRedisURl => '$baseUrl/api/user/update-data';
  static String get deleteUserDataRedisURl => '$baseUrl/api/user/delete-data';
  static String getUserDataRedisURl(String uid) => '$baseUrl/api/user/get-data/$uid';
}
