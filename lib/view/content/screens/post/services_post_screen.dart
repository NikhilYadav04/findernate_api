import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/view/content/widgets/hashtag_card.dart';
import 'package:social_media_clone/view/content/widgets/post-add_widgets.dart';
import 'package:social_media_clone/view/content/widgets/reel_add_widgets.dart';

// SERVICE POST SCREEN
class ServicePostScreen extends StatefulWidget {
  final String postType;
  final bool isReel;

  const ServicePostScreen({
    Key? key,
    required this.postType,
    this.isReel = false,
  }) : super(key: key);

  @override
  _ServicePostScreenState createState() => _ServicePostScreenState();
}

class _ServicePostScreenState extends State<ServicePostScreen> {
  File? selectedImage;
  File? selectedVideo;
  final ImagePicker _picker = ImagePicker();

  // Basic post form controllers
  final TextEditingController locationController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final TextEditingController mentionsController = TextEditingController();
  final TextEditingController settingsController = TextEditingController();

  // Service specific form controllers
  final TextEditingController serviceNameController = TextEditingController();
  final TextEditingController serviceDescriptionController =
      TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();

  // Dropdown values
  String selectedCurrency = 'INR';
  String selectedCategory = 'Health & Wellness';
  String selectedSubCategory = 'Fitness';
  String selectedServiceType = 'in-person';
  String selectedAvailability = 'Available';

