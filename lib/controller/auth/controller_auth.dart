import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/models/model_user.dart';
import 'package:social_media_clone/http/services/auth_service.dart';
import 'package:social_media_clone/http/services/user_service.dart';
import 'package:social_media_clone/http/utils/http_client.dart';
import 'package:social_media_clone/core/router/appRouter.dart';

class ProviderSignIn extends ChangeNotifier {
  //* Form Keys
  final GlobalKey<FormState> userNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPassUsernameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPassEmailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPassPhoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgetPassLastPasswordFormKey =
      GlobalKey<FormState>();
  final GlobalKey<FormState> oldPasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> newPasswordKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  //* delete account
  final GlobalKey<FormState> deletePasswordKey = GlobalKey<FormState>();

  //* change password
  final GlobalKey<FormState> changeOTPKey = GlobalKey<FormState>();

  //* TextField Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController forgetPassUsernameController =
      TextEditingController();
  final TextEditingController forgetPassEmailController =
      TextEditingController();
  final TextEditingController forgetPassPhoneController =
      TextEditingController();
  final TextEditingController forgetPassLastPasswordController =
      TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  //* delete account
  final TextEditingController deletePasswordController =
      TextEditingController();

  //* delete account
  final TextEditingController changeOTPController = TextEditingController();

  //* Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //* Utils
  void toggleVisibility(bool val) {
    val = !val;
    notifyListeners();
  }

  //* Field validation
  final Map<String, bool> _fieldErrors = {};

  bool hasError(String field) => _fieldErrors[field] ?? false;

  void setFieldError(String field, bool value) {
    if (_fieldErrors[field] != value) {
      _fieldErrors[field] = value;
      notifyListeners();
    }
  }

  bool get hasAnyError => _fieldErrors.values.any((e) => e);

  //* Dispose Controllers
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    forgetPassUsernameController.dispose();
    forgetPassEmailController.dispose();
    forgetPassPhoneController.dispose();
    forgetPassLastPasswordController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    otpController.dispose();
    super.dispose();
  }
}

class ProviderRegister extends ChangeNotifier {
  //* Form Keys
  final GlobalKey<FormState> usernameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordConfirmFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> personalFullNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> personalEmailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> personalDOBKey = GlobalKey<FormState>();
  final GlobalKey<FormState> personalGenderKey = GlobalKey<FormState>();
  final GlobalKey<FormState> personalAboutKey = GlobalKey<FormState>();

  //* TextField Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController phoneFormController = TextEditingController();
  final TextEditingController personalFullNameController =
      TextEditingController();
  final TextEditingController personalEmailController = TextEditingController();
  final TextEditingController personalDOBController = TextEditingController();
  final TextEditingController personalGenderController =
      TextEditingController();
  final TextEditingController personalCategoryController =
      TextEditingController();
  final TextEditingController personalAboutController = TextEditingController();

  //* State variables
  String registerPhone = "";
  String gender = "male";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //* Utils
  void toggleVisibility(bool val) {
    val = !val;
    notifyListeners();
  }

  void setPhoneNumber(String value) {
    registerPhone = value;
    notifyListeners();
  }

  void setDate(DateTime date) {
    personalDOBController.text =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    notifyListeners();
  }

  void setGender(String newGender) {
    if (newGender == "Male") {
      gender = "male";
    } else {
      gender = "female";
    }
    personalGenderController.text = gender;
    Logger().d(gender);
    notifyListeners();
  }

  //* Field validation
  final Map<String, bool> _fieldErrors = {};

  bool hasError(String field) => _fieldErrors[field] ?? false;

  void setFieldError(String field, bool value) {
    if (_fieldErrors[field] != value) {
      _fieldErrors[field] = value;
      notifyListeners();
    }
  }

  bool get hasAnyError => _fieldErrors.values.any((e) => e);

  //* Dispose Controllers
  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    otpController.dispose();
    phoneFormController.dispose();
    personalFullNameController.dispose();
    personalEmailController.dispose();
    personalDOBController.dispose();
    personalGenderController.dispose();
    personalCategoryController.dispose();
    personalAboutController.dispose();
    super.dispose();
  }
}

