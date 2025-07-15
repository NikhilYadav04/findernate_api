import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:social_media_clone/controller/auth/controller_auth.dart';
import 'package:social_media_clone/core/utils/snackBar.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  //* to toggle visibility
  bool isObSecure = true;
  bool _isLoading = false;

  //* Delete Account API Call
  void _handleDeleteAccount({
    required BuildContext context,
    required BoxConstraints constraints,
    required ProviderSignIn provider,
    required ProviderSignIn providerSign,
    required ProviderAuth providerAuth,
  }) async {
    bool isPasswordValid =
        providerSign.deletePasswordController.text.trim().isNotEmpty;

    if (isPasswordValid) {
      bool? confirmDelete = await _showDeleteConfirmationDialog(context);

      if (confirmDelete == true) {
        setState(() {
          _isLoading = true;
        });
        Logger().d(provider.deletePasswordController.text.trim());

        bool deleteSuccess = await providerAuth.delete(
          context,
          provider.deletePasswordController.text.trim(),
        );

        if (deleteSuccess) {
        } else {
          showSnackBar("Error Deleting Account", context, isError: true);
        }

        setState(() {
          _isLoading = false;
        });
      }
    } else {
      showSnackBar("Please enter your password to confirm deletion", context,
          isError: true);
    }
  }

  //* Show Delete Confirmation Dialog
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Delete Account',
            style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
            style: TextStyle(
              fontFamily: "Poppins-Medium",
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'No',
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Yes',
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext screenContext) {
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

            return Consumer<ProviderSignIn>(builder: (context, provider, _) {
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
                      'Delete Account',
                      style: _style.copyWith(
                        fontSize: scale(0.032),
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: scale(0.012)),
                    Text(
                      'Enter your password to permanently delete your account. This action cannot be undone.',
                      style: _style.copyWith(
                        fontSize: scale(0.023),
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SizedBox(height: scale(0.045)),

                    //* Warning Card
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(scale(0.02)),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            color: Colors.red,
                            size: scale(0.025),
                          ),
                          SizedBox(width: scale(0.01)),
                          Expanded(
                            child: Text(
                              'Warning: Deleting your account will permanently remove all your data, posts, and personal information.',
                              style: _style.copyWith(
                                fontSize: scale(0.018),
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: scale(0.035)),

                    //* Password Field
                    authFieldLabel("Password", constraints),
                    SizedBox(height: scale(0.007)),
                    passwordFieldSignIn(
                        helper: '',
                        constraints: constraints,
                        formKey: provider.deletePasswordKey,
                        controller: provider.deletePasswordController,
                        validator: dummyNameValidator,
                        isObSecure: isObSecure,
                        provider: provider,
                        key: 'deletePassword',
                        isError: provider.hasError('deletePassword'),
                        onTap: () => setState(() {
                              isObSecure = !isObSecure;
                            })),

                    Spacer(),

                    //* Delete Button
                    _isLoading
                        ? Center(
                            child: SpinKitCircle(
                              color: Colors.red,
                              size: constraints.maxHeight * 0.05,
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: constraints.maxHeight * 0.065,
                            child: ElevatedButton(
                              onPressed: () => _handleDeleteAccount(
                                  constraints: constraints,
                                  context: context,
                                  providerAuth: providerAuth,
                                  providerSign: provider,
                                  provider: provider),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 2,
                              ),
                              child: Text(
                                'Confirm Delete',
                                style: _style.copyWith(
                                  fontSize: scale(0.022),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                    SizedBox(height: scale(0.02)),

                    //* Cancel Button
                    Container(
                      width: double.infinity,
                      height: constraints.maxHeight * 0.065,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey.shade600,
                          side: BorderSide(color: Colors.grey.shade300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: _style.copyWith(
                            fontSize: scale(0.022),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: scale(0.03)),
                  ],
                ),
              );
            });
          },
        ),
      ),
    );
  }

  String? dummyNameValidator(String? name) {
    // Always passes validation
    return null;
  }

  TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
}
