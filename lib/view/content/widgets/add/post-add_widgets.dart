import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/constants/places.dart';

class PostAddWidgets {
  // ===========================================
  // COMMON TEXT FIELDS
  // ===========================================

  // Standard Text Field
  static Widget buildTextField(
    TextEditingController controller,
    String hint,
    double sw,
    double sh, {
    int maxLines = 1,
    String? label,
    Widget? prefixIcon,
  }) {
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
          // labelText: label,
          label: Text(
            textAlign: TextAlign.start,
            label!,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: sh * 0.02,
              fontFamily: 'Poppins-Medium',
            ),
          ),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // labelStyle: TextStyle(
          //   color: Colors.grey.shade700,
          //   fontSize: sh * 0.02,
          //   fontFamily: 'Poppins-Medium',
          // ),
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

  static Widget buildLocationTextField(
    TextEditingController controller,
    String hint,
    double sw,
    double sh, {
    int maxLines = 1,
    String? label,
    Widget? prefixIcon,
    List<String>? autocompleteOptions,
  }) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty || autocompleteOptions == null) {
          return const Iterable<String>.empty();
        }
        return autocompleteOptions.where((String option) {
          return option
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        controller.text = selection;
      },
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController fieldTextEditingController,
        FocusNode fieldFocusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return Container(
          height: maxLines == 1 ? sh * 0.065 : null,
          child: TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            textAlignVertical: TextAlignVertical.top,
            maxLines: maxLines,
            // This callback is triggered when the user presses the "done"
            // or "submit" action button on their keyboard.
            onSubmitted: (String value) {
              controller.text = value; // Update the main controller
              onFieldSubmitted(); // Notify the Autocomplete widget
            },
            style: TextStyle(
              fontSize: sh * 0.018,
              fontFamily: 'Poppins-Medium',
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
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(8),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber, width: 2.0),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Color(0xFFF5F5F5),
              contentPadding: EdgeInsets.symmetric(
                  horizontal: sw * 0.04, vertical: sh * 0.02),
            ),
          ),
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<String> onSelected,
        Iterable<String> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final String option = options.elementAt(index);
                  return InkWell(
                    onTap: () => onSelected(option),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 16.0),
                      child: Text(
                        option,
                        style: TextStyle(fontSize: sh * 0.018),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
  // ===========================================
  // LOCATION FIELD
  // ===========================================

  static Widget buildLocationField(
    TextEditingController controller,
    double sw,
    double sh,
  ) {
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
        buildLocationTextField(controller, 'Enter location...', sw, sh,
            label: 'Location', autocompleteOptions: places),
      ],
    );
  }

  // ===========================================
  // CAPTION FIELD
  // ===========================================

  static Widget buildCaptionField(
    TextEditingController controller,
    double sw,
    double sh,
  ) {
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
        buildTextField(
          controller,
          'Write your caption...',
          sw,
          sh,
          maxLines: 3,
          label: 'Caption',
        ),
      ],
    );
  }

  // ===========================================
  // DESCRIPTION FIELD
  // ===========================================

  static Widget buildDescriptionField(
    TextEditingController controller,
    double sw,
    double sh,
  ) {
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
        buildTextField(
          controller,
          'Write your description...',
          sw,
          sh,
          maxLines: 3,
          label: 'Description',
        ),
      ],
    );
  }

  // ===========================================
  // DROPDOWN FIELDS
  // ===========================================

  static Widget buildDropdown(
    String label,
    String value,
    List<String> items,
    double sw,
    double sh,
    ValueChanged<String?> onChanged, {
    bool showLabel = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: sh * 0.02,
              fontFamily: 'Poppins-Medium',
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: sh * 0.015),
        ],
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
                fontSize: sh * 0.018,
                fontFamily: 'Poppins-Light',
              ),
              hint: showLabel
                  ? null
                  : Text(
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
      ],
    );
  }

  // ===========================================
  // POST CATEGORY SECTION
  // ===========================================

  static Widget buildPostCategorySection(
    String selectedCategory,
    double sw,
    double sh,
    ValueChanged<String?> onChanged,
  ) {
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
              value: selectedCategory,
              isExpanded: true,
              icon: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(Icons.keyboard_arrow_down,
                    color: AppColors.black, size: sh * 0.025),
              ),
              style: TextStyle(
                color: AppColors.black,
                fontSize: sh * 0.022,
                fontFamily: 'Poppins-Light',
              ),
              items: [
                'Personal Life',
                'Travel',
                'Food & Dining',
                'Fashion & Style',
                'Health & Fitness',
                'Technology',
                'Art & Culture',
                'Sports',
                'Entertainment',
                'Education',
                'Business',
                'Other'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                    child: Text(value),
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

  // ===========================================
  // IMAGE PICKER WIDGET
  // ===========================================

  static Widget buildImagePicker(
      double sw, double sh, File? selectedImage, VoidCallback onTap,
      {int limit = 3}) {
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
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: selectedImage == null ? sh * 0.3 : sh * 0.45,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade500,
                width: 1.0,
              ),
            ),
            child: selectedImage == null
                ? Padding(
                    padding: EdgeInsets.all(sw * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Camera Icon - Bigger and Darker
                        Container(
                          width: sw * 0.16,
                          height: sw * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey.shade600,
                            size: sw * 0.08,
                          ),
                        ),
                        SizedBox(height: sh * 0.02),

                        // Title - Darker
                        Text(
                          'Add Photos',
                          style: TextStyle(
                            fontSize: sh * 0.02,
                            fontFamily: 'Poppins-SemiBold',
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: sh * 0.008),

                        // Subtitle - Darker
                        Flexible(
                          child: Text(
                            'Upload up to ${limit} images (JPG, PNG, GIF - max 5MB each)',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: sh * 0.014,
                              fontFamily: 'Poppins-Regular',
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                          ),
                        ),
                        SizedBox(height: sh * 0.02),

                        // Add Images Button with Gradient
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: sw * 0.05,
                            vertical: sh * 0.01,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                              colors: [
                                AppColors.appGradient1,
                                AppColors.appGradient2,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.appGradient1.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                color: Colors.white,
                                size: sh * 0.018,
                              ),
                              SizedBox(width: sw * 0.015),
                              Text(
                                'Add Images',
                                style: TextStyle(
                                  fontSize: sh * 0.016,
                                  fontFamily: 'Poppins-Medium',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      // Selected Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          selectedImage,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),

                      // Edit/Change overlay
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: sh * 0.018,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }

  // ===========================================
  // CREATE BUTTON
  // ===========================================

  static Widget buildCreateButton(
      double sw, double sh, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: sh * 0.07,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              AppColors.appGradient1,
              AppColors.appGradient2,
            ]),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
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

  // ===========================================
  // UTILITY FUNCTIONS
  // ===========================================

  // Image Picker Helper
  static Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  // Common spacing
  static SizedBox verticalSpacing(double sh, {double multiplier = 0.03}) {
    return SizedBox(height: sh * multiplier);
  }

  static SizedBox horizontalSpacing(double sw, {double multiplier = 0.04}) {
    return SizedBox(width: sw * multiplier);
  }

  // Success Message Helper
  static void showSuccessMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Poppins-Medium'),
        ),
        backgroundColor: AppColors.orangeAccent,
        duration: Duration(seconds: 3),
      ),
    );
  }

  // Currency Icon Helper
  static Widget getCurrencyIcon(String currency) {
    switch (currency) {
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
}
