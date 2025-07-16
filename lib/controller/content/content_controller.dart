import 'package:flutter/material.dart';
import 'dart:io';

class ProviderContent extends ChangeNotifier {
  // ========================================
  // POST SECTION
  // ========================================

  //* Post Controllers and Form Keys
  final GlobalKey<FormState> postCaptionKey = GlobalKey<FormState>();
  final GlobalKey<FormState> postHashTagKey = GlobalKey<FormState>();
  final GlobalKey<FormState> postLocationKey = GlobalKey<FormState>();

  final TextEditingController postCaptionController = TextEditingController();
  final TextEditingController postHashtagController = TextEditingController();
  final TextEditingController postLocationController = TextEditingController();
  final TextEditingController postTypeController = TextEditingController();

  //* Post Variables
  List<File>? imageFiles = [];

  //* Post Utils
  Future<void> pickImageFromGallery(List<File>? images) async {
    if (images != null && images.isNotEmpty) {
      imageFiles = images;
      notifyListeners();
    }
  }

  //* Post Validation
  final Map<String, bool> _postFieldErrors = {};

  bool hasPostError(String field) => _postFieldErrors[field] ?? false;

  void setPostFieldError(String field, bool value) {
    if (_postFieldErrors[field] != value) {
      _postFieldErrors[field] = value;
      notifyListeners();
    }
  }

  void clearPostFieldError() {
    _postFieldErrors.clear();
    notifyListeners();
  }

  bool get hasAnyPostError => _postFieldErrors.values.any((e) => e);

  // ========================================
  // REEL SECTION
  // ========================================

  //* Reel Controllers and Form Keys
  final GlobalKey<FormState> reelCaptionKey = GlobalKey<FormState>();
  final GlobalKey<FormState> reelHashTagKey = GlobalKey<FormState>();
  final GlobalKey<FormState> reelLocationKey = GlobalKey<FormState>();

  final TextEditingController reelCaptionController = TextEditingController();
  final TextEditingController reelHashtagController = TextEditingController();
  final TextEditingController reelLocationController = TextEditingController();

  //* Reel Variables
  File? videoFile;

  //* Reel Utils
  Future<void> pickReelVideo(File? video) async {
    if (video != null) {
      videoFile = video;
      notifyListeners();
    }
  }

  //* Reel Validation
  final Map<String, bool> _reelFieldErrors = {};

  bool hasReelError(String field) => _reelFieldErrors[field] ?? false;

  void setReelFieldError(String field, bool value) {
    if (_reelFieldErrors[field] != value) {
      _reelFieldErrors[field] = value;
      notifyListeners();
    }
  }

  void clearReelFieldError() {
    _reelFieldErrors.clear();
    notifyListeners();
  }

  bool get hasAnyReelError => _reelFieldErrors.values.any((e) => e);
}
