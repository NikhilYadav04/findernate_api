import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:social_media_clone/controller/profile/profile_controller.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

Widget profileEditAppBar(
    {required double maxHeight, required double maxWidth}) {
  return Text(
    "Edit Profile",
    style: _textStyle2.copyWith(
        color: Colors.black,
        fontSize: maxHeight * 0.03,
        fontWeight: FontWeight.bold),
  );
}

Widget editProfilePhotoWidget({
  required double maxHeight,
  required double maxWidth,
  required String imageURL,
  required File? imageFile,
}) {
  final avatarSize = maxHeight * 0.125;
  return badges.Badge(
      badgeContent: Center(
          child: Icon(
        Icons.camera_alt,
        size: maxHeight * 0.026,
        color: Colors.black,
      )),
      position: badges.BadgePosition.topEnd(
          top: maxHeight * 0.095, end: maxWidth * 0.31),
      showBadge: true,
      ignorePointer: false,
      badgeStyle: badges.BadgeStyle(
          padding: EdgeInsets.all(maxHeight * 0.008),
          badgeColor: Colors.transparent,
          elevation: 0),
      child: Center(
          child: Container(
        height: avatarSize,
        width: avatarSize, // Add width for perfect circle
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade800,
            width: 3.0,
          ),
        ),
        child: imageFile == null
            ? ClipOval(
                child: CachedNetworkImage(
                  imageUrl: imageURL,
                  height: avatarSize,
                  width: avatarSize,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircleAvatar(
                    radius: avatarSize / 2,
                    child: Icon(Icons.person),
                  ),
                  errorWidget: (context, url, error) => CircleAvatar(
                    radius: avatarSize / 2,
                    child: Icon(Icons.error),
                  ),
                ),
              )
            : ClipOval(
                child: Image.file(
                  imageFile,
                  fit: BoxFit.cover,
                  height: avatarSize,
                  width: avatarSize,
                ),
              ),
      )));
}

Widget profileEditInputField(
    {required GlobalKey<FormState> formKey,
    required double maxHeight,
    required double maxWidth,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    required ProviderProfile provider,
    required String key,
    required bool isError,
    bool readOnly = false,
    required String label}) {
  return Container(
      height: maxHeight * 0.065, // Fixed height - no conditional error height
      width: double.infinity,
      child: Form(
        key: formKey,
        child: TextFormField(
          readOnly: readOnly,
          
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: (value) {
            final error = validator!(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.setFieldError(key, error != null);
            });
            return null; // Always return null to hide error text
          },
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: isError ? Colors.red : AppColors.appYellow),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            contentPadding: EdgeInsets.symmetric(
              horizontal: maxWidth * 0.03,
              vertical: maxHeight * 0.018,
            ),
            errorStyle: TextStyle(height: 0), // Hide error text completely
          ),
          style: _textStyle2.copyWith(fontSize: maxHeight * 0.02),
        ),
      ));
}

Widget profileEditBioField(
    {required double maxHeight,
    required double maxWidth,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    required ProviderProfile provider,
    required String key,
    required bool isError,
    required String label}) {
  return Container(
      height: maxHeight * 0.125, // Fixed height - no conditional error height
      width: double.infinity,
      child: Form(
        key: formKey,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          expands: true,
          maxLines: null,
          minLines: null,
          textAlignVertical: TextAlignVertical.top,
          keyboardType: TextInputType.multiline,
          controller: controller,
          maxLength: 200,
          validator: (value) {
            final error = validator!(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.setFieldError(key, error != null);
            });
            return null; // Always return null to hide error text
          },
          decoration: InputDecoration(
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: isError ? Colors.red : AppColors.appYellow),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            contentPadding: EdgeInsets.symmetric(
              horizontal: maxWidth * 0.03,
              vertical: maxHeight * 0.01,
            ),
            errorStyle: TextStyle(height: 0), // Hide error text completely
          ),
          style: _textStyle2.copyWith(fontSize: maxHeight * 0.02),
        ),
      ));
}

Widget profileEditDateField({
  required double maxHeight,
  required double maxWidth,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required BuildContext context,
  required void Function(DateTime) onTap,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
      height: maxHeight * 0.065,
      width: double.infinity,
      child: Form(
        key: formKey,
        child: TextFormField(
          readOnly: true,
          maxLines: 1,
          keyboardType: TextInputType.multiline,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return SafeArea(
                            top: false,
                            bottom: false,
                            child: Container(
                              height: maxHeight * 0.28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(maxHeight * 0.01)),
                              ),
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode
                                    .date, // THIS is what you meant
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newDate) {
                                  onTap(newDate); // or handle newDate
                                },
                              ),
                            ));
                      });
                },
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: maxHeight * 0.04,
                  color: Colors.grey.shade700,
                )),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.appYellow),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            contentPadding: EdgeInsets.symmetric(
              horizontal: maxWidth * 0.03,
              vertical: maxHeight * 0.018,
            ),
            errorStyle: TextStyle(height: 0), // Hide error text completely
          ),
          style: _textStyle2.copyWith(fontSize: maxHeight * 0.02),
        ),
      ));
}

