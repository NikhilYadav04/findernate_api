import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptions {
  static String getRegisterError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return '❌ The email address is not valid.';
      case 'email-already-in-use':
        return '❌ An account already exists for that email.';
      case 'weak-password':
        return '❌ The provided password is too weak.';
      case 'operation-not-allowed':
        return '❌ Registration is not allowed. Please contact support.';
      default:
        return 'Weak Password';
    }
  }

  static String getLoginError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return '❌ The email address is not valid.';
      case 'user-disabled':
        return '❌ This user has been disabled. Contact support.';
      case 'user-not-found':
        return '❌ No user found for that email.';
      case 'wrong-password':
        return '❌ Wrong password provided for that user.';
      case 'invalid-credential':
        return '❌ Wrong password provided for that user.';
      default:
        print(e.code);
        return '❌ Login failed with error: ';
    }
  }

  static String getSendOTPError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return '❌ The phone number is not a valid format.';
      case 'too-many-requests':
        return '❌ Too many requests. Please try again later.';
      case 'quota-exceeded':
        return '❌ SMS quota for this project has been exceeded.';
      default:
        return '❌ Phone verification failed with error';
    }
  }

  static String verifyOTPError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-verification-code':
        return '❌ The verification code (OTP) is invalid.';
      case 'session-expired':
        return '❌ The SMS code has expired. Please request a new OTP.';
      case 'quota-exceeded':
        return '❌ SMS quota exceeded. Try again later.';
      default:
        return '❌ OTP verification failed with error';
    }
  }
}
