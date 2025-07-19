import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/http/models/posts/base_post_model.dart';

class PostImageWidget extends StatefulWidget {
  final double sw;
  final double sh;
  final void Function() onTap;
  final PostModel postData;

  const PostImageWidget({
    Key? key,
    required this.sw,
    required this.sh,
    required this.onTap,
    required this.postData,
  }) : super(key: key);

  @override
  _PostImageWidgetState createState() => _PostImageWidgetState();
}

class _PostImageWidgetState extends State<PostImageWidget> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaData = widget.postData.media;
    final contentType = widget.postData.contentType;

    List<String> imageUrls = [];

    //* Add main image
    if (mediaData.isNotEmpty) {
      for (MediaModel media in mediaData) {
        imageUrls.add(media.url);
      }
    }

    return GestureDetector(
      onDoubleTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: widget.sw * 0.04),
        width: double.infinity,
        height: widget.sw,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: imageUrls.length == 1
                    ? _buildSingleImage(imageUrls.first)
                    : _buildMultipleImages(imageUrls),
              ),
            ),

            // Page indicator for multiple images
            if (imageUrls.length > 1) _buildPageIndicator(imageUrls.length),

            // Content type specific overlay
            if (contentType == 'normal')
              buildNormalOverlay(widget.sw, widget.sh, widget.postData),
          ]
        ),
      ),
    );
  }

  Widget _buildSingleImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: Colors.grey.shade200,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.appGradient1,
            ),
            strokeWidth: 2.0,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: Colors.grey.shade200,
        child: Icon(
          Icons.error,
          color: Colors.grey.shade400,
          size: widget.sw * 0.1,
        ),
      ),
      fadeInDuration: Duration(milliseconds: 300),
      fadeOutDuration: Duration(milliseconds: 300),
    );
  }

  Widget _buildMultipleImages(List<String> imageUrls) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return CachedNetworkImage(
          imageUrl: imageUrls[index],
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey.shade200,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.appGradient1,
                ),
                strokeWidth: 2.0,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey.shade200,
            child: Icon(
              Icons.error,
              color: Colors.grey.shade400,
              size: widget.sw * 0.1,
            ),
          ),
          fadeInDuration: Duration(milliseconds: 300),
          fadeOutDuration: Duration(milliseconds: 300),
        );
      },
    );
  }

  Widget _buildPageIndicator(int imageCount) {
    return Positioned(
      top: 12,
      right: 12,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: widget.sw * 0.02,
          vertical: widget.sh * 0.004,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '${_currentIndex + 1}/$imageCount',
          style: TextStyle(
            color: Colors.white,
            fontSize: widget.sh * 0.012,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

Widget buildNormalOverlay(double sw, double sh, PostModel postData) {
  final customization = postData.contentType;

  // Check if customization exists and has normal data
  if (customization == 'normal') {
    return SizedBox.shrink();
  }

  final normalData = postData.customization.normal;
  final mood = normalData?.mood ?? '';
  final activity = normalData?.activity ?? '';

  if (mood.isEmpty && activity.isEmpty) return SizedBox.shrink();

  return Positioned(
    top: 12,
    left: 12,
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.025,
        vertical: sh * 0.005,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.appGradient1.withOpacity(0.9),
            AppColors.appGradient2.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '${mood} • ${activity}',
        style: TextStyle(
          color: Colors.white,
          fontSize: sh * 0.012,
          fontFamily: 'Poppins-Medium',
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

// Helper function to use the widget (replaces your original buildPostImage function)
Widget buildPostImage(
    double sw, double sh, void Function() onTap, PostModel postData) {
  return PostImageWidget(
    sw: sw,
    sh: sh,
    onTap: onTap,
    postData: postData,
  );
}
