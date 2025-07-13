import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/controller/dummy.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/services/connectivityServices.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NetworkProvider()),
        ChangeNotifierProvider(create: (_) => ProviderSignIn()),
        ChangeNotifierProvider(create: (_) => ProviderRegister()),
        ChangeNotifierProvider(create: (_) => Dummy()),
      ],
      child: MaterialApp(
        navigatorKey: navKey,
        debugShowCheckedModeBanner: false,
        title: 'Social Media Clone',
        theme: ThemeData(
          disabledColor: Colors.black,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(color: Colors.grey.shade800),
          ),
          primaryColor: Colors.white,
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
