import 'dart:async';

import 'package:intl_field_phone/phone_number.dart';

class Validator {
  static String? usernameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    } else if (value.length < 6) {
      return 'Minimum 6 characters required';
    } else if (value.length > 12) {
      return 'Maximum 12 characters allowed';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required.';
    }

    final trimmed = value.trim();

    //* ✅ Allows optional + at start, digits only, and 10–15 digits
    final phoneRegex = RegExp(r'^(\+?\d{10,15})$');

    if (!phoneRegex.hasMatch(trimmed)) {
      return 'Enter a valid phone number (10–15 digits).';
    }

    return null;
  }

  static FutureOr<String?> phoneNumberValidator(PhoneNumber? number) {
    if (number == null || number.number.trim().isEmpty) {
      return 'Phone number is required';
    }

    if (number.number.length < 10 || number.number.length > 15) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  static String? fullNameValidator(String? value, {int maxWords = 4}) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }

    final wordCount = value.trim().split(RegExp(r'\s+')).length;

    if (wordCount > maxWords) {
      return 'Maximum allowed words is $maxWords. You entered $wordCount.';
    }

    final namePattern = RegExp(r'^[a-zA-Z ]+$');
    if (!namePattern.hasMatch(value.trim())) {
      return 'Full name can only contain letters and spaces';
    }

    return null;
  }

  static String? aboutInfoValidator(String? value, {int maxWords = 50}) {
    if (value == null || value.trim().isEmpty) {
      return 'About info is required';
    }

    final wordCount = value.trim().split(RegExp(r'\s+')).length;

    if (wordCount > maxWords) {
      return 'Maximum allowed words is $maxWords. You entered $wordCount.';
    }

    return null;
  }

  static String? locationValidator(String? value, {int maxWords = 4}) {
    if (value == null || value.trim().isEmpty) {
      return 'Location is required';
    }

    final wordCount = value.trim().split(RegExp(r'\s+')).length;

    if (wordCount > maxWords) {
      return 'Maximum allowed words is $maxWords. You entered $wordCount.';
    }

    final pattern = RegExp(r'^[a-zA-Z0-9\s,.-]+$');
    if (!pattern.hasMatch(value.trim())) {
      return 'Location can only contain letters, numbers, spaces, commas, periods, and hyphens';
    }

    return null;
  }

  static String? captionValidator(
    String? value, {
    int minWords = 3,
    int maxWords = 30,
    int maxCharacters = 2200, // Instagram's max caption length
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Caption is required.';
    }

    final trimmedValue = value.trim();
    final wordCount = trimmedValue.split(RegExp(r'\s+')).length;
    final charCount = trimmedValue.length;

    if (wordCount < minWords) {
      return 'Caption should have at least $minWords words.\nCurrently: $wordCount.';
    }

    if (wordCount > maxWords) {
      return 'Maximum allowed words is $maxWords.\nYou entered $wordCount.';
    }

    if (charCount > maxCharacters) {
      return 'Maximum character limit is $maxCharacters.\nYou entered $charCount.';
    }

    return null;
  }

  static String? hashtagValidator(
    String? value, {
    int minTags = 1,
    int maxTags = 10,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'At least $minTags hashtag(s) required.';
    }

    final tags = value
        .trim()
        .split(RegExp(r'\s+'))
        .where((tag) => tag.trim().isNotEmpty)
        .toList();

    if (tags.length < minTags) {
      return 'Minimum $minTags hashtags required.\nYou entered ${tags.length}.';
    }

    if (tags.length > maxTags) {
      return 'Maximum $maxTags hashtags allowed.\nYou entered ${tags.length}.';
    }

    final invalidTags = tags
        .where((tag) => !RegExp(r'^#[a-zA-Z0-9_]+$').hasMatch(tag))
        .toList();
    if (invalidTags.isNotEmpty) {
      return 'Invalid hashtag(s): ${invalidTags.join(', ')}';
    }

    return null;
  }
}

String formatTime(int seconds) {
  final m = (seconds ~/ 60).toString().padLeft(2, '0');
  final s = (seconds % 60).toString().padLeft(2, '0');
  return "$m:$s";
}
