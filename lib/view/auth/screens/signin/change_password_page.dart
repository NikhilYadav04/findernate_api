// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:social_media_clone/controller/auth/controller_auth.dart';
// import 'package:social_media_clone/core/utils/validator.dart';
// import 'package:social_media_clone/view/auth/widgets/auth_widgets.dart';

// class ChangePassword extends StatefulWidget {
//   const ChangePassword({super.key});

//   @override
//   State<ChangePassword> createState() => _ChangePasswordState();
// }

// class _ChangePasswordState extends State<ChangePassword> {
//   //* toggle visibility
//   bool isObSecure = false;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // Scaling factors
//           final maxWidth = constraints.maxWidth;
//           final maxHeight = constraints.maxHeight;

//           // Example scaling
//           double scale(double value) => value * maxHeight;
//           double hPadding(double value) => value * maxWidth;

//           return Consumer<ProviderSignIn>(builder: (context, provider, _) {
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: hPadding(0.04)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: scale(0.03)),
//                   InkWell(
//                       onTap: () => context.pop(),
//                       child: Icon(Icons.arrow_back_ios, size: scale(0.035))),
//                   SizedBox(height: scale(0.04)),
//                   Text(
//                     'Pick a new Password',
//                     style: _style.copyWith(
//                       fontSize: scale(0.035),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: scale(0.012)),
//                   Text(
//                     'Help secure your account',
//                     style: _style.copyWith(
//                       fontSize: scale(0.025),
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   SizedBox(height: scale(0.045)),

//                   //* Fields And Label
//                   authFieldLabel("New Password", constraints),
//                   SizedBox(height: scale(0.015)),

//                   passwordField(
//                       constraints: constraints,
//                       formKey: provider.oldPasswordKey,
//                       controller: provider.oldPasswordController,
//                       validator: Validator.passwordValidator,
//                       isObSecure: isObSecure,
//                       onTap: () => setState(() {
//                             isObSecure = !isObSecure;
//                           })),

//                   SizedBox(height: scale(0.025)),

//                   authFieldLabel("Confirm New Password", constraints),

//                   SizedBox(height: scale(0.015)),
//                   passwordField(
//                       constraints: constraints,
//                       formKey: provider.newPasswordKey,
//                       controller: provider.newPasswordController,
//                       validator: Validator.passwordValidator,
//                       isObSecure: isObSecure,
//                       onTap: () => setState(() {
//                             isObSecure = !isObSecure;
//                           })),

//                   Spacer(),

//                   //* Buttons
//                   authButton(constraints, "Done", () {
//                     context.go('/sign-in');
//                   }),
//                   //SizedBox(height: scale(0.025)),

//                   //* No Account Text
//                   noAccountSignUpText(constraints, () {
//                     context.push('/register-phone');
//                   }),
//                 ],
//               ),
//             );
//           });
//         },
//       ),
//     ));
//   }

//   TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
// }
