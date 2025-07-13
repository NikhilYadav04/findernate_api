class businessValidator {
  static String? businessNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business name is required';
    } else if (value.length < 3) {
      return 'Minimum 3 characters required';
    } else if (value.length > 50) {
      return 'Maximum 50 characters allowed';
    }
    return null;
  }

  static String? businessDescriptionValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business description is required';
    } else if (value.length < 10) {
      return 'Minimum 10 characters required';
    } else if (value.length > 500) {
      return 'Maximum 500 characters allowed';
    }
    return null;
  }

  static String? operatingHoursMondayValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Operating hours for Monday are required';
    } else if (!RegExp(
            r'^\d{1,2}:\d{2}\s*(AM|PM)\s*-\s*\d{1,2}:\d{2}\s*(AM|PM)$',
            caseSensitive: false)
        .hasMatch(value)) {
      return 'Format should be like 9:00 AM - 5:00 PM';
    }
    return null;
  }

  static String? operatingHoursFridayValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Operating hours for Friday are required';
    } else if (!RegExp(
            r'^\d{1,2}:\d{2}\s*(AM|PM)\s*-\s*\d{1,2}:\d{2}\s*(AM|PM)$',
            caseSensitive: false)
        .hasMatch(value)) {
      return 'Format should be like 9:00 AM - 5:00 PM';
    }
    return null;
  }

  static String? businessAddress1Validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address Line 1 is required';
    } else if (value.length < 5) {
      return 'Minimum 5 characters required';
    } else if (value.length > 100) {
      return 'Maximum 100 characters allowed';
    }
    return null;
  }

  static String? businessAddress2Validator(String? value) {
    if (value != null && value.isNotEmpty && value.length > 100) {
      return 'Maximum 100 characters allowed';
    }
    return null; // optional field
  }

  static String? streetValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Street is required';
    } else if (value.length < 3) {
      return 'Minimum 3 characters required';
    } else if (value.length > 50) {
      return 'Maximum 50 characters allowed';
    }
    return null;
  }

  static String? countryValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Country is required';
    } else if (value.length < 2) {
      return 'Minimum 2 characters required';
    } else if (value.length > 50) {
      return 'Maximum 50 characters allowed';
    }
    return null;
  }

  static String? cityValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'City is required';
    } else if (value.length < 2) {
      return 'Minimum 2 characters required';
    } else if (value.length > 50) {
      return 'Maximum 50 characters allowed';
    }
    return null;
  }

  static String? zipCodeValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'ZIP code is required';
    } else if (!RegExp(r'^\d{4,10}$').hasMatch(value)) {
      return 'ZIP code must be 4-10 digits';
    }
    return null;
  }

  static String? phoneNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    } else if (!RegExp(r'^\+?\d{7,15}$').hasMatch(value)) {
      return 'Enter a valid phone number (7-15 digits, optional +)';
    }
    return null;
  }
}

class KycValidators {
  //* Aadhaar Number: exactly 12 digits
  static String? aadhaarNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Aadhaar number is required';
    } else if (!RegExp(r'^\d{12}$').hasMatch(value.trim())) {
      return 'Aadhaar number must be exactly 12 digits';
    }
    return null;
  }

  //* Aadhaar OTP: exactly 6 digits
  static String? aadhaarOtpValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Aadhaar OTP is required';
    } else if (!RegExp(r'^\d{6}$').hasMatch(value.trim())) {
      return 'OTP must be exactly 6 digits';
    }
    return null;
  }

  //* PAN Number: 5 letters, 4 digits, 1 letter (e.g. ABCDE1234F)
  static String? panNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'PAN number is required';
    } else if (!RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$', caseSensitive: false)
        .hasMatch(value.trim())) {
      return 'Enter a valid PAN (e.g. ABCDE1234F)';
    }
    return null;
  }

  //* Name as per PAN: non-empty, letters and spaces only
  static String? nameAsPerPanValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    } else if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value.trim())) {
      return 'Name can contain only letters and spaces';
    }
    return null;
  }

  //* Date of Birth: non-empty, format DD/MM/YYYY, not in the future
  static String? dateOfBirthValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Date of birth is required';
    }
    final trimmed = value.trim();
    final regex = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$');
    final match = regex.firstMatch(trimmed);
    if (match == null) {
      return 'Enter date as DD/MM/YYYY';
    }

    final day = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final year = int.parse(match.group(3)!);
    try {
      final dob = DateTime(year, month, day);
      final today = DateTime.now();
      if (dob.isAfter(today)) {
        return 'Date of birth cannot be in the future';
      }
    } catch (_) {
      return 'Invalid date';
    }

    return null;
  }

  static String? adDetailsValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Ad description is required';
    } else if (value.trim().length < 10) {
      return 'Description must be at least 10 characters';
    }
    return null;
  }
}
