import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:social_media_clone/core/constants/appColors.dart';

// PRODUCT POST SCREEN
class ProductPostScreen extends StatefulWidget {
  @override
  _ProductPostScreenState createState() => _ProductPostScreenState();
}

class _ProductPostScreenState extends State<ProductPostScreen> {
  File? selectedImage;
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
  String selectedActivity = 'Promotion';

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
          'Add Product Post',
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
            _buildImageSection(sw, sh),

            SizedBox(height: sh * 0.03),

            // Add Location Section
            _buildLocationSection(sw, sh),

            SizedBox(height: sh * 0.03),

            // Add Caption Section
            _buildCaptionSection(sw, sh),

            SizedBox(height: sh * 0.03),

            // Add Description Section
            _buildDescriptionSection(sw, sh),

            SizedBox(height: sh * 0.03),

            // Product Details Card
            _buildProductDetailsCard(sw, sh),

            SizedBox(height: sh * 0.03),

            // Mood and Activity Section
            _buildMoodActivitySection(sw, sh),

            SizedBox(height: sh * 0.03),

            // Add hashtags Section
            _buildHashtagsSection(sw, sh),

            SizedBox(height: sh * 0.03),

            // Select Post Category Section
            _buildCategorySection(sw, sh),

            SizedBox(height: sh * 0.05),

            // Create Button
            _buildCreateButton(sw, sh),

            SizedBox(height: sh * 0.03),
          ],
        ),
      ),
    );
  }

  // Select Image(s) Section
  Widget _buildImageSection(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Image(s)',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.015),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: double.infinity,
            height: sh * 0.25,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.appGradient1, width: 2),
            ),
            child: selectedImage == null
                ? Center(
                    child: Container(
                      width: sw * 0.15,
                      height: sw * 0.15,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        border:
                            Border.all(color: AppColors.appGradient1, width: 2),
                      ),
                      child: Icon(
                        Icons.add,
                        color: AppColors.appGradient1,
                        size: sw * 0.08,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(selectedImage!, fit: BoxFit.cover),
                  ),
          ),
        ),
      ],
    );
  }

  // Add Location Section
  Widget _buildLocationSection(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Location',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.015),
        _buildTextField(locationController, 'Enter location...', sw, sh,
            label: 'Location'),
      ],
    );
  }

  // Add Caption Section
  Widget _buildCaptionSection(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Caption',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.015),
        _buildTextField(captionController, 'Write your caption...', sw, sh,
            maxLines: 3, label: 'Caption'),
      ],
    );
  }

  // Add Description Section
  Widget _buildDescriptionSection(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Description',
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.015),
        _buildTextField(
            descriptionController, 'Write your description...', sw, sh,
            maxLines: 3, label: 'Description'),
      ],
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
          Text(
            'Product Details',
            style: TextStyle(
              fontSize: sh * 0.022,
              fontFamily: 'Poppins-Bold',
              fontWeight: FontWeight.bold,
              color: AppColors.black,
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
          child: _buildDropdownField(
              'Mood',
              selectedMood,
              [
                'Excited',
                'Proud',
                'Confident',
                'Enthusiastic',
                'Motivated',
                'Happy',
                'Grateful',
                'Satisfied',
                'Energetic',
                'Optimistic'
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
          child: _buildDropdownField(
              'Activity',
              selectedActivity,
              [
                'Promotion',
                'Marketing',
                'Selling',
                'Advertising',
                'Launching',
                'Showcasing',
                'Announcing',
                'Introducing',
                'Presenting',
                'Offering'
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
        _buildTextField(controller, hint, sw, sh,
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
        _buildTextField(controller, hint, sw, sh,
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

  // Dropdown Field Builder
  Widget _buildDropdownField(String label, String value, List<String> items,
      double sw, double sh, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: sh * 0.01),
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
      ],
    );
  }

  // Reusable TextField with proper styling and labels
  Widget _buildTextField(
      TextEditingController controller, String hint, double sw, double sh,
      {int maxLines = 1, String? label, Widget? prefixIcon}) {
    return Container(
      height: maxLines == 1 ? sh * 0.065 : null,
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: sh * 0.018,
          fontFamily: 'Poppins-Medium',
          color: AppColors.black,
        ),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          labelStyle: TextStyle(
            color: Colors.grey.shade700,
            fontSize: sh * 0.02,
            fontFamily: 'Poppins-Medium',
          ),
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade700,
            fontSize: sh * 0.018,
            fontFamily: 'Poppins-Light',
          ),
          prefixIcon: prefixIcon,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.errorColor, width: 2.0),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.yellowAccent, width: 2.0),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: AppColors.lightGrey,
          contentPadding:
              EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.02),
        ),
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

  // Select Post Category Section
  Widget _buildCategorySection(double sw, double sh) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Post Category',
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
          height: sh * 0.065,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade500, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedPostCategory,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down,
                  color: AppColors.black, size: sh * 0.025),
              style: TextStyle(
                color: AppColors.black,
                fontSize: sh * 0.022,
                fontFamily: 'Poppins-Light',
              ),
              items: ['Personal Life', 'Business', 'Service', 'Product']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                    child: Text(value),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPostCategory = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  // Create Button
  Widget _buildCreateButton(double sw, double sh) {
    return Container(
      width: double.infinity,
      height: sh * 0.07,
      decoration: BoxDecoration(
        color: AppColors.orangeAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: _submitPost,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Create',
          style: TextStyle(
            color: AppColors.white,
            fontSize: sh * 0.022,
            fontFamily: 'Poppins-Bold',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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

  // Submit form data
  void _submitPost() {
    // Create product JSON object from individual fields
    // Map<String, dynamic> productData = {
    //   'name': productNameController.text,
    //   'price': priceController.text,
    //   'currency': selectedCurrency,
    //   'inStock': isInStock,
    // };

    // Create product post data structure
    // Map<String, dynamic> productPostData = {
    //   'media': selectedImage?.path ?? '',
    //   'postType': 'photo',
    //   'caption': captionController.text,
    //   'description': descriptionController.text,
    //   'location': locationController.text,
    //   'mood': selectedMood,
    //   'activity': selectedActivity,
    //   'hashtags': hashtags,
    //   'category': selectedPostCategory,
    //   'product': productData,
    //   'status': 'scheduled',
    // };

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Product post created successfully!',
          style: TextStyle(fontFamily: 'Poppins-Medium'),
        ),
        backgroundColor: AppColors.orangeAccent,
        duration: Duration(seconds: 3),
      ),
    );

    // Navigate back
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Clean up controllers
    locationController.dispose();
    captionController.dispose();
    descriptionController.dispose();
    productNameController.dispose();
    priceController.dispose();
    hashtagController.dispose();
    super.dispose();
  }
}
