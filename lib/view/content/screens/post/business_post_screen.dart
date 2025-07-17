import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/view/content/widgets/hashtag_card.dart';
import 'package:social_media_clone/view/content/widgets/post-add_widgets.dart';
import 'package:social_media_clone/view/content/widgets/reel_add_widgets.dart';

// BUSINESS POST SCREEN
class BusinessPostScreen extends StatefulWidget {
  final String postType;
  final bool isReel; 

  const BusinessPostScreen({
    Key? key,
    required this.postType,
    this.isReel = false,
  }) : super(key: key);

  @override
  _BusinessPostScreenState createState() => _BusinessPostScreenState();
}

class _BusinessPostScreenState extends State<BusinessPostScreen> {
  File? selectedImage;
  File? selectedVideo;
  final ImagePicker _picker = ImagePicker();

  // Basic post form controllers
  final TextEditingController locationController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Business specific form controllers
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController announcementController = TextEditingController();

  // Hashtags and category
  List<String> hashtags = [];
  String selectedPostCategory = 'Personal Life';
  final TextEditingController hashtagController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
          widget.isReel ? 'Add Business Reel' : 'Add Business Post',
          style: TextStyle(
            color: AppColors.black,
            fontSize: sh * 0.025,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(sw * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Select Image(s) Section
            widget.isReel
                ? buildVideoPicker(sw, sh, selectedImage, _pickVideo)
                : PostAddWidgets.buildImagePicker(
                    sw, sh, selectedImage, _pickImage),

            SizedBox(height: sh * 0.03),

            // Add Location Section
            PostAddWidgets.buildLocationField(locationController, sw, sh),

            SizedBox(height: sh * 0.03),

            // Add Caption Section
            PostAddWidgets.buildCaptionField(captionController, sw, sh),

            SizedBox(height: sh * 0.03),

            // Add Description Section
            PostAddWidgets.buildDescriptionField(descriptionController, sw, sh),

            SizedBox(height: sh * 0.03),

            // Business Details Card
            _buildBusinessDetailsCard(sw, sh),

            SizedBox(height: sh * 0.03),

            // Add hashtags Section
            HashtagInputWidget(
              initialHashtags: hashtags,
              onHashtagsChanged: (updatedHashtags) {
                setState(() {
                  hashtags = updatedHashtags;
                });
              },
            ),

            SizedBox(height: sh * 0.03),

            // Select Post Category Section
            PostAddWidgets.buildPostCategorySection(
                selectedPostCategory, sw, sh, (String? newValue) {
              setState(() {
                selectedPostCategory = newValue!;
              });
            }),

            SizedBox(height: sh * 0.05),

            // Create Button
            PostAddWidgets.buildCreateButton(sw, sh, () {}),

            SizedBox(height: sh * 0.03),
          ],
        ),
      ),
    );
  }

  // Business Details Card with Yellow Border and Shadow
  Widget _buildBusinessDetailsCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.yellowAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellowAccent.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(sw * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business Details',
            style: TextStyle(
              fontSize: sh * 0.022,
              fontFamily: 'Poppins-Bold',
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: sh * 0.02),

          // Business Name
          _buildBusinessField('Business Name', businessNameController,
              'Enter business name', sw, sh),

          // Announcement Field (Different styling)
          _buildAnnouncementField(sw, sh),
        ],
      ),
    );
  }

  // Business Field Builder
  Widget _buildBusinessField(String label, TextEditingController controller,
      String hint, double sw, double sh,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostAddWidgets.buildTextField(controller, hint, sw, sh,
            maxLines: maxLines, label: label),
        SizedBox(height: sh * 0.015),
      ],
    );
  }

  // Special Announcement Field with Different Styling
  Widget _buildAnnouncementField(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Announcement',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Bold',
            fontWeight: FontWeight.bold,
            color: AppColors.appGradient1,
          ),
        ),
        SizedBox(height: sh * 0.012),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                AppColors.appGradient1.withOpacity(0.1),
                AppColors.appGradient2.withOpacity(0.1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: AppColors.appGradient1, width: 2),
          ),
          child: TextField(
            controller: announcementController,
            maxLines: 4,
            style: TextStyle(
              fontSize: sh * 0.018,
              fontFamily: 'Poppins-Medium',
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              hintText: 'Write your business announcement...',
              hintStyle: TextStyle(
                color: AppColors.appGradient1.withOpacity(0.7),
                fontSize: sh * 0.018,
                fontFamily: 'Poppins-Light',
                fontStyle: FontStyle.italic,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.all(sw * 0.04),
            ),
          ),
        ),
        SizedBox(height: sh * 0.015),
      ],
    );
  }

  // Image picker functionality
  void _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  //* Video Picker Functionality
  void _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      setState(() {
        selectedVideo = File(video.path);
      });
    }
  }
}
