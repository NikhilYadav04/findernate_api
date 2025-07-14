import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_media_clone/app.dart';
import 'package:social_media_clone/http/utils/http_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only disable debugPrint in release mode
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  //* Lock Orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //* Initialize Hive

  //* Initialize .env
  await dotenv.load();

  //* Initialize Http CLient
  await HttpClient().init();

  //* To Handle Crash Status
  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}
