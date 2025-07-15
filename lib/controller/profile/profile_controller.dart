import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/http/models/api_reponse.dart';
import 'package:social_media_clone/http/models/model_user.dart';
import 'package:social_media_clone/http/services/user_service.dart';

class ProviderProfile extends ChangeNotifier {
  //* Form Keys
  final GlobalKey<FormState> usernameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  final GlobalKey<FormState> fullNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> bioKey = GlobalKey<FormState>();
  final GlobalKey<FormState> dateKey = GlobalKey<FormState>();
  final GlobalKey<FormState> businessNameKey = GlobalKey<FormState>();
  final GlobalKey<FormState> subCatKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> subCatKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> subCatKey3 = GlobalKey<FormState>();

  //* Text Controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController profileImageController = TextEditingController();
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController subCatController1 = TextEditingController();
  final TextEditingController subCatController2 = TextEditingController();
  final TextEditingController subCatController3 = TextEditingController();

  //* State Variables
  String gender = "male";
  File? imageFIle;
  bool _isBusinessProfile = false;
  String _businessType = "Fashion";
  bool _isLoading = false;

  //* Getters
  bool get isBusinessProfile => _isBusinessProfile;
  String get businessType => _businessType;
  bool get isLoading => _isLoading;

  //* Error Handling Map
  final Map<String, bool> _fieldErrors = {};

  bool hasError(String field) => _fieldErrors[field] ?? false;
  bool get hasAnyError => _fieldErrors.values.any((e) => e);

  //* Utility Functions
  void setFieldError(String field, bool value) {
    if (_fieldErrors[field] != value) {
      _fieldErrors[field] = value;
      notifyListeners();
    }
  }

  void clearFieldError() {
    _fieldErrors.clear();
    notifyListeners();
  }

  void setIsBusinessProfile(bool value) {
    _isBusinessProfile = value;
    notifyListeners();
  }

  void setBusinessType(String value) {
    _businessType = value;
    notifyListeners();
  }

  void setDate(DateTime date) {
    dateController.text = "${date.day}/${date.month}/${date.year}";
    notifyListeners();
  }

  void setGender(String newGender) {
    if (newGender == "Male") {
      gender = "male";
    } else {
      gender = "female";
    }
    gender = newGender;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //* Image Picker Function
  Future<File?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFIle = File(pickedFile.path);
      notifyListeners();
      return File(pickedFile.path);
    } else {
      print("No image selected.");
      return null;
    }
  }

  //* Validation Functions
  bool validateField(String field, GlobalKey<FormState> key) {
    bool isValid = key.currentState?.validate() ?? false;
    setFieldError(field, !isValid);
    return isValid;
  }

  //* Update User Profile API Call
  Future<bool> updateUserProfile({required BuildContext context}) async {
    try {
      setLoading(true);

      final userService = UserService();

      Map<String, dynamic> profileData = {
        'fullName': fullNameController.text.trim(),
        'bio': bioController.text.trim(),
        'location': '',
        'link': '',
        'profileImageUrl':
            'https://static.thenounproject.com/png/630737-200.png',
      };

      ApiResponse<Map<String, dynamic>> response =
          await userService.editUserProfile(
        profileData: profileData,
      );

      if (response.success) {
        final authProvider = Provider.of<ProviderAuth>(context, listen: false);
        authProvider.setCurrentUserData(UserModel.fromJson(response.data!));
        showSnackBar("Profile updated successfully", context, isError: false);

        return true;
      } else {
        showSnackBar("Failed to update profile", context, isError: true);
        return false;
      }
    } catch (e) {
      showSnackBar("Error updating profile", context, isError: true);
      return false;
    } finally {
      setLoading(false);
    }
  }

  //* Clear All Data
  void clearAllData() {
    userNameController.clear();
    emailController.clear();
    fullNameController.clear();
    bioController.clear();
    dateController.clear();
    profileImageController.clear();
    businessNameController.clear();
    subCatController1.clear();
    subCatController2.clear();
    subCatController3.clear();

    gender = "Male";
    imageFIle = null;
    _isBusinessProfile = false;
    _businessType = "Fashion";
    _isLoading = false;

    clearFieldError();
    notifyListeners();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    fullNameController.dispose();
    bioController.dispose();
    dateController.dispose();
    profileImageController.dispose();
    businessNameController.dispose();
    subCatController1.dispose();
    subCatController2.dispose();
    subCatController3.dispose();
    super.dispose();
  }
}