  // Schedule data
  Map<String, Map<String, dynamic>> scheduleData = {
    'Monday': {'isClosed': false, 'startTime': '', 'endTime': ''},
    'Tuesday': {'isClosed': false, 'startTime': '', 'endTime': ''},
    'Wednesday': {'isClosed': false, 'startTime': '', 'endTime': ''},
    'Thursday': {'isClosed': false, 'startTime': '', 'endTime': ''},
    'Friday': {'isClosed': false, 'startTime': '', 'endTime': ''},
    'Saturday': {'isClosed': false, 'startTime': '', 'endTime': ''},
    'Sunday': {'isClosed': true, 'startTime': '', 'endTime': ''},
  };

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
          widget.isReel ? 'Add Service Reel' : 'Add Service Post',
          style: TextStyle(
            color: AppColors.black,
            fontSize: sw * 0.05,
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

            // Service Details Card
            _buildServiceDetailsCard(sw, sh),

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

            PostAddWidgets.buildPostCategorySection(
                selectedPostCategory, sw, sh, (String? newValue) {
              setState(() {
                selectedPostCategory = newValue!;
              });
            }),

            SizedBox(height: sh * 0.05),

            // Upload Button
            PostAddWidgets.buildCreateButton(sw, sh, () {}),

            SizedBox(height: sh * 0.03),
          ],
        ),
      ),
    );
  }

  // Service Details Card with Yellow Border and Shadow
  Widget _buildServiceDetailsCard(double sw, double sh) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
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
            'Service Details',
            style: TextStyle(
              fontSize: sh * 0.022,
              fontFamily: 'Poppins-Bold',
              fontWeight: FontWeight.bold,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: sh * 0.02),

          // Service Name
          _buildServiceFieldWithLabel('Service Name', serviceNameController,
              'Enter service name', sw, sh),

          // Service Description
          _buildServiceFieldWithLabel('Service Description',
              serviceDescriptionController, 'Enter service description', sw, sh,
              maxLines: 3),

          // Get currency icon based on selected currency

          // Price with Currency Prefix
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildServiceFieldWithIcon(
                    'Price', priceController, 'Enter price', sw, sh),
              ),
              SizedBox(width: sw * 0.04),
              Expanded(
                flex: 2,
                child: _buildServiceDropdown(
                    'Currency', selectedCurrency, ['INR', 'USD', 'EUR'], sw, sh,
                    (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                }),
              ),
            ],
          ),

          // Category (Full width)
          _buildServiceDropdown(
              'Category',
              selectedCategory,
              ['Health & Wellness', 'Education', 'Technology', 'Business'],
              sw,
              sh, (value) {
            setState(() {
              selectedCategory = value!;
            });
          }),

          // Sub Category (Full width)
          _buildServiceDropdown(
              'Sub Category',
              selectedSubCategory,
              ['Fitness', 'Nutrition', 'Mental Health', 'Yoga'],
              sw,
              sh, (value) {
            setState(() {
              selectedSubCategory = value!;
            });
          }),

          // Duration and Service Type Row
          Row(
            children: [
              Expanded(
                child: _buildServiceFieldWithLabel('Duration',
                    durationController, 'Enter duration in minutes', sw, sh),
              ),
              SizedBox(width: sw * 0.04),
              Expanded(
                child: _buildServiceDropdown(
                    'Service Type',
                    selectedServiceType,
                    ['in-person', 'online', 'hybrid'],
                    sw,
                    sh, (value) {
                  setState(() {
                    selectedServiceType = value!;
                  });
                }),
              ),
            ],
          ),

          // Availability
          _buildServiceDropdown('Availability', selectedAvailability,
              ['Available', 'Not Available', 'Limited'], sw, sh, (value) {
            setState(() {
              selectedAvailability = value!;
            });
          }),

          // Schedule Section
          _buildScheduleSection(sw, sh),

          // Location Details
          Text(
            'Location Details',
            style: TextStyle(
              fontSize: sh * 0.02,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: sh * 0.015),

          // Address
          _buildServiceFieldWithLabel(
              'Address', addressController, 'Enter address', sw, sh),

          // Place, State, Country Row
          Column(
            children: [
              _buildServiceFieldWithLabel(
                  'Place/City', placeController, 'Enter city', sw, sh),
              SizedBox(
                height: sh * 0.005,
              ),
              _buildServiceFieldWithLabel(
                  'State', stateController, 'Enter state', sw, sh),
              SizedBox(
                height: sh * 0.005,
              ),
              _buildServiceFieldWithLabel(
                  'Country', countryController, 'Enter country', sw, sh),
              SizedBox(
                height: sh * 0.005,
              ),
              _buildServiceFieldWithLabel(
                  'Requirements', requirementsController, 'Enter requirements for your services', sw, sh),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getCurrencyIcon() {
    switch (selectedCurrency) {
      case 'INR':
        return Icon(Icons.currency_rupee, color: Colors.grey.shade700);
      case 'USD':
        return Icon(Icons.attach_money, color: Colors.grey.shade700);
      case 'EUR':
        return Icon(Icons.euro, color: Colors.grey.shade700);
      default:
        return Icon(Icons.currency_exchange, color: Colors.grey.shade700);
    }
  }

  // Service Field Builder with Icon (for price field)
  Widget _buildServiceFieldWithIcon(String label,
      TextEditingController controller, String hint, double sw, double sh,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PostAddWidgets.buildTextField(controller, hint, sw, sh,
            maxLines: maxLines, label: label, prefixIcon: _getCurrencyIcon()),
        SizedBox(height: sh * 0.015),
      ],
    );
  }

  // Service Field Builder with Label (for regular fields)
  Widget _buildServiceFieldWithLabel(String label,
      TextEditingController controller, String hint, double sw, double sh,
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

  // Service Dropdown Builder
  Widget _buildServiceDropdown(String label, String value, List<String> items,
      double sw, double sh, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: sh * 0.065,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.keyboard_arrow_down,
                    color: AppColors.black, size: sh * 0.025),
              ),
              style: TextStyle(
                color: AppColors.black,
                fontSize: sh * 0.02,
                fontFamily: 'Poppins-Light',
              ),
              hint: Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: sh * 0.02,
                  fontFamily: 'Poppins-Medium',
                ),
              ),
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                    child: Text(item),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(height: sh * 0.015),
      ],
    );
  }

  // Schedule Section
  Widget _buildScheduleSection(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schedule',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.015),
        Container(
          padding: EdgeInsets.all(sw * 0.04),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: Column(
            children: scheduleData.entries.map((entry) {
              return Container(
                margin: EdgeInsets.only(bottom: sh * 0.01),
                padding: EdgeInsets.all(sw * 0.03),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.yellowAccent, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: sh * 0.018,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Closed',
                              style: TextStyle(
                                fontSize: sh * 0.016,
                                fontFamily: 'Poppins-Light',
                                color: AppColors.black,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: Switch(
                                value: entry.value['isClosed'],
                                onChanged: (value) {
                                  setState(() {
                                    scheduleData[entry.key]!['isClosed'] =
                                        value;
                                  });
                                },
                                activeColor: AppColors.yellowAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (!entry.value['isClosed']) ...[
                      SizedBox(height: sh * 0.01),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Start Time',
                                labelStyle: TextStyle(
                                  fontSize: sh * 0.015,
                                  fontFamily: 'Poppins-Light',
                                ),
                                hintText: 'HH:MM',
                                hintStyle: TextStyle(
                                  fontSize: sh * 0.015,
                                  fontFamily: 'Poppins-Light',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade500, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.yellowAccent, width: 2),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: sw * 0.02, vertical: sh * 0.01),
                              ),
                              style: TextStyle(
                                fontSize: sh * 0.015,
                                fontFamily: 'Poppins-Light',
                              ),
                              onChanged: (value) {
                                scheduleData[entry.key]!['startTime'] = value;
                              },
                            ),
                          ),
                          SizedBox(width: sw * 0.02),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'End Time',
                                labelStyle: TextStyle(
                                  fontSize: sh * 0.015,
                                  fontFamily: 'Poppins-Light',
                                ),
                                hintText: 'HH:MM',
                                hintStyle: TextStyle(
                                  fontSize: sh * 0.015,
                                  fontFamily: 'Poppins-Light',
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade500, width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: AppColors.yellowAccent, width: 2),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: sw * 0.02, vertical: sh * 0.01),
                              ),
                              style: TextStyle(
                                fontSize: sh * 0.015,
                                fontFamily: 'Poppins-Light',
                              ),
                              onChanged: (value) {
                                scheduleData[entry.key]!['endTime'] = value;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(height: sh * 0.02),
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
