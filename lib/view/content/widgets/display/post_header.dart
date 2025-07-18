// universal_post_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/view/content/widgets/display/post_actions.dart';
import 'package:social_media_clone/view/content/widgets/display/post_content.dart';
import 'package:social_media_clone/view/content/widgets/display/post_engagement.dart';
import 'package:social_media_clone/view/content/widgets/display/post_image.dart';
import 'package:social_media_clone/view/content/widgets/display/post_tags.dart';

class UniversalPostCard extends StatefulWidget {
  final Map<String, dynamic> postData;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final VoidCallback? onProfileTap;

  const UniversalPostCard({
    Key? key,
    required this.postData,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onSave,
    this.onProfileTap,
  }) : super(key: key);

  @override
  _UniversalPostCardState createState() => _UniversalPostCardState();
}

class _UniversalPostCardState extends State<UniversalPostCard>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  bool isSaved = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    if (isLiked) {
      _animationController.forward().then((_) {
        _animationController.reverse();
      });
    }
    widget.onLike?.call();
  }

  void _handleSave() {
    setState(() {
      isSaved = !isSaved;
    });
    widget.onSave?.call();
  }

  void _handleDoubleTap() {
    if (!isLiked) {
      _handleLike();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: sh * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Header
          _buildHeader(sw, sh),

          //* Content Type Specific Info
          buildContentTypeInfo(sw, sh,context, widget.postData),

          //* Post Image
          buildPostImage(sw, sh, _handleDoubleTap, widget.postData),

          //* Action Buttons
          _buildActions(sw, sh),

          //* Like Stats
          buildLikes(sw, sh, widget.postData),

          //* Caption and Description
          buildContent(sw, sh, widget.postData, _getDisplayName()),

          //* Tags
          buildTags(sw, sh, widget.postData),

          //* Comment Stats
          buildCommentsShares(sw, sh, widget.postData),

          SizedBox(height: sh * 0.015),
        ],
      ),
    );
  }

  Widget _buildHeader(double sw, double sh) {
    final contentType = widget.postData['data']['contentType'];
    final location = _getLocationString();

    return Padding(
      padding: EdgeInsets.all(sw * 0.04),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onProfileTap,
            child: Container(
              padding: EdgeInsets.all(2),
              width: sw * 0.12,
              height: sw * 0.12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.appGradient1, AppColors.appGradient2],
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(Icons.person, color: Colors.grey.shade600),
                ),
              ),
            ),
          ),
          SizedBox(width: sw * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      _getDisplayName(),
                      style: TextStyle(
                        fontSize: sh * 0.018,
                        fontFamily: 'Poppins-SemiBold',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: sw * 0.02),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: sw * 0.02,
                        vertical: sh * 0.002,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.appGradient1,
                            AppColors.appGradient2
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        contentType.toUpperCase(),
                        style: TextStyle(
                          fontSize: sh * 0.01,
                          fontFamily: 'Poppins-Medium',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                if (location.isNotEmpty) ...[
                  SizedBox(height: sh * 0.002),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: sh * 0.014,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(width: sw * 0.01),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: sh * 0.014,
                          fontFamily: 'Poppins-Regular',
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          Icon(
            Icons.more_horiz,
            color: Colors.grey.shade700,
            size: sh * 0.025,
          ),
        ],
      ),
    );
  }

  Widget _buildActions(double sw, double sh) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: sw * 0.04,
        vertical: sh * 0.015,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _handleLike,
            child: AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: isLiked ? _scaleAnimation.value : 1.0,
                  child: SvgPicture.asset(
                    isLiked
                        ? 'assets/images/main/ic_heart.svg'
                        : 'assets/images/main/ic_empty_heart.svg',
                    height: sh * 0.028,
                    width: sh * 0.028,
                    color: isLiked ? Colors.red : Colors.black,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: sw * 0.05),
          GestureDetector(
            onTap: widget.onComment,
            child: SvgPicture.asset(
              'assets/images/main/ic_comment.svg',
              height: sh * 0.028,
              width: sh * 0.028,
              color: Colors.black,
            ),
          ),
          SizedBox(width: sw * 0.05),
          GestureDetector(
            onTap: widget.onShare,
            child: SvgPicture.asset(
              'assets/images/main/ic_share.svg',
              height: sh * 0.028,
              width: sh * 0.028,
              color: Colors.black,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: _handleSave,
            child: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? Colors.black : Colors.grey.shade700,
              size: sh * 0.03,
            ),
          ),
        ],
      ),
    );
  }

  String _getDisplayName() {
    final contentType = widget.postData['data']['contentType'];
    switch (contentType) {
      case 'business':
        return widget.postData['data']['customization']['business']
                ['businessName'] ??
            'Business';
      case 'service':
        return widget.postData['data']['customization']['service']['name'] ??
            'Service Provider';
      case 'product':
        return 'Product Store';
      default:
        return 'User';
    }
  }

  String _getLocationString() {
    final contentType = widget.postData['data']['contentType'];
    switch (contentType) {
      case 'business':
        final location =
            widget.postData['data']['customization']['business']['location'];
        return '${location['city']}, ${location['state']}';
      case 'service':
        final location =
            widget.postData['data']['customization']['service']['location'];
        return '${location['city']}, ${location['state']}';
      case 'product':
        final location =
            widget.postData['data']['customization']['product']['location'];
        return location['name'] ?? '';
      case 'normal':
        final location =
            widget.postData['data']['customization']['normal']['location'];
        return location['name'] ?? '';
      default:
        return '';
    }
  }
}
