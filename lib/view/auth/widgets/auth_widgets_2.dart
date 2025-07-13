import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';

Widget inputFieldRegister({
  required BoxConstraints constraints,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
  required ProviderRegister provider,
  required String key,
  required bool isError,
}) {
  return Container(
    height: constraints.maxHeight * 0.07, // Fixed height, no error text
    width: double.infinity,
    child: Form(
      key: formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: (value) {
          final error = validator!(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.setFieldError(key, error != null);
          });
          return null; // Don't show error text
        },
        keyboardType: keyboardType,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade500,
              width: isError ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color(0xFFFCD45C),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade500,
              width: isError ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.03,
            vertical: constraints.maxHeight * 0.018,
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0), // Hide error text
        ),
        style: TextStyle(
          fontFamily: "Poppins-Medium",
          fontSize: constraints.maxHeight * 0.022,
        ),
      ),
    ),
  );
}

// Updated password field widget with red border only (no error text)
Widget passwordFieldRegister({
  required BoxConstraints constraints,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required ProviderRegister provider,
  required String key,
  required bool isError,
  required bool isObSecure,
  required VoidCallback onTap,
}) {
  return Container(
    height: constraints.maxHeight * 0.07, // Fixed height, no error text
    width: double.infinity,
    child: Form(
      key: formKey,
      child: TextFormField(
        obscureText: isObSecure,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: (value) {
          final error = validator!(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.setFieldError(key, error != null);
          });
          return null; // Don't show error text
        },
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: Icon(
              isObSecure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade600,
              size: constraints.maxHeight * 0.03,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade500,
              width: isError ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color(0xFFFCD45C),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade500,
              width: isError ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.03,
            vertical: constraints.maxHeight * 0.018,
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0), // Hide error text
        ),
        style: TextStyle(
          fontFamily: "Poppins-Medium",
          fontSize: constraints.maxHeight * 0.022,
        ),
      ),
    ),
  );
}

Widget dateField({
  required BoxConstraints constraints,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required BuildContext context,
  required void Function(DateTime) onTap,
  TextInputType keyboardType = TextInputType.text,
}) {
  return Container(
      height: constraints.maxHeight * 0.07,
      width: double.infinity,
      child: Form(
        key: formKey,
        child: TextFormField(
          readOnly: true,
          maxLines: 1,
          keyboardType: TextInputType.multiline,
          controller: controller,
          validator: validator,
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
                              height: constraints.maxHeight * 0.28,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(
                                        constraints.maxHeight * 0.01)),
                              ),
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                initialDateTime: DateTime.now(),
                                onDateTimeChanged: (DateTime newDate) {
                                  //* handle newDate
                                  onTap(newDate);
                                },
                              ),
                            ));
                      });
                },
                icon: Icon(
                  Icons.arrow_drop_down,
                  size: constraints.maxHeight * 0.05,
                  color: Colors.grey.shade700,
                )),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFFCD45C)),
              borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
            ),
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            contentPadding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.03,
              vertical: constraints.maxHeight * 0.018,
            ),
          ),
          style: _style.copyWith(fontSize: constraints.maxHeight * 0.023),
        ),
      ));
}

Widget genderField({
  required BoxConstraints constraints,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required BuildContext context,
  required ProviderRegister provider,
  TextInputType keyboardType = TextInputType.text,
}) {
  return CustomDropdown<String>(
    closedHeaderPadding: EdgeInsets.symmetric(
        vertical: constraints.maxHeight * 0.0098,
        horizontal: constraints.maxWidth * 0.03),
    decoration: CustomDropdownDecoration(
        closedSuffixIcon: Icon(
          Icons.arrow_drop_down,
          size: constraints.maxHeight * 0.05,
          color: Colors.grey.shade700,
        ),
        expandedSuffixIcon: Icon(
          Icons.arrow_drop_up_sharp,
          size: constraints.maxHeight * 0.05,
          color: Colors.grey.shade700,
        ),
        listItemStyle: _style.copyWith(fontSize: constraints.maxHeight * 0.024),
        headerStyle: _style.copyWith(fontSize: constraints.maxHeight * 0.024),
        hintStyle: _style.copyWith(fontSize: constraints.maxHeight * 0.024),
        closedBorderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
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

Widget bioFieldRegister(
    {required BoxConstraints constraints,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    required ProviderRegister provider,
    required String key,
    required bool isError}) {
  return Container(
      height: constraints.maxHeight * (isError ? 0.12 : 0.115),
      width: double.infinity,
      child: Form(
        key: formKey,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          //  expands: true,
          // maxLines: null,
          // minLines: null,
          // keyboardType: TextInputType.multiline,
          controller: controller,
          validator: (value) {
            final error = validator!(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              provider.setFieldError(key, error != null);
            });
            return error;
          },
          decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFFCD45C)),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade500),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              filled: true,
              fillColor: Color(0xFFF2F2F2),
              contentPadding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.03,
                vertical: constraints.maxHeight * 0.018,
              ),
              errorStyle: _style.copyWith(
                fontSize: constraints.maxHeight * 0.018,
              )),
          style: _style.copyWith(fontSize: constraints.maxHeight * 0.024),
        ),
      ));
}

TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
