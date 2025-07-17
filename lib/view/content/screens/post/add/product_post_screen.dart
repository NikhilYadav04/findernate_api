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

// PRODUCT POST SCREEN
class ProductPostScreen extends StatefulWidget {
  final String postType;
  final bool isReel;

  const ProductPostScreen({
    Key? key,
    required this.postType,
    this.isReel = false,
  }) : super(key: key);

  @override
  _ProductPostScreenState createState() => _ProductPostScreenState();
}

class _ProductPostScreenState extends State<ProductPostScreen> {
  File? selectedImage;
  File? selectedVideo;
  final ImagePicker _picker = ImagePicker();

  // Basic post form controllers
  final TextEditingController locationController = TextEditingController();
  final TextEditingController captionController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Product specific form controllers
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  // Dropdown values
  String selectedCurrency = 'INR';
  bool isInStock = true;

  // Mood and Activity dropdowns
  String selectedMood = 'Excited';
  String selectedActivity = 'Relaxing';

  // Hashtags and category
  List<String> hashtags = [];
  String selectedPostCategory = 'Personal Life';
  final TextEditingController hashtagController = TextEditingController();

  //* handle product post API Call
  final PostService _postService = PostService();
  bool _isLoading = false;

  void _handleProductPost() async {
    if (!_validateProductForm()) {
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

      Map<String, dynamic> productData = {
        "name": productNameController.text.trim(),
        "price": priceController.text.trim(),
        "currency": selectedCurrency,
        "inStock": isInStock,
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

      final response = await _postService.createProductPost(
        media: mediaFile,
        postType: widget.isReel ? "reel" : "photo",
        caption: captionController.text.trim(),
        description: descriptionController.text.trim(),
        mentions: mentions,
        mood: selectedMood,
        activity: selectedActivity,
        tags: hashtags,
        settings: settingsData,
        location: locationData,
        product: productData,
        status: "published",
      );

      setState(() {
        _isLoading = false;
      });

      if (response.success) {
        showSnackBar(
            widget.isReel
                ? 'Product Reel created successfully!'
                : 'Product Post created successfully!',
            context,
            isError: false);
        _clearProductForm();
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

  bool _validateProductForm() {
    if (widget.isReel && selectedVideo == null) {
      showSnackBar('Please select a video', context, isError: true);
      return false;
    }

    if (!widget.isReel && selectedImage == null) {
      showSnackBar('Please select an image', context, isError: true);
      return false;
    }

    if (productNameController.text.trim().isEmpty) {
      showSnackBar('Please enter product name', context, isError: true);
      return false;
    }

    if (priceController.text.trim().isEmpty) {
      showSnackBar('Please enter product price', context, isError: true);
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

    return true;
  }

  void _clearProductForm() {
    setState(() {
      selectedImage = null;
      selectedVideo = null;
      captionController.clear();
      descriptionController.clear();
      locationController.clear();
      productNameController.clear();
      priceController.clear();
      hashtags.clear();
      selectedCurrency = 'INR';
      isInStock = true;
      selectedMood = 'Excited';
      selectedActivity = 'Promotion';
      selectedPostCategory = 'Personal Life';
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
          widget.isReel ? 'Add Product Reel' : 'Add Product Post',
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

            // Product Details Card
            _buildProductDetailsCard(sw, sh),

            SizedBox(height: sh * 0.03),

            // Mood and Activity Section
            _buildMoodActivitySection(sw, sh),

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
            _isLoading
                ? Center(
                    child: SpinKitCircle(
                      color: AppColors.appGradient1,
                      size: 35,
                    ),
                  )
                : PostAddWidgets.buildCreateButton(sw, sh, () {
                    Logger().d(hashtags);
                  }),

            SizedBox(height: sh * 0.03),
          ],
        ),
      ),
    );
  }

  // Product Details Card with Yellow Border and Shadow
  Widget _buildProductDetailsCard(double sw, double sh) {
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
                  text: 'Product Details',
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

          // Product Name
          _buildProductField('Product Name', productNameController,
              'Enter product name', sw, sh),

          // Price and Currency Row
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildProductFieldWithIcon(
                    'Price', priceController, 'Enter price', sw, sh),
              ),
              SizedBox(width: sw * 0.04),
              Expanded(
                flex: 2,
                child: _buildProductDropdown(
                    'Currency', selectedCurrency, ['INR', 'USD', 'EUR'], sw, sh,
                    (value) {
                  setState(() {
                    selectedCurrency = value!;
                  });
                }),
              ),
            ],
          ),

          // In Stock Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'In Stock',
                style: TextStyle(
                  fontSize: sh * 0.018,
                  fontFamily: 'Poppins-Medium',
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: isInStock,
                  onChanged: (value) {
                    setState(() {
                      isInStock = value;
                    });
                  },
                  activeColor: AppColors.yellowAccent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Mood and Activity Section
  Widget _buildMoodActivitySection(double sw, double sh) {
    return Row(
      children: [
        Expanded(
          child: PostAddWidgets.buildDropdown(
              'Mood',
              selectedMood,
              [
                'Happy',
                'Excited',
                'Grateful',
                'Motivated',
                'Relaxed',
                'Confident',
                'Inspired',
                'Peaceful',
                'Energetic',
                'Content'
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
                'Traveling',
                'Working',
                'Relaxing',
                'Exercising',
                'Cooking',
                'Reading',
                'Shopping',
                'Studying',
                'Socializing',
                'Creating'
              ],
              sw,
              sh, (value) {
            setState(() {
              selectedActivity = value!;
            });
          }),
        ),
      ],
    );
  }

  // Get currency icon based on selected currency
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

  // Product Field Builder with Icon (for price field)
  Widget _buildProductFieldWithIcon(String label,
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

  // Product Field Builder
  Widget _buildProductField(String label, TextEditingController controller,
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

  // Product Dropdown Builder
  Widget _buildProductDropdown(String label, String value, List<String> items,
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
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.keyboard_arrow_down,
                    color: AppColors.black, size: sh * 0.025),
              ),
              style: TextStyle(
                color: AppColors.black,
                fontSize: sh * 0.018,
                fontFamily: 'Poppins-Light',
              ),
              hint: Text(
                label,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: sh * 0.018,
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
