import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appImages.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/http/utils/http_client.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final HttpClient _httpClient = HttpClient();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkStatus(context);
    });
  }

  Future<void> checkStatus(BuildContext context) async {
    //* Fetch login status from hive
    //* Display splash for 2 seconds minimum
    await Future.delayed(Duration(seconds: 2));

    //* Check authentication status
    final bool isLoggedIn = await _httpClient.isAuthenticated();

    //* Navigate based on authentication
    if (mounted) {
      if (isLoggedIn) {
        Navigator.pushReplacementNamed(
          context,
          '/welcome-signin',
          arguments: {
            'transition': TransitionType.fade,
            'duration': 300,
          },
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
         '/onboard',
          arguments: {
            'transition': TransitionType.fade,
            'duration': 300,
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Stack(
          children: [
            //* Circle 1 (top right)
            Positioned(
              top: size.height * 0.05,
              right: size.width * 0.1,
              child: _buildCircle(size.width * 0.13),
            ),
            //* Circle 2 (top left)
            Positioned(
              top: size.height * 0.15,
              left: size.width * 0.2,
              child: _buildCircle(size.width * 0.08),
            ),
            //* Circle 3 (center left)
            Positioned(
              top: size.height * 0.5,
              left: size.width * 0.1,
              child: _buildCircle(size.width * 0.13),
            ),
            //* Circle 4 (center right)
            Positioned(
              top: size.height * 0.6,
              right: size.width * 0.1,
              child: _buildCircle(size.width * 0.13),
            ),
            //* Circle 5 (bottom right small)
            Positioned(
              bottom: size.height * 0.15,
              right: size.width * 0.05,
              child: _buildCircle(size.width * 0.1),
            ),
            //* Circle 6 (bottom left small)
            Positioned(
              bottom: size.height * 0.07,
              left: size.width * 0.2,
              child: _buildCircle(size.width * 0.1),
            ),

            Positioned(
              bottom: size.height * 0.52,
              right: size.width * 0.037,
              child: Image.asset(
                AppImages.appBarLogo,
                scale: 2.7,
                color: Color.fromARGB(255, 228, 167, 76),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildCircle(double diameter) {
  return Container(
    width: diameter,
    height: diameter,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFF9C12D), // Replace with AppColors.appGradient1 if needed
          Color(0xFFF59F00), // Replace with AppColors.appGradient2 if needed
        ],
      ),
    ),
  );
}
