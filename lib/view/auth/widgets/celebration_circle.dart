import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CelebrationCircleWidget extends StatelessWidget {
  final Widget pna;

  const CelebrationCircleWidget({super.key, required this.pna});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Gradient circles
        Positioned(
            top: size.height * 0.08,
            left: size.width * 0.15,
            child: _buildDot(size)),
        Positioned(
            top: size.height * 0.1,
            right: size.width * 0.2,
            child: _buildDot(size)),
        Positioned(
            left: size.width * 0.1,
            bottom: size.height * 0.25,
            child: _buildDot(size)),
        Positioned(
            right: size.width * 0.1,
            bottom: size.height * 0.2,
            child: _buildDot(size)),
        Positioned(
            left: size.width * 0.25,
            bottom: size.height * 0.1,
            child: _buildDot(size)),
        Positioned(
            right: size.width * 0.25,
            top: size.height * 0.25,
            child: _buildDot(size)),

        // Stars
        Positioned(
            top: size.height * 0.2,
            left: size.width * 0.3,
            child: _buildStar()),
        Positioned(
            top: size.height * 0.3,
            right: size.width * 0.3,
            child: _buildStar()),
        Positioned(
            bottom: size.height * 0.2,
            right: size.width * 0.35,
            child: _buildStar()),
        Positioned(
            bottom: size.height * 0.15,
            left: size.width * 0.3,
            child: _buildStar()),

        // Center widget
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: size.width * 0.2,
              backgroundColor: Colors.grey.shade100,
              child: SvgPicture.asset(
                "assets/images/svg/ic_celebrate.svg",
                color: Colors.black,
                height: 50,
                width: 50,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDot(Size size) {
    return Container(
      width: size.width * 0.035,
      height: size.width * 0.035,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF9C12D), // Or AppColors.appGradient1
            Color(0xFFF59F00), // Or AppColors.appGradient2
          ],
        ),
      ),
    );
  }

  Widget _buildStar() {
    return const Icon(
      Icons.star,
      color: Color(0xFFF9C12D), // Match the gradient top color
      size: 24,
    );
  }
}
