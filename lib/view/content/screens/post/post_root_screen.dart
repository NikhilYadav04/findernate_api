import 'package:flutter/material.dart';
import 'package:social_media_clone/view/content/screens/post/services_post_screen.dart';
import 'normal_post_screen.dart';
import 'business_post_screen.dart';

import 'product_post_screen.dart';

// App Colors Definition
class AppColors {
  static const Color appGradient1 = Color(0xFF6A5ACD);
  static const Color appGradient2 = Color(0xFF9370DB);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;
  static const Color lightGrey = Color(0xFFF2F2F2);
  static const Color borderColor = Color(0xFFE0E0E0);
  static const Color orangeAccent = Color(0xFFFFA500);
  static const Color yellowAccent = Color(0xFFFCD45C);
  static const Color errorColor = Colors.red;
}

// Post Type Enum
enum PostType { normal, business, service, product }

// ROOT SCREEN - Main Create Post Screen with Interactive Cards
class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen>
    with TickerProviderStateMixin {
  PostType? selectedPostType;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final sw = size.width;
    final sh = size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.black, size: sw * 0.06),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Post',
          style: TextStyle(
            color: AppColors.black,
            fontSize: sh * 0.025,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.appGradient1.withOpacity(0.05),
              AppColors.appGradient2.withOpacity(0.05)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(sw * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Post Type',
                style: TextStyle(
                  fontSize: sh * 0.022,
                  fontFamily: 'Poppins-Bold',
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              SizedBox(height: sh * 0.025),

              // Post Type Cards
              _buildPostTypeCard(
                PostType.normal,
                'Normal Post',
                'Share your daily moments and thoughts',
                Icons.photo_camera,
                AppColors.appGradient1,
                sw,
                sh,
              ),

              SizedBox(height: sh * 0.02),

              _buildPostTypeCard(
                PostType.business,
                'Business',
                'Make business announcements and updates',
                Icons.business,
                AppColors.orangeAccent,
                sw,
                sh,
              ),

              SizedBox(height: sh * 0.02),

              _buildPostTypeCard(
                PostType.service,
                'Service',
                'Offer your services with detailed information',
                Icons.room_service,
                AppColors.yellowAccent,
                sw,
                sh,
              ),

              SizedBox(height: sh * 0.02),

              _buildPostTypeCard(
                PostType.product,
                'Product',
                'Showcase and sell your products',
                Icons.shopping_bag,
                AppColors.appGradient2,
                sw,
                sh,
              ),

              // Spacer to push button to bottom
              Spacer(),

              // Continue Button
              if (selectedPostType != null) _buildContinueButton(sw, sh),

              SizedBox(height: sh * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostTypeCard(PostType type, String title, String description,
      IconData icon, Color accentColor, double sw, double sh) {
    bool isSelected = selectedPostType == type;

    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: () {
        setState(() {
          selectedPostType = type;
        });
        // Add haptic feedback
        // HapticFeedback.lightImpact();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: selectedPostType == type ? _scaleAnimation.value : 1.0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: double.infinity,
              padding: EdgeInsets.all(sw * 0.04),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? accentColor : AppColors.borderColor,
                  width: isSelected ? 3 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? accentColor.withOpacity(0.3)
                        : AppColors.grey.withOpacity(0.1),
                    blurRadius: isSelected ? 15 : 8,
                    offset: Offset(0, isSelected ? 8 : 4),
                  ),
                ],
                gradient: isSelected
                    ? LinearGradient(
                        colors: [
                          accentColor.withOpacity(0.1),
                          accentColor.withOpacity(0.05),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  // Icon Section
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: sw * 0.15,
                    height: sw * 0.15,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? accentColor.withOpacity(0.2)
                          : AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(
                              color: accentColor.withOpacity(0.5), width: 2)
                          : null,
                    ),
                    child: Icon(
                      icon,
                      color: isSelected ? accentColor : AppColors.grey,
                      size: sw * 0.08,
                    ),
                  ),

                  SizedBox(width: sw * 0.04),

                  // Text Section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: sh * 0.02,
                            fontFamily: 'Poppins-Bold',
                            fontWeight: FontWeight.bold,
                            color: isSelected ? accentColor : AppColors.black,
                          ),
                        ),
                        SizedBox(height: sh * 0.005),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: sh * 0.016,
                            fontFamily: 'Poppins-Light',
                            color: isSelected
                                ? accentColor.withOpacity(0.8)
                                : AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Selection Indicator
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: sw * 0.06,
                    height: sw * 0.06,
                    decoration: BoxDecoration(
                      color: isSelected ? accentColor : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? accentColor : AppColors.grey,
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            color: AppColors.white,
                            size: sw * 0.035,
                          )
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContinueButton(double sw, double sh) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: selectedPostType != null ? 1.0 : 0.0,
      child: AnimatedSlide(
        duration: Duration(milliseconds: 500),
        offset: selectedPostType != null ? Offset.zero : Offset(0, 0.5),
        child: Container(
          width: double.infinity,
          height: sh * 0.07,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.appGradient1, AppColors.appGradient2],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.appGradient1.withOpacity(0.4),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: selectedPostType != null
                ? () {
                    _navigateToPostScreen();
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: sh * 0.02,
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: sw * 0.02),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                  size: sh * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToPostScreen() {
    if (selectedPostType == null) return;

    Widget targetScreen;
    switch (selectedPostType!) {
      case PostType.normal:
        targetScreen = NormalPostScreen();
        break;
      case PostType.business:
        targetScreen = BusinessPostScreen();
        break;
      case PostType.service:
        targetScreen = ServicePostScreen();
        break;
      case PostType.product:
        targetScreen = ProductPostScreen();
        break;
    }

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => targetScreen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: Duration(milliseconds: 300),
      ),
    );
  }
}
