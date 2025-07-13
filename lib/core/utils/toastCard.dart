import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:flutter/material.dart';

class ToastCardWidget {
  static void showToast({
    required BoxConstraints constraints,
    required BuildContext context,
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return DelightToastBar(
      snackbarDuration: Duration(seconds: 3),
      autoDismiss: true,
      animationDuration: Duration(milliseconds: 100),
      animationCurve: Curves.easeIn,
      builder: (context) => ToastCard(
        color: color,
        leading: Icon(
          icon,
          color: Colors.white,
          size: constraints.maxHeight * 0.04,
        ),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins-Medium",
              fontWeight: FontWeight.w700,
              fontSize: constraints.maxHeight * 0.02,
            ),
          ),
        ),
      ),
    ).show(context);
  }

  static void showToasty({
    required double maxHeight,
    required BuildContext context,
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return DelightToastBar(
      snackbarDuration: Duration(seconds: 3),
      autoDismiss: true,
      animationDuration: Duration(milliseconds: 100),
      animationCurve: Curves.easeIn,
      builder: (context) => ToastCard(
        color: color,
        leading: Icon(
          icon,
          color: Colors.white,
          size: maxHeight * 0.04,
        ),
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins-Medium",
              fontWeight: FontWeight.w700,
              fontSize: maxHeight * 0.02,
            ),
          ),
        ),
      ),
    ).show(context);
  }
}
