import 'package:hive/hive.dart';

class HelperFunctions {
  static const String _boxName = 'mybox';
  static const String _authStatusKey = 'authStatus';

  //* Returns true if a valid userID is found in Hive box
  static Future<bool> isUserLoggedIn() async {
    try {
      final box = await Hive.openBox(_boxName);
      final userId = box.get(_authStatusKey);

      return userId == true;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }
}
