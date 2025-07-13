import 'package:flutter/material.dart';

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

  //* Email validation utility
  bool isEmail(String input) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegex.hasMatch(input);
  }

  //* Login functionality
  Future<bool> loginUser({
    required BoxConstraints constraints,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      // Add your login logic here
      await Future.delayed(Duration(seconds: 2)); // Simulate login

      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  //* Logout functionality
  Future<void> signOut({
    required BoxConstraints constraints,
    required BuildContext context,
  }) async {
    try {
      // Add your logout logic here
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/sign-in',
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      print(e.toString());
    }
  }

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
  String gender = "Male";
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
    gender = newGender;
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

  //* Register functionality
  Future<bool> registerUser({
    required BoxConstraints constraints,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      // Add your registration logic here
      await Future.delayed(Duration(seconds: 2)); // Simulate registration

      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  //* OTP functionality
  Future<bool> sendOtp({
    required BoxConstraints constraints,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      // Add your OTP sending logic here
      await Future.delayed(Duration(seconds: 1)); // Simulate OTP sending

      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp({
    required BoxConstraints constraints,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      // Add your OTP verification logic here
      await Future.delayed(Duration(seconds: 1)); // Simulate OTP verification

      _setLoading(false);
      return true;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

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
