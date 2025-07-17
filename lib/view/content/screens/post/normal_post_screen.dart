import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/view/content/widgets/hashtag_card.dart';
import 'package:social_media_clone/view/content/widgets/post-add_widgets.dart';
import 'package:social_media_clone/view/content/widgets/reel_add_widgets.dart';

// NORMAL POST SCREEN
class NormalPostScreen extends StatefulWidget {
  final String postType;
  final bool isReel;

  const NormalPostScreen({
    Key? key,
    required this.postType,
    this.isReel = false,
  }) : super(key: key);

  @override
  _NormalPostScreenState createState() => _NormalPostScreenState();
}

class _NormalPostScreenState extends State<NormalPostScreen> {
  File? selectedImage;
  File? selectedVideo;
  final ImagePicker _picker = ImagePicker();

  // Normal post form controllers - Updated fields
  final TextEditingController captionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  // Dropdown values for mood and activity
  String selectedMood = 'Happy';
  String selectedActivity = 'Relaxing';

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
          widget.isReel ? 'Add Reel' : 'Add Post',
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

            // Normal Post Details Card
            _buildNormalPostDetailsCard(sw, sh),

            SizedBox(height: sh * 0.03),

            // Add hashtags Section
            HashtagInputWidget(
              initialHashtags: hashtags,
              onHashtagsChanged: (updatedHashtags) {
                setState(() {
                  hashtags = updatedHashtags;
                });
              },
              allowDuplicates: true,
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

  // Normal Post Details Card with Yellow Border and Shadow
  Widget _buildNormalPostDetailsCard(double sw, double sh) {
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
            'Normal Post Details',
            style: TextStyle(
              fontSize: sh * 0.022,
              fontFamily: 'Poppins-Bold',
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: sh * 0.02),

          // Mood and Activity Row
          Row(
            children: [
              Expanded(
                child: PostAddWidgets.buildDropdown(
                    'Mood',
                    selectedMood,
                    [
                      'Happy',
                      'Excited',
                      'Relaxed',
                      'Grateful',
                      'Motivated',
                      'Peaceful',
                      'Energetic',
                      'Content',
                      'Inspired',
                      'Joyful'
                    ],
                    sw,
                    sh, (value) {
                  setState(() {
                    selectedMood = value!;
                  });
                }),
              ),
              SizedBox(width: sw * 0.04),
              Expanded(
                child: PostAddWidgets.buildDropdown(
                    'Activity',
                    selectedActivity,
                    [
                      'Relaxing',
                      'Working',
                      'Traveling',
                      'Exercising',
                      'Cooking',
                      'Reading',
                      'Shopping',
                      'Studying',
                      'Socializing',
                      'Gaming'
                    ],
                    sw,
                    sh, (value) {
                  setState(() {
                    selectedActivity = value!;
                  });
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Add hashtags Section
  Widget _buildHashtagsSection(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add hashtags',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.015),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(sw * 0.04),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: hashtagController,
                      decoration: InputDecoration(
                        labelText: 'Add hashtag',
                        labelStyle: TextStyle(
                          fontSize: sh * 0.018,
                          fontFamily: 'Poppins-Medium',
                        ),
                        hintText: 'Enter hashtag (without #)',
                        hintStyle: TextStyle(
                          fontSize: sh * 0.016,
                          fontFamily: 'Poppins-Light',
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.grey.shade500, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              color: AppColors.yellowAccent, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: sw * 0.03, vertical: sh * 0.015),
                      ),
                      style: TextStyle(
                        fontSize: sh * 0.018,
                        fontFamily: 'Poppins-Light',
                      ),
                      onSubmitted: (value) {
                        if (value.isNotEmpty && !hashtags.contains(value)) {
                          setState(() {
                            hashtags.add(value);
                            hashtagController.clear();
                          });
                        }
                      },
                    ),
                  ),
                  SizedBox(width: sw * 0.02),
                  ElevatedButton(
                    onPressed: () {
                      String hashtag = hashtagController.text.trim();
                      if (hashtag.isNotEmpty && !hashtags.contains(hashtag)) {
                        setState(() {
                          hashtags.add(hashtag);
                          hashtagController.clear();
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellowAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: sh * 0.018,
                        fontFamily: 'Poppins-Medium',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: sh * 0.015),
              if (hashtags.isNotEmpty) ...[
                Text(
                  'Added Hashtags:',
                  style: TextStyle(
                    fontSize: sh * 0.018,
                    fontFamily: 'Poppins-Medium',
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: sh * 0.01),
                Wrap(
                  spacing: sw * 0.02,
                  runSpacing: sh * 0.01,
                  children: hashtags
                      .map((hashtag) => _buildHashtagChip(hashtag, sw, sh))
                      .toList(),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // Hashtag Chip
  Widget _buildHashtagChip(String hashtag, double sw, double sh) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: sw * 0.03, vertical: sh * 0.008),
      decoration: BoxDecoration(
        color: AppColors.orangeAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '#$hashtag',
            style: TextStyle(
              color: AppColors.white,
              fontSize: sh * 0.02,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: sw * 0.015),
          GestureDetector(
            onTap: () {
              setState(() {
                hashtags.remove(hashtag);
              });
            },
            child: Container(
              width: sw * 0.04,
              height: sw * 0.04,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: AppColors.orangeAccent,
                size: sh * 0.015,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //* Image picker functionality
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
