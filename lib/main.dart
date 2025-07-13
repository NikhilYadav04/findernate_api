import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/app.dart';
import 'package:social_media_clone/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //* Lock Orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  //* Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //* Initialize Hive
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');

  var logger = Logger();

  box.toMap().forEach((key, value) {
    logger.d("$key  $value");
  });

  logger.d("Is bsienss is ${box.get('isBusinessProfile')}");

  //* Initialize .env
  await dotenv.load();

  //* Set status to online
  final userId = await FirebaseAuth.instance.currentUser?.uid;
  logger.d("user id $userId");

  // if (userId != null) {
  //   final PresenceService _presenceService = PresenceService(userId);
  //   _presenceService.startTracking();
  // }

//  ApiEndpoints.initialize();

  //* To Handle Crash Status
  //runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}
