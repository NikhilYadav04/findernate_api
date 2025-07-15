import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

Widget genderField2({
  required Size size,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required BuildContext context,
  required ProviderRegister provider,
  TextInputType keyboardType = TextInputType.text,
}) {
  final h = size.height;
  final w = size.width;

  return CustomDropdown<String>(
    closedHeaderPadding: EdgeInsets.symmetric(
      vertical: h * 0.0098,
      horizontal: w * 0.03,
    ),
    decoration: CustomDropdownDecoration(
      closedSuffixIcon: Icon(
        Icons.arrow_drop_down,
        size: h * 0.05,
        color: Colors.grey.shade700,
      ),
      expandedSuffixIcon: Icon(
        Icons.arrow_drop_up_sharp,
        size: h * 0.05,
        color: Colors.grey.shade700,
      ),
      listItemStyle: _style.copyWith(fontSize: h * 0.022),
      headerStyle: _style.copyWith(fontSize: h * 0.022),
      hintStyle: _style.copyWith(fontSize: h * 0.022),
      closedBorderRadius: BorderRadius.circular(h * 0.01),
      closedFillColor: Color(0xFFF2F2F2),
      closedBorder: Border.all(
        style: BorderStyle.solid,
        color: Colors.grey.shade500,
      ),
    ),
    hintText: 'Select job role',
    items: ["Male", "Female"],
    initialItem: "Male",
    onChanged: (value) {
      provider.setGender(value!);
    },
  );
}

TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");

Widget authButton2(Size size, String title, VoidCallback onTap) {
  final h = size.height;

  return SizedBox(
    width: double.infinity,
    height: h * 0.07,
    child: Container(
      width: double.infinity,
      height: size.height * 0.068,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.appGradient1, AppColors.appGradient2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: _style.copyWith(
            fontSize: size.height* 0.025,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    )
  );
}

Widget noAccountSignInText2(Size size, VoidCallback onTap) {
  final h = size.height;

  return Padding(
    padding: EdgeInsets.only(top: h * 0.03, bottom: 0),
    child: Center(
      child: FittedBox(
        child: RichText(
          text: TextSpan(
            style: _style.copyWith(
              color: Colors.black,
              fontSize: h * 0.018,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: 'Already have an account? '),
              WidgetSpan(
                child: GestureDetector(
                  onTap: onTap,
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        AppColors.appGradient1,
                        AppColors.appGradient2,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                    ),
                    child: Text(
                      'Sign In',
                      style: _style.copyWith(
                        color: Colors.white, // Will be ignored
                        fontSize: h * 0.018,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget postAddAppBar(
    {required double maxHeight,
    required double maxWidth,
    required String title}) {
  return Text(
    title,
    style: _textStyle2.copyWith(
        color: Colors.black,
        fontSize: maxHeight * 0.024,
        fontWeight: FontWeight.bold),
  );
}

TextStyle _textStyle2 =TextStyle(fontFamily: "Poppins-Medium");