Widget editProfileGenderField({
  required double maxHeight,
  required double maxWidth,
  required BuildContext context,
  required ProviderProfile provider,
  TextInputType keyboardType = TextInputType.text,
}) {
  return CustomDropdown<String>(
    closedHeaderPadding: EdgeInsets.symmetric(
        vertical: maxHeight * 0.0105, horizontal: maxWidth * 0.03),
    decoration: CustomDropdownDecoration(
        closedSuffixIcon: Icon(
          Icons.arrow_drop_down,
          size: maxHeight * 0.04,
          color: Colors.grey.shade700,
        ),
        expandedSuffixIcon: Icon(
          Icons.arrow_drop_up_sharp,
          size: maxHeight * 0.04,
          color: Colors.grey.shade700,
        ),
        listItemStyle: _textStyle2.copyWith(fontSize: maxHeight * 0.021),
        headerStyle: _textStyle2.copyWith(fontSize: maxHeight * 0.021),
        hintStyle: _textStyle2.copyWith(fontSize: maxHeight * 0.021),
        closedBorderRadius: BorderRadius.circular(maxHeight * 0.01),
        closedFillColor: Color(0xFFF2F2F2),
        closedBorder: Border.all(
          style: BorderStyle.solid,
          color: Colors.grey.shade500,
        )),
    hintText: 'Select job role',
    items: ["Male", "Female"],
    initialItem: "Male",
    onChanged: (value) {
      provider.setGender(value!);
    },
  );
}

Widget businessTypeField({
  required double maxHeight,
  required double maxWidth,
  required BuildContext context,
  required ProviderProfile provider,
  TextInputType keyboardType = TextInputType.text,
}) {
  return CustomDropdown<String>(
    closedHeaderPadding: EdgeInsets.symmetric(
        vertical: maxHeight * 0.0098, horizontal: maxWidth * 0.03),
    decoration: CustomDropdownDecoration(
        closedSuffixIcon: Icon(
          Icons.arrow_drop_down,
          size: maxHeight * 0.05,
          color: Colors.grey.shade700,
        ),
        expandedSuffixIcon: Icon(
          Icons.arrow_drop_up_sharp,
          size: maxHeight * 0.05,
          color: Colors.grey.shade700,
        ),
        listItemStyle: _textStyle2.copyWith(fontSize: maxHeight * 0.024),
        headerStyle: _textStyle2.copyWith(fontSize: maxHeight * 0.024),
        hintStyle: _textStyle2.copyWith(fontSize: maxHeight * 0.024),
        closedBorderRadius: BorderRadius.circular(maxHeight * 0.01),
        closedFillColor: Color(0xFFF2F2F2),
        closedBorder: Border.all(
          style: BorderStyle.solid,
          color: Colors.grey.shade500,
        )),
    hintText: 'Select job role',
    items: [
      'Retail',
      'Hospitality',
      'Technology',
      'Healthcare',
      'Finance',
      'Education',
      'Manufacturing',
      'Construction',
      'RealEstate',
      'Transportation',
      'Agriculture',
      'Entertainment',
      'Marketing',
      'Logistics',
      'Consulting',
      'Legal',
      'Fashion',
      'Food',
      'Media',
      'Travel',
    ],
    initialItem: "Fashion",
    onChanged: (value) {
      provider.setBusinessType(value!);
    },
  );
}

Widget businessSubCategoryField(
    {required GlobalKey<FormState> formKey,
    required double maxHeight,
    required double maxWidth,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    required ProviderProfile provider,
    required String key,
    required bool isError,
    required String label}) {
  return Container(
      height: maxHeight * 0.065, // Fixed height - no conditional error height
      width: double.infinity,
      child: Form(
        key: formKey,
        child: TextFormField(
          keyboardType: keyboardType,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          validator: (value) {
            final error = validator!(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.setFieldError(key, error != null);
            });
            return null; // Always return null to hide error text
          },
          decoration: InputDecoration(
            labelText: label,
            labelStyle: _textStyle2.copyWith(fontSize: maxHeight * 0.018),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: isError ? Colors.red : AppColors.appYellow),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500),
              borderRadius: BorderRadius.circular(maxHeight * 0.01),
            ),
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            contentPadding: EdgeInsets.symmetric(
              horizontal: maxWidth * 0.03,
              vertical: maxHeight * 0.018,
            ),
            errorStyle: TextStyle(height: 0), // Hide error text completely
          ),
          style: _textStyle2.copyWith(fontSize: maxHeight * 0.02),
        ),
      ));
}

TextStyle _textStyle2 = TextStyle(fontFamily: "Poppins-Medium");
