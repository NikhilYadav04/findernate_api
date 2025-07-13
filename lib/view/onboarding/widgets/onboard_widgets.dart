import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

Widget onboardButton(String text, Color backgroundColor, Color textColor,
    VoidCallback onTap, BoxConstraints constraints, bool isSkip) {
  return TextButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          maximumSize: WidgetStatePropertyAll(
              Size(double.infinity, constraints.maxHeight * 0.07)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              side: isSkip
                  ? BorderSide(width: 2, color: Colors.black)
                  : BorderSide.none,
              borderRadius:
                  BorderRadius.circular(constraints.maxHeight * 0.012)))),
      onPressed: onTap,
      child: Center(
        child: Text(
          text,
          style: _style.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: constraints.maxHeight * 0.024,
              letterSpacing: 1),
        ),
      ));
}

Widget onboardButton1(
    String text, VoidCallback onTap, BoxConstraints constraints, bool isSkip) {
  return Container(
    height: constraints.maxHeight * 0.07,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(constraints.maxHeight* 0.012),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
          AppColors.appGradient1,
          AppColors.appGradient2,
        ])),
    child: TextButton(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            foregroundColor: WidgetStatePropertyAll(Colors.transparent),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              side: isSkip
                  ? BorderSide(width: 2, color: Colors.black)
                  : BorderSide.none,
            ))),
        onPressed: onTap,
        child: Center(
          child: Text(
            text,
            style: _style.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: constraints.maxHeight * 0.025,
                letterSpacing: 1),
          ),
        )),
  );
}

TextStyle _style = TextStyle(fontFamily: "Poppins-Medium");
