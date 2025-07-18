// url_launcher_helper.dart
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper {
  /// Launches a web URL in external browser
  static Future<void> launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      print('Could not launch $url: $e');
    }
  }

  /// Launches email app with recipient filled
  static Future<void> launchEmail(String? email) async {
    if (email == null || email.isEmpty) {
      print('Email is null or empty');
      return;
    }

    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
      );
      await launchUrl(emailUri);
    } catch (e) {
      print('Could not launch email $email: $e');
      // Fallback: try opening as web URL
      try {
        await launchURL('mailto:$email');
      } catch (e2) {
        print('Fallback email launch also failed: $e2');
      }
    }
  }

  /// Launches phone dialer with number filled
  static Future<void> launchPhone(String? phone) async {
    if (phone == null || phone.isEmpty) {
      print('Phone number is null or empty');
      return;
    }

    try {
      final Uri phoneUri = Uri(
        scheme: 'tel',
        path: phone,
      );
      await launchUrl(phoneUri);
    } catch (e) {
      print('Could not launch phone $phone: $e');
    }
  }

  /// Formats URL for display by removing protocol
  static String formatURL(String url) {
    return url.replaceAll('https://', '').replaceAll('http://', '');
  }

  /// Launches SMS app with number filled
  static Future<void> launchSMS(String? phone, {String? message}) async {
    if (phone == null || phone.isEmpty) {
      print('Phone number is null or empty');
      return;
    }

    try {
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: phone,
        queryParameters: message != null ? {'body': message} : null,
      );
      await launchUrl(smsUri);
    } catch (e) {
      print('Could not launch SMS $phone: $e');
    }
  }

  /// Launches WhatsApp with number
  static Future<void> launchWhatsApp(String? phone, {String? message}) async {
    if (phone == null || phone.isEmpty) {
      print('Phone number is null or empty');
      return;
    }

    try {
      final String whatsappUrl =
          'https://wa.me/$phone${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}';
      await launchURL(whatsappUrl);
    } catch (e) {
      print('Could not launch WhatsApp $phone: $e');
    }
  }

  /// Launches Google Maps with address
  static Future<void> launchMaps(String address) async {
    try {
      final String mapsUrl =
          'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}';
      await launchURL(mapsUrl);
    } catch (e) {
      print('Could not launch Maps for $address: $e');
    }
  }

  /// Launches Google Maps with coordinates
  static Future<void> launchMapsCoordinates(
      double latitude, double longitude) async {
    try {
      final String mapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
      await launchURL(mapsUrl);
    } catch (e) {
      print('Could not launch Maps for coordinates $latitude,$longitude: $e');
    }
  }

  /// Safe null-check wrapper for any launch function
  static Future<void> safeLaunch(
      Future<void> Function() launchFunction, String actionName) async {
    try {
      await launchFunction();
    } catch (e) {
      print('Could not perform $actionName: $e');
    }
  }
}
