import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'dart:io';

import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/http/services/post_services.dart';
import 'package:social_media_clone/view/content/widgets/add/hashtag_card.dart';
import 'package:social_media_clone/view/content/widgets/add/post-add_widgets.dart';
import 'package:social_media_clone/view/content/widgets/add/reel_add_widgets.dart';

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

  bool _isLoading = false;

  // Basic post form controllers
  final TextEditingController locationController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Business specific form controllers
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController announcementController = TextEditingController();

  // Promotions form controllers
  final TextEditingController promotionTitleController =
      TextEditingController();
  final TextEditingController promotionDescriptionController =
      TextEditingController();
  final TextEditingController promotionDiscountController =
      TextEditingController();
  final TextEditingController promotionValidUntilController =
      TextEditingController();
  bool isPromotionActive = true;

  // Hashtags and category
  List<String> hashtags = [];
  String selectedPostCategory = 'Personal Life';
  final TextEditingController hashtagController = TextEditingController();

  //* API Calling
  final PostService _postService = PostService();

  void _handleBusinessPost() async {
    if (!_validateBusinessForm()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      File? mediaFile = widget.isReel ? selectedVideo : selectedImage;

      if (mediaFile == null) {
        showSnackBar(
            'Please select ${widget.isReel ? 'a video' : 'an image'}', context,
            isError: true);
        setState(() {
          _isLoading = false;
        });
        return;
      }

      Map<String, String> locationData = {
        "name": locationController.text.trim().isEmpty
            ? "Unknown Location"
            : locationController.text.trim()
      };

      Map<String, dynamic> businessData = {
        "businessName": businessNameController.text.trim().isEmpty
            ? "Unknown Business"
            : businessNameController.text.trim(),
        "businessType": "",
        "description": "",
        "category": "",
        "contact": {
          "phone": "+91-9876543210",
          "email": "info@urbancafe.com",
          "website": "https://urbancafe.com",
          "socialMedia": [
            {
              "platform": "Findernate",
              "url": "https://findernate.com/urbancafe"
            }
          ]
        },
        "location": {
          "address": "",
          "place": "",
          "city": "",
          "state": "",
          "country": "",
          "postalCode": ""
        },
        "hours": [
          {
            "day": "Monday",
            "openTime": "08:00",
            "closeTime": "22:00",
            "isClosed": false
          },
          {
            "day": "Tuesday",
            "openTime": "08:00",
            "closeTime": "22:00",
            "isClosed": false
          },
          {
            "day": "Wednesday",
            "openTime": "08:00",
            "closeTime": "22:00",
            "isClosed": false
          },
          {
            "day": "Thursday",
            "openTime": "08:00",
            "closeTime": "22:00",
            "isClosed": false
          },
          {
            "day": "Friday",
            "openTime": "08:00",
            "closeTime": "23:00",
            "isClosed": false
          },
          {
            "day": "Saturday",
            "openTime": "09:00",
            "closeTime": "23:00",
            "isClosed": false
          },
          {
            "day": "Sunday",
            "openTime": "09:00",
            "closeTime": "21:00",
            "isClosed": false
          }
        ],
        "features": [],
        "priceRange": "",
        "rating": 4.5,
        "tags": hashtags,
        "announcement": announcementController.text.trim(),
        "promotions": [
          {
            "title": promotionTitleController.text.trim(),
            "description": promotionDescriptionController.text.trim(),
            "discount": promotionDiscountController.text.trim().isEmpty
                ? "0"
                : double.parse(promotionDiscountController.text.trim()),
            "validUntil": promotionValidUntilController.text.trim(),
            "isActive": isPromotionActive
          }
        ]
      };

      Map<String, dynamic> settingsData = {
        "visibility": "public",
        "allowComments": true,
        "allowLikes": true,
        "allowShares": true,
      };

      List<String> mentions = [];

      final response = await _postService.createBusinessPost(
        media: mediaFile,
        postType: widget.isReel ? "reel" : "photo",
        caption: captionController.text.isEmpty
            ? ""
            : captionController.text.toString(),
        description: descriptionController.text.isEmpty
            ? ""
            : descriptionController.text.toString(),
        mentions: mentions,
        business: businessData,
        settings: settingsData,
        status: "published",
      );

      setState(() {
        _isLoading = false;
      });

      if (response.success) {
        showSnackBar(
            widget.isReel
                ? 'Business Reel created successfully!'
                : 'BusinessPost created successfully!',
            context,
            isError: false);
        Logger().d(response.data);
        _clearBusinessForm();
        Navigator.pop(context);
      } else {
        showSnackBar(response.message, context, isError: true);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackBar('An error occurred: ${e.toString()}', context,
          isError: true);
    }
  }

  bool _validateBusinessForm() {
    if (widget.isReel && selectedVideo == null) {
      showSnackBar('Please select a video', context, isError: true);
      return false;
    }

    if (!widget.isReel && selectedImage == null) {
      showSnackBar('Please select an image', context, isError: true);
      return false;
    }

    if (businessNameController.text.trim().isEmpty) {
      showSnackBar('Please enter business name', context, isError: true);
      return false;
    }

    if (promotionTitleController.text.trim().isNotEmpty) {
      if (promotionDescriptionController.text.trim().isEmpty) {
        showSnackBar('Please add promotion description', context,
            isError: true);
        return false;
      }

      if (promotionDiscountController.text.trim().isEmpty) {
        showSnackBar('Please add discount percentage', context, isError: true);
        return false;
      }

      try {
        double discount = double.parse(promotionDiscountController.text.trim());
        if (discount < 0 || discount > 100) {
          showSnackBar('Discount must be between 0 and 100', context,
              isError: true);
          return false;
        }
      } catch (e) {
        showSnackBar('Please enter a valid discount percentage', context,
            isError: true);
        return false;
      }
    }

    return true;
  }

  void _clearBusinessForm() {
    setState(() {
      selectedImage = null;
      selectedVideo = null;
      captionController.clear();
      descriptionController.clear();
      locationController.clear();
      businessNameController.clear();
      announcementController.clear();
      promotionTitleController.clear();
      promotionDescriptionController.clear();
      promotionDiscountController.clear();
      promotionValidUntilController.clear();
      hashtags.clear();
      selectedPostCategory = 'Personal Life';
      isPromotionActive = true;
    });
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
                ? VideoPickerWidget(
                    sw: sw,
                    sh: sh,
                    selectedVideo: selectedImage,
                    onTap: _pickVideo)
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
            _isLoading
                ? Center(
                    child: SpinKitCircle(
                      color: AppColors.appGradient1,
                      size: 35,
                    ),
                  )
                : PostAddWidgets.buildCreateButton(sw, sh, () {
                    Logger().d("Promotion Data:");
                    Logger()
                        .d("  Title: ${promotionTitleController.text.trim()}");
                    print(
                        "  Description: ${promotionDescriptionController.text.trim()}");
                    print(
                        "  Discount: ${promotionDiscountController.text.trim().isEmpty ? "0" : double.parse(promotionDiscountController.text.trim())}");
                    Logger().d(
                        "  Valid Until: ${promotionValidUntilController.text.trim()}");
                    Logger().d("  Is Active: $isPromotionActive");
                  }),

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
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Business Details',
                  style: TextStyle(
                    fontSize: sh * 0.022,
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                TextSpan(
                  text: ' *',
                  style: TextStyle(
                    fontSize: sh * 0.022,
                    fontFamily: 'Poppins-Bold',
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: sh * 0.02),

          // Business Name
          _buildBusinessField('Business Name', businessNameController,
              'Enter business name', sw, sh),

          // Announcement Field (Different styling)
          _buildAnnouncementField(sw, sh),

          // Promotions Field (Similar to announcement but different styling)
          _buildPromotionsField(sw, sh),
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

  Widget _buildPromotionsField(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Promotions',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Bold',
            fontWeight: FontWeight.bold,
            color: AppColors.appGradient2,
          ),
        ),
        SizedBox(height: sh * 0.012),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              colors: [
                AppColors.appGradient2.withOpacity(0.1),
                AppColors.appGradient1.withOpacity(0.1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: AppColors.appGradient2, width: 2),
          ),
          padding: EdgeInsets.all(sw * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              _buildPromotionInputField(
                'Title',
                promotionTitleController,
                'Enter promotion title',
                sw,
                sh,
                maxLines: 1,
              ),

              // Description Field
              _buildPromotionInputField(
                'Description',
                promotionDescriptionController,
                'Enter promotion description',
                sw,
                sh,
                maxLines: 3,
              ),

              // Discount and IsActive in Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Discount Field
                  Expanded(
                    flex: 1,
                    child: _buildPromotionInputField(
                      'Discount (%)',
                      promotionDiscountController,
                      'Enter discount',
                      sw,
                      sh,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  SizedBox(width: sw * 0.03),

                  // IsActive Dropdown
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Is Active',
                          style: TextStyle(
                            fontSize: sh * 0.018,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(height: sh * 0.008),
                        Container(
                          height:
                              sh * 0.055, // Fixed height to match text field
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: AppColors.appGradient2.withOpacity(0.5),
                              width: 1,
                            ),
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<bool>(
                              value: isPromotionActive,
                              isExpanded: true,
                              items: [
                                DropdownMenuItem(
                                  value: true,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sw * 0.02),
                                    child: Text(
                                      'Active',
                                      style: TextStyle(
                                        fontSize: sh * 0.016,
                                        fontFamily: 'Poppins-Medium',
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: false,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sw * 0.02),
                                    child: Text(
                                      'Inactive',
                                      style: TextStyle(
                                        fontSize: sh * 0.016,
                                        fontFamily: 'Poppins-Medium',
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (bool? newValue) {
                                setState(() {
                                  isPromotionActive = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                            height: sh *
                                0.015), // Added bottom spacing to match text field
                      ],
                    ),
                  ),
                ],
              ),

              // Valid Until Field
              _buildPromotionInputField(
                'Valid Until',
                promotionValidUntilController,
                'Select expiry date',
                sw,
                sh,
                maxLines: 1,
                isDateField: true,
              ),
            ],
          ),
        ),
        SizedBox(height: sh * 0.015),
      ],
    );
  }

  //* Helper method to build promotion input fields
  Widget _buildPromotionInputField(
    String label,
    TextEditingController controller,
    String hint,
    double sw,
    double sh, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    bool isDateField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: sh * 0.018,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.008),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.appGradient2.withOpacity(0.5),
              width: 1,
            ),
            color: Colors.white,
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            readOnly: isDateField,
            onTap: isDateField ? () => _selectDate(controller) : null,
            style: TextStyle(
              fontSize: sh * 0.016,
              fontFamily: 'Poppins-Medium',
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColors.appGradient2.withOpacity(0.6),
                fontSize: sh * 0.016,
                fontFamily: 'Poppins-Light',
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: sw * 0.03,
                vertical: sh * 0.012,
              ),
              suffixIcon: isDateField
                  ? Icon(
                      Icons.calendar_today,
                      color: AppColors.appGradient2,
                      size: sh * 0.02,
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(height: sh * 0.015),
      ],
    );
  }

  // Date picker functionality
  void _selectDate(TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.appGradient2,
              onPrimary: Colors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      controller.text = "${picked.day}/${picked.month}/${picked.year}";
    }
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
