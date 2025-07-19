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
  final TextEditingController descriptionController = TextEditingController();
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
  final TextEditingController deliverablesController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController maxBookingsController = TextEditingController();
  final TextEditingController advanceBookingController =
      TextEditingController();

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

  final PostService _postService = PostService();
  bool _isLoading = false;

  void _handleServicePost() async {
    if (!_validateServiceForm()) {
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

      List<Map<String, dynamic>> _buildScheduleArray() {
        List<Map<String, dynamic>> schedule = [];

        scheduleData.forEach((day, data) {
          if (!data['isClosed'] &&
              data['startTime'].isNotEmpty &&
              data['endTime'].isNotEmpty) {
            schedule.add({
              "day": day,
              "timeSlots": [
                {"startTime": data['startTime'], "endTime": data['endTime']}
              ]
            });
          }
        });

        return schedule;
      }

      Map<String, dynamic> serviceData = {
        "name": serviceNameController.text.trim(),
        "description": serviceDescriptionController.text.trim(),
        "price": double.tryParse(priceController.text.trim()) ?? 0,
        "currency": selectedCurrency,
        "category": selectedCategory,
        "subcategory": selectedSubCategory,
        "duration": int.tryParse(durationController.text.trim()) ?? 0,
        "serviceType": selectedServiceType,
        "availability": {
          "schedule": _buildScheduleArray(),
          "timezone": "Asia/Kolkata",
          "bookingAdvance": int.parse(advanceBookingController.text.trim()),
          "maxBookingsPerDay": int.parse(maxBookingsController.text.trim())
        },
        "location": {
          "type": "studio",
          "address": addressController.text.trim(),
          "city": placeController.text.trim(),
          "state": stateController.text.trim(),
          "country": countryController.text.trim(),
          "coordinates": {
            "type": "Point",
            "coordinates": [77.2193791, 28.6314022]
          }
        },
        "requirements": requirementsController.text.trim().isEmpty
            ? []
            : [requirementsController.text.trim()],
        "deliverables": deliverablesController.text.trim().isEmpty
            ? []
            : [deliverablesController.text.trim()],
        "tags": hashtags.isEmpty ? [] : hashtags,
        "link": linkController.text.trim()
      };

      Map<String, dynamic> settingsData = {
        "visibility": "public",
        "allowComments": true,
        "allowLikes": true,
      };

      Map<String, String> locationData = {
        "name": locationController.text.trim().isEmpty
            ? "Unknown Location"
            : locationController.text.trim()
      };

      List<String> mentions = [];

      final response = await _postService.createServicePost(
        media: mediaFile,
        postType: widget.isReel ? "reel" : "photo",
        caption: captionController.text.trim(),
        description: descriptionController.text.trim(),
        mentions: mentions,
        settings: settingsData,
        location: locationData,
        status: "published",
        service: serviceData,
      );

      Logger().d(serviceData);

      setState(() {
        _isLoading = false;
      });

      if (response.success) {
        showSnackBar(
            widget.isReel
                ? 'Service Reel created successfully!'
                : 'Service Post created successfully!',
            context,
            isError: false);
        Logger().d(response.data);
        _clearServiceForm();
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

  bool _validateServiceForm() {
    if (widget.isReel && selectedVideo == null) {
      showSnackBar('Please select a video', context, isError: true);
      return false;
    }

    if (!widget.isReel && selectedImage == null) {
      showSnackBar('Please select an image', context, isError: true);
      return false;
    }

    if (serviceNameController.text.trim().isEmpty) {
      showSnackBar('Please enter service name', context, isError: true);
      return false;
    }

    if (serviceDescriptionController.text.trim().isEmpty) {
      showSnackBar('Please enter service description', context, isError: true);
      return false;
    }

    if (priceController.text.trim().isEmpty) {
      showSnackBar('Please enter service price', context, isError: true);
      return false;
    }

    try {
      double price = double.parse(priceController.text.trim());
      if (price < 0) {
        showSnackBar('Price cannot be negative', context, isError: true);
        return false;
      }
    } catch (e) {
      showSnackBar('Please enter a valid price', context, isError: true);
      return false;
    }

    if (durationController.text.trim().isEmpty) {
      showSnackBar('Please enter service duration', context, isError: true);
      return false;
    }

    if (addressController.text.trim().isEmpty) {
      showSnackBar('Please enter address', context, isError: true);
      return false;
    }

    if (placeController.text.trim().isEmpty) {
      showSnackBar('Please enter place/city', context, isError: true);
      return false;
    }

    if (stateController.text.trim().isEmpty) {
      showSnackBar('Please enter state', context, isError: true);
      return false;
    }

    if (countryController.text.trim().isEmpty) {
      showSnackBar('Please enter country', context, isError: true);
      return false;
    }

    return true;
  }

  void _clearServiceForm() {
    setState(() {
      selectedImage = null;
      selectedVideo = null;
      captionController.clear();
      locationController.clear();
      serviceNameController.clear();
      serviceDescriptionController.clear();
      priceController.clear();
      addressController.clear();
      placeController.clear();
      stateController.clear();
      countryController.clear();
      durationController.clear();
      requirementsController.clear();
      deliverablesController.clear();
      hashtags.clear();
      selectedCurrency = 'INR';
      selectedCategory = 'Health & Wellness';
      selectedSubCategory = 'Fitness';
      selectedServiceType = 'in-person';
      selectedAvailability = 'Available';
      selectedPostCategory = 'Personal Life';
      scheduleData = {
        'Monday': {'isClosed': false, 'startTime': '', 'endTime': ''},
        'Tuesday': {'isClosed': false, 'startTime': '', 'endTime': ''},
        'Wednesday': {'isClosed': false, 'startTime': '', 'endTime': ''},
        'Thursday': {'isClosed': false, 'startTime': '', 'endTime': ''},
        'Friday': {'isClosed': false, 'startTime': '', 'endTime': ''},
        'Saturday': {'isClosed': false, 'startTime': '', 'endTime': ''},
        'Sunday': {'isClosed': true, 'startTime': '', 'endTime': ''},
      };
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
                ? VideoPickerWidget(
                    sw: sw,
                    sh: sh,
                    selectedVideo: selectedVideo,
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

            // Add Caption Section
            PostAddWidgets.buildDescriptionField(descriptionController, sw, sh),

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
            _isLoading
                ? Center(
                    child: SpinKitCircle(
                      color: AppColors.appGradient1,
                      size: 35,
                    ),
                  )
                : PostAddWidgets.buildCreateButton(sw, sh, _handleServicePost),

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
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Service Details',
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
                child: PostAddWidgets.buildCardDropdown(
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
          PostAddWidgets.buildCardDropdown(
              'Category',
              selectedCategory,
              [
                'Health & Wellness',
                'Education & Training',
                'Technology & IT',
                'Business & Finance',
                'Creative Services',
                'Home & Maintenance',
                'Beauty & Personal Care',
                'Transportation',
                'Entertainment',
                'Legal Services',
                'Other'
              ],
              sw,
              sh, (value) {
            setState(() {
              selectedCategory = value!;
            });
          }),

          // Sub Category (Full width)
          PostAddWidgets.buildCardDropdown(
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
                child: PostAddWidgets.buildCardDropdown(
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

          // Max Booking And Advance Booking
          _buildServiceFieldWithLabel('Maximum Bookings Per Day',
              maxBookingsController, 'Enter max bookings (e.g. 5)', sw, sh),

          _buildServiceFieldWithLabel(
              'Advance Booking Days',
              advanceBookingController,
              'Enter days in advance (e.g. 3)',
              sw,
              sh),

          // Availability
          PostAddWidgets.buildCardDropdown('Availability', selectedAvailability,
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
                  'Requirements',
                  requirementsController,
                  'Enter requirements for your services',
                  sw,
                  sh),
              SizedBox(
                height: sh * 0.005,
              ),
              _buildServiceFieldWithLabel(
                  'Deliverables',
                  deliverablesController,
                  'Enter deliverables for your services',
                  sw,
                  sh),
              SizedBox(
                height: sh * 0.005,
              ),
              _buildServiceFieldWithLabel('Service Link', linkController,
                  'Provide link to book your service', sw, sh),
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
