import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController =
      TextEditingController();

  final GlobalKey<FormState> _currentPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newPasswordConfirmFormKey =
      GlobalKey<FormState>();

  bool _isCurrentPasswordObscure = true;
  bool _isNewPasswordObscure = true;
  bool _isNewPasswordConfirmObscure = true;
  bool _isLoading = false;

  //* Change Password API Call
  void _handleChangePassword({
    required BuildContext context,
    required BoxConstraints constraints,
    required ProviderAuth providerAuth,
  }) async {
    bool isCurrentPasswordValid =
        _currentPasswordController.text.trim().isNotEmpty;
    bool isNewPasswordValid = _newPasswordController.text.trim().isNotEmpty;

    if (_newPasswordController.text.trim() !=
        _newPasswordConfirmController.text.trim()) {
      showSnackBar("Both Passwords Should Match!", context, isError: true);
      return;
    }

    if (isCurrentPasswordValid && isNewPasswordValid) {
      setState(() {
        _isLoading = true;
      });

      bool changeSuccess = await providerAuth.changePassword(
        currentPassword: _currentPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim(),
        context: context,
      );

      setState(() {
        _isLoading = false;
      });

      if (changeSuccess) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {}

      return;
    } else {
      if (!isCurrentPasswordValid) {
        showSnackBar("Please enter your current password", context,
            isError: true);
        return;
      }

      if (!isNewPasswordValid) {
        showSnackBar("Please enter your new password", context, isError: true);
        return;
      }
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final providerAuth = Provider.of<ProviderAuth>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Scaling factors
            final maxWidth = constraints.maxWidth;
            final maxHeight = constraints.maxHeight;

            // Example scaling
            double scale(double value) => value * maxHeight;
            double hPadding(double value) => value * maxWidth;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: hPadding(0.04)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: scale(0.03)),
                  InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: Icon(Icons.arrow_back_ios, size: scale(0.035))),
                  SizedBox(height: scale(0.04)),
                  Text(
                    'Change Password',
                    style: _style.copyWith(
                      fontSize: scale(0.032),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: scale(0.012)),
                  Text(
                    'Enter your current and new password',
                    style: _style.copyWith(
                      fontSize: scale(0.023),
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: scale(0.035)),

                  //* Current Password Field
                  authFieldLabel("Current Password", constraints),
                  SizedBox(height: scale(0.007)),
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    formKey: _currentPasswordFormKey,
                    isObscure: _isCurrentPasswordObscure,
                    constraints: constraints,
                    onToggleVisibility: () => setState(() {
                      _isCurrentPasswordObscure = !_isCurrentPasswordObscure;
                    }),
                  ),

                  SizedBox(height: scale(0.025)),

                  //* New Password Field
                  authFieldLabel("New Password", constraints),
                  SizedBox(height: scale(0.007)),
                  _buildPasswordField(
                    controller: _newPasswordController,
                    formKey: _newPasswordFormKey,
                    isObscure: _isNewPasswordObscure,
                    constraints: constraints,
                    onToggleVisibility: () => setState(() {
                      _isNewPasswordObscure = !_isNewPasswordObscure;
                    }),
                  ),

                  SizedBox(height: scale(0.02)),

                  //* New Password Field
                  authFieldLabel("Confirm New Password", constraints),
                  SizedBox(height: scale(0.007)),
                  _buildPasswordField(
                    controller: _newPasswordConfirmController,
                    formKey: _newPasswordConfirmFormKey,
                    isObscure: _isNewPasswordConfirmObscure,
                    constraints: constraints,
                    onToggleVisibility: () => setState(() {
                      _isNewPasswordConfirmObscure = !_isNewPasswordConfirmObscure;
                    }),
                  ),

                  // //* Password Requirements
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.all(scale(0.015)),
                  //   decoration: BoxDecoration(
                  //     color: Colors.blue.shade50,
                  //     borderRadius: BorderRadius.circular(8),
                  //     border: Border.all(color: Colors.blue.shade200),
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Password Requirements:',
                  //         style: _style.copyWith(
                  //           fontSize: scale(0.018),
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.blue.shade700,
                  //         ),
                  //       ),
                  //       SizedBox(height: scale(0.005)),
                  //       Text(
                  //         '• At least 8 characters long\n• Contains uppercase and lowercase letters\n• Contains at least one number',
                  //         style: _style.copyWith(
                  //           fontSize: scale(0.016),
                  //           color: Colors.blue.shade600,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  Spacer(),

                  //* Change Password Button
                  _isLoading
                      ? Center(
                          child: SpinKitCircle(
                            color: AppColors.appYellow,
                            size: constraints.maxHeight * 0.05,
                          ),
                        )
                      : authButton(
                          constraints,
                          "Change Password",
                          () => _handleChangePassword(
                              constraints: constraints,
                              context: context,
                              providerAuth: providerAuth),
                        ),

                  SizedBox(height: scale(0.03)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  //* Custom password field widget
  // Custom password field widget
  Widget _buildPasswordField({
    required TextEditingController controller,
    required GlobalKey<FormState> formKey,
    required bool isObscure,
    required BoxConstraints constraints,
    required VoidCallback onToggleVisibility,
  }) {
    return Form(
      key: formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          //final error = dummyValidator(value);
          return null; // Hide error text
        },
        controller: controller,
        keyboardType: TextInputType.text,
        obscureText: isObscure,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          suffixIcon: IconButton(
            onPressed: onToggleVisibility,
            icon: Icon(
              isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey.shade700,
              size: constraints.maxHeight * 0.03,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFCD45C),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade500,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(constraints.maxHeight * 0.01),
          ),
          filled: true,
          fillColor: Color(0xFFF2F2F2),
          hintText: '',
          hintStyle: _style.copyWith(
            fontSize: constraints.maxHeight * 0.024,
            color: Colors.grey.shade600,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: constraints.maxWidth * 0.03,
            vertical: constraints.maxHeight * 0.018,
          ),
          errorStyle: TextStyle(height: 0, fontSize: 0), // Hide error text
        ),
        style: _style.copyWith(fontSize: constraints.maxHeight * 0.022),
      ),
    );
  }

  String? dummyValidator(String? value) {
    // Always passes validation
    return null;
  }

  TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
}