class ProviderAuth extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final HttpClient _httpClient = HttpClient();

  bool _isLoading = false;
  bool _isUserStatsLoading = false;
  String? _errorMessage;
  UserModel? _currentUserData;

  bool get isLoading => _isLoading;
  bool get isUserStatsLoading => _isUserStatsLoading;
  String? get errorMessage => _errorMessage;
  UserModel? get currentUserData => _currentUserData;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _setCurrentUserData(UserModel? user) {
    _currentUserData = user;
    notifyListeners();
  }

  void setCurrentUserData(UserModel? user) {
    _currentUserData = user;
    notifyListeners();
  }

  //* Get Users Stats and store in User Model ( when user launches app)
  Future<void> getUserStats({required BuildContext context}) async {
    //* Don't run if user stats are already loading or if _currentUserData is not empty
    if (_isUserStatsLoading || _currentUserData != null) {
      return;
    }

    try {
      _isUserStatsLoading = true;
      notifyListeners();

      final _userService = UserService();
      ApiResponse<Map<String, dynamic>> response =
          await _userService.getUserStats();

      if (response.success && response.data != null) {
        _currentUserData = UserModel.fromJson(response.data!);

        notifyListeners();
      } else {
        showSnackBar("Error fetching stats", context, isError: true);
        Logger().d(response.data!);

        _currentUserData = UserModel(
          uid: "",
          username: "",
          email: "",
          fullName: "",
          phoneNumber: "",
          dateOfBirth: "",
          gender: "",
          bio: "",
          profileImageUrl: "",
          location: "",
          followers: [],
          following: [],
          posts: [],
          isBusinessProfile: false,
          isEmailVerified: false,
          isPhoneVerified: false,
        );
      }
    } catch (e) {
      showSnackBar("Error fetching stats", context, isError: true);

      _currentUserData = UserModel(
        uid: "",
        username: "",
        email: "",
        fullName: "",
        phoneNumber: "",
        dateOfBirth: "",
        gender: "",
        bio: "",
        profileImageUrl: "",
        location: "",
        followers: [],
        following: [],
        posts: [],
        isBusinessProfile: false,
        isEmailVerified: false,
        isPhoneVerified: false,
      );
    } finally {
      _isUserStatsLoading = false;
      notifyListeners();
    }
  }

  //* Refresh Users Stats (force refresh)
  Future<void> refreshUserStats({required BuildContext context}) async {
    try {
      if (_isUserStatsLoading) {
        return;
      }

      _isUserStatsLoading = true;
      notifyListeners();

      final _userService = UserService();
      ApiResponse<Map<String, dynamic>> response =
          await _userService.getUserStats();

      if (response.success && response.data != null) {
        _currentUserData = UserModel.fromJson(response.data!);
        notifyListeners();
      } else {
        showSnackBar("Error refreshing stats", context, isError: true);

        _currentUserData = UserModel(
          uid: "",
          username: "",
          email: "",
          fullName: "",
          phoneNumber: "",
          dateOfBirth: "",
          gender: "",
          bio: "",
          profileImageUrl: "",
          location: "",
          followers: [],
          following: [],
          posts: [],
          isBusinessProfile: false,
          isEmailVerified: false,
          isPhoneVerified: false,
        );
      }
    } catch (e) {
      showSnackBar("Error refreshing stats", context, isError: true);

      _currentUserData = UserModel(
        uid: "",
        username: "",
        email: "",
        fullName: "",
        phoneNumber: "",
        dateOfBirth: "",
        gender: "",
        bio: "",
        profileImageUrl: "",
        location: "",
        followers: [],
        following: [],
        posts: [],
        isBusinessProfile: false,
        isEmailVerified: false,
        isPhoneVerified: false,
      );
    } finally {
      _isUserStatsLoading = false;
      notifyListeners();
    }
  }

  //* Login user
  Future<bool> login({
    required String usernameOrEmail,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.login(
        usernameOrEmail: usernameOrEmail,
        password: password,
      );

      if (response.success && response.data != null) {
        _setCurrentUserData(UserModel.fromJson(response.data!['user']));
        _setLoading(false);
        showSnackBar(response.message, context, isError: false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Register user
  Future<bool> register({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String dateOfBirth,
    required String gender,
    required BuildContext context,
    String? bio,
    String? link,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.register(
        fullName: fullName,
        username: username,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
        phoneNumber: phoneNumber,
        dateOfBirth: dateOfBirth,
        gender: gender,
        bio: bio,
        link: link,
      );

      if (response.success) {
        _setLoading(false);
        showSnackBar(response.message, context, isError: false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Verify email OTP for registration
  Future<bool> verifyRegister({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.verifyUserRegister(
        email: email,
        otp: otp,
      );

      if (response.success) {
        _setLoading(false);
        if (response.data != null) {
          _setCurrentUserData(UserModel.fromJson(response.data!));
        }
        showSnackBar(response.message, context, isError: false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Send verification OTP
  Future<bool> sendVerificationOtp({
    required String email,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.sendVerificationOtp(
        email: email,
      );

      if (response.success) {
        _setLoading(false);
        showSnackBar(response.message, context, isError: false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Verify email OTP
  Future<bool> verifyEmailOtp({
    required String email,
    required String otp,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.verifyEmailOtp(
        email: email,
        otp: otp,
      );

      if (response.success) {
        _setLoading(false);
        showSnackBar(response.message, context, isError: false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Change password
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );

      if (response.success) {
        _setLoading(false);
        showSnackBar(response.message, context, isError: false);
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Logout user
  Future<bool> logout(BuildContext context) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.logout();

      if (response.success) {
        _setCurrentUserData(null);
        clearAll();
        _setLoading(false);
        showSnackBar(response.message, context, isError: false);

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/onboard',
          (route) => false, // This removes all previous routes
          arguments: {
            'transition': TransitionType.bottomToTop,
            'duration': 300,
          },
        );
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Logout user
  Future<bool> delete(BuildContext context, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      final response = await _authService.deleteAccount(password: password);

      if (response.success) {
        _setCurrentUserData(null);
        _setLoading(false);
        showSnackBar(response.message, context, isError: false);

        Navigator.pushNamedAndRemoveUntil(
          context,
          '/onboard',
          (route) => false,
          arguments: {
            'transition': TransitionType.bottomToTop,
            'duration': 300,
          },
        );
        return true;
      } else {
        _setError(response.message);
        _setLoading(false);
        showSnackBar(response.message, context, isError: true);
        return false;
      }
    } catch (e) {
      _setError('An unexpected error occurred: $e');
      _setLoading(false);
      showSnackBar('An unexpected error occurred', context, isError: true);
      return false;
    }
  }

  //* Check if user is authenticated
  Future<bool> isAuthenticated() async {
    try {
      return await _httpClient.isAuthenticated();
    } catch (e) {
      return false;
    }
  }

  //* Clear error message
  void clearError() {
    _setError(null);
  }

  //* Clear all data (for app restart/logout)
  void clearAll() {
    _isLoading = false;
    _errorMessage = null;
    _currentUserData = null;
    notifyListeners();
  }
}
