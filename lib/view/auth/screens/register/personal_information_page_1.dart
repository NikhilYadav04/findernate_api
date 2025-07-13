import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/validator.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets_3.dart';

class PersonalInformationPage1 extends StatefulWidget {
  const PersonalInformationPage1({super.key});

  @override
  State<PersonalInformationPage1> createState() =>
      _PersonalInformationPage1State();
}

class _PersonalInformationPage1State extends State<PersonalInformationPage1> {
  //* Check if Fields Are Valid
  void _handleVerifyField({
    required BuildContext context,
    required Size constraints,
    required ProviderRegister provider,
  }) async {
    final isFullNameValid =
        provider.personalFullNameKey.currentState?.validate() ?? false;
    final isFullEmailValid =
        provider.personalEmailKey.currentState?.validate() ?? false;
    final isBioValid =
        provider.personalAboutKey.currentState?.validate() ?? false;

    if (isFullEmailValid && isFullNameValid && isBioValid) {
      Navigator.pushNamed(context, '/personal-info-2');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final h = size.height;
    double scale(double v) => v * h;
    double hPad(double v) => v * w;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Consumer<ProviderRegister>(
        builder: (context, provider, _) {
          return Padding(
            padding: EdgeInsets.only(top: 0),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  //* App Bar
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    leading: GestureDetector(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: h * 0.035,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    centerTitle: true,
                    floating: true,
                    snap: true,
                    title: postAddAppBar(
                        maxHeight: h,
                        maxWidth: w,
                        title: 'Personal Information'),
                    toolbarHeight: h * 0.08,
                  ),
                ];
              },
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad(0.04)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: scale(0.012)),
                      Text(
                        'Please fill the following',
                        style: _style.copyWith(
                          fontSize: scale(0.023),
                          color: Colors.grey.shade700,
                        ),
                      ),
                      SizedBox(height: scale(0.025)),

                      // ─── Form Fields ────────────────────────────────
                      authFieldLabel("Full name", size, isRequired: true),
                      SizedBox(height: scale(0.008)),
                      inputFieldRegister(
                        size: size,
                        formKey: provider.personalFullNameKey,
                        controller: provider.personalFullNameController,
                        validator: Validator.fullNameValidator,
                        key: 'fullname',
                        isError: provider.hasError('fullname'),
                        provider: provider,
                      ),

                      SizedBox(height: scale(0.025)),
                      authFieldLabel("Email Address", size, isRequired: true),
                      SizedBox(height: scale(0.008)),
                      inputFieldRegister(
                        size: size,
                        formKey: provider.personalEmailKey,
                        controller: provider.personalEmailController,
                        validator: Validator.emailValidator,
                        key: 'email',
                        isError: provider.hasError('email'),
                        provider: provider,
                      ),

                      SizedBox(height: scale(0.025)),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                authFieldLabel("Date Of Birth", size,
                                    isRequired: true),
                                SizedBox(height: scale(0.008)),
                                dateField(
                                  size: size,
                                  formKey: provider.personalDOBKey,
                                  controller: provider.personalDOBController,
                                  validator: Validator.emailValidator,
                                  context: context,
                                  onTap: provider.setDate,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: w * 0.04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                authFieldLabel("Gender", size,
                                    isRequired: true),
                                SizedBox(height: scale(0.008)),
                                genderField2(
                                  provider: provider,
                                  size: size,
                                  formKey: provider.personalGenderKey,
                                  controller: provider.personalGenderController,
                                  validator: Validator.emailValidator,
                                  context: context,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: scale(0.025)),
                      authFieldLabel("Bio", size,
                          isRequired: false), // Bio is optional
                      SizedBox(height: scale(0.01)),
                      bioFieldRegister(
                        size: size,
                        formKey: provider.personalAboutKey,
                        controller: provider.personalAboutController,
                        validator: _dummyValidator, // Using dummy validator
                        key: 'bio',
                        isError: provider.hasError('bio'),
                        provider: provider,
                      ),

                      SizedBox(height: scale(0.045)),

                      // ─── Footer ──────────────────────────────
                      authButton2(
                        size,
                        "Next",
                        () => _handleVerifyField(
                          constraints: size,
                          context: context,
                          provider: provider,
                        ),
                      ),

                      noAccountSignInText2(size, () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/sign-in',
                          arguments: {
                            'transition': TransitionType.bottomToTop,
                            'duration': 300,
                          },
                        );
                      }),

                      //SizedBox(height: scale(0.05)), // Extra bottom space
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Dummy validator for bio field (always returns null - no validation)
String? _dummyValidator(String? value) {
  return null; // Always valid
}

Widget authFieldLabel(String text, Size size, {bool isRequired = false}) {
  final h = size.height;
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: text,
          style: _style.copyWith(
            fontSize: h * 0.021,
            color: Colors.grey.shade700,
          ),
        ),
        if (isRequired)
          TextSpan(
            text: ' *',
            style: _style.copyWith(
              fontSize: h * 0.021,
              color: Colors.red,
            ),
          ),
      ],
    ),
  );
}

Widget bioFieldRegister({
  required Size size,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
  required ProviderRegister provider,
  required String key,
  required bool isError,
}) {
  final h = size.height;
  final w = size.width;

  return Container(
    height: h * 0.15, // Fixed height since bio doesn't show errors
    width: double.infinity,
    child: Form(
      key: formKey,
      child: TextFormField(
        maxLength: 200,
        expands: true,
        maxLines: null,
        minLines: null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: (value) {
          final error = validator!(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.setFieldError(key, error != null);
          });
          return null; // Don't show error text for bio
        },
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade500,
              width: isError ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color(0xFFFCD45C),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade500,
              width: isError ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.03,
            vertical: h * 0.008,
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0), // Hide error text
          hintText: "Tell us about yourself (optional)",
          hintStyle: _style.copyWith(
            fontSize: h * 0.02,
            color: Colors.grey.shade600,
          ),
        ),
        style: _style.copyWith(fontSize: h * 0.02),
      ),
    ),
  );
}

Widget inputFieldRegister({
  required Size size,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  String helper = '',
  required String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
  required ProviderRegister provider,
  required String key,
  required bool isError,
}) {
  final h = size.height;
  final w = size.width;
  return Container(
    height: h * 0.07, // Fixed height, no error text
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
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Color(0xFFFCD45C),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: isError ? Colors.red : Colors.grey.shade500,
              width: isError ? 2.0 : 1.0,
            ),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.03,
            vertical: h * 0.018,
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0), // Hide error text
        ),
        style: _style.copyWith(fontSize: h * 0.02),
      ),
    ),
  );
}

Widget dateField({
  required Size size,
  required GlobalKey<FormState> formKey,
  required TextEditingController controller,
  required String? Function(String?)? validator,
  required BuildContext context,
  required void Function(DateTime) onTap,
  TextInputType keyboardType = TextInputType.text,
}) {
  final h = size.height;
  final w = size.width;

  return Container(
    height: h * 0.07,
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
                      height: h * 0.28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(h * 0.01),
                        ),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (DateTime newDate) {
                          onTap(newDate);
                        },
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.arrow_drop_down,
              size: h * 0.05,
              color: Colors.grey.shade700,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFFCD45C)),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500),
            borderRadius: BorderRadius.circular(h * 0.01),
          ),
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: w * 0.03,
            vertical: h * 0.018,
          ),
        ),
        style: _style.copyWith(fontSize: h * 0.02),
      ),
    ),
  );
}

TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
