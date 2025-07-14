import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

void showSnackBar(String message, BuildContext context,
    {required bool isError}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
        decoration: BoxDecoration(
          gradient: isError
              ? LinearGradient(
                  colors: [
                    Colors.red[600]!,
                    Colors.red[700]!,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [
                    AppColors.appGradient1,
                    AppColors.appGradient2,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Jakarta-Medium",
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      duration: Duration(seconds: isError ? 2 : 2),
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      margin: EdgeInsets.all(16),
    ),
  );
}
