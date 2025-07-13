import 'package:flutter/material.dart';
import 'package:intl_field_phone/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/utils/validator.dart';

Widget authFieldLabel(String text, BoxConstraints constraints, {bool isRequired = true}) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text,
          style: _style.copyWith(
            fontSize: constraints.maxHeight * 0.021,
            color: Colors.grey.shade700,
          ),
        ),
        if (isRequired)
          TextSpan(
            text: ' *',
            style: _style.copyWith(
              fontSize: constraints.maxHeight * 0.021,
              color: Colors.red,
            ),
          ),
      ],
    ),
  );
}

Widget inputFieldSignIn(
    {required BoxConstraints constraints,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    String hintext = '',
    required ProviderSignIn provider,
    required String key,
    required bool isError}) {
  return Container(
      height: constraints.maxHeight * 0.07, // Fixed height
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
            return null; // Hide error text
          },
          decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500,
                  width: isError ? 2.0 : 1.0,
                ),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.0),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError ? Colors.red : Color(0xFFFCD45C),
                  width: 2.0,
                ),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isError ? Colors.red : Colors.grey.shade500,
                  width: isError ? 2.0 : 1.0,
                ),
                borderRadius:
                    BorderRadius.circular(constraints.maxHeight * 0.01),
              ),
              hintText: hintext,
              hintStyle: _style.copyWith(
                  fontSize: constraints.maxHeight * 0.024,
                  color: Colors.grey.shade600),
              filled: true,
              fillColor: Color(0xFFF2F2F2),
              contentPadding: EdgeInsets.symmetric(
                horizontal: constraints.maxWidth * 0.03,
                vertical: constraints.maxHeight * 0.018,
              ),
              errorStyle: TextStyle(height: 0, fontSize: 0)), // Hide error text
          style: _style.copyWith(fontSize: constraints.maxHeight * 0.022),
        ),
      ));
}

Widget phoneField(
    {required BoxConstraints constraints,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required ProviderRegister provider}) {
  return Container(
    height: constraints.maxHeight * 0.1,
    width: double.infinity,
    child: IntlPhoneField(
      dropdownTextStyle: _style.copyWith(
        fontSize: constraints.maxHeight * 0.024,
      ),
      flagsButtonPadding: EdgeInsets.only(left: constraints.maxWidth * 0.015),
      initialCountryCode: 'IN',
      key: formKey,
      onCountryChanged: (value) {
        print(value.code);
      },
      controller: controller,
      onChanged: (phone) {
        if (controller.text.length == 10) {
          provider.setPhoneNumber(phone.completeNumber);
        }
      },
      validator: Validator.phoneNumberValidator,
      style: _style.copyWith(fontSize: constraints.maxHeight * 0.024),
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFCD45C)),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01)),
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
    ),
  );
}

Widget passwordFieldSignIn(
    {required BoxConstraints constraints,
    required GlobalKey<FormState> formKey,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    required ProviderSignIn provider,
    required bool isObSecure,
    String helper = '',
    required String key,
    required VoidCallback onTap,
    required bool isError}) {
  return Container(
    height: constraints.maxHeight * 0.07, // Fixed height
    width: double.infinity,
    child: Form(
      key: formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          final error = validator!(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.setFieldError(key, error != null);
          });
          return null; // Hide error text
        },
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObSecure,
        decoration: InputDecoration(
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2.0),
              borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
            ),
            suffixIcon: IconButton(
                onPressed: onTap,
                icon: Icon(
                  isObSecure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey.shade700,
                  size: constraints.maxHeight * 0.03,
                )),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: isError ? Colors.red : Colors.grey.shade500,
                width: isError ? 2.0 : 1.0,
              ),
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
            hintText: helper,
            hintStyle: _style.copyWith(
                fontSize: constraints.maxHeight * 0.024,
                color: Colors.grey.shade600),
            contentPadding: EdgeInsets.symmetric(
              horizontal: constraints.maxWidth * 0.03,
              vertical: constraints.maxHeight * 0.018,
            ),
            errorStyle: TextStyle(height: 0, fontSize: 0)), // Hide error text
        style: _style.copyWith(fontSize: constraints.maxHeight * 0.022),
      ),
    ),
  );
}

Widget authButton(
    BoxConstraints constraints, String title, VoidCallback onTap) {
  return Container(
    width: double.infinity,
    height: constraints.maxHeight * 0.07,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(constraints.maxHeight * 0.015),
      gradient: LinearGradient(
        colors: [AppColors.appGradient1, AppColors.appGradient2],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(constraints.maxHeight * 0.015),
      child: InkWell(
        borderRadius: BorderRadius.circular(constraints.maxHeight * 0.015),
        onTap: onTap,
        child: Center(
          child: Text(
            title,
            style: _style.copyWith(
              fontSize: constraints.maxHeight * 0.028,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget noAccountSignUpText(BoxConstraints constraints, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * .03),
    child: Center(
      child: FittedBox(
        child: RichText(
          text: TextSpan(
            style: _style.copyWith(
              color: Colors.black,
              fontSize: constraints.maxHeight * 0.019,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: 'Do not have an Account? '),
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
                      'Sign up',
                      style: _style.copyWith(
                        color: Colors.white, // Ignored due to shader
                        fontSize: constraints.maxHeight * 0.019,
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

Widget noAccountSignInText(BoxConstraints constraints, VoidCallback onTap) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: constraints.maxHeight * .03),
    child: Center(
      child: FittedBox(
        child: RichText(
          text: TextSpan(
            style: _style.copyWith(
              color: Colors.black,
              fontSize: constraints.maxHeight * 0.02,
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
                        color: Colors.white, // ignored in ShaderMask
                        fontSize: constraints.maxHeight * 0.02,
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

PinTheme defaultPinTheme(BoxConstraints constraints) {
  return PinTheme(
    width: constraints.maxWidth * 0.28,
    height: constraints.maxHeight * 0.065,
    textStyle: _style.copyWith(
      fontSize: constraints.maxHeight * 0.034,
      color: Colors.white,
      fontWeight: FontWeight.w500,
    ),
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [AppColors.appGradient1, AppColors.appGradient2],
          begin: Alignment.topCenter,
          end: AlignmentDirectional.bottomCenter),
      color: const Color(0xFFFCD45C),
      borderRadius: BorderRadius.circular(constraints.maxHeight * .012),
    ),
  );
}

TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");