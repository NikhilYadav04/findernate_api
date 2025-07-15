//* SHow Popup Card

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

void showPopup(
    {required BuildContext context,
    required double maxHeight,
    required double maxWidth,
    required String title,
    required String desc,
    required String label1,
    required String label2,
    required VoidCallback onTap1,
    required VoidCallback onTap2}) {
  Alert(
    closeIcon: Icon(
      Icons.close,
      color: Colors.black,
      size: maxHeight * 0.04,
    ),
    context: context,
    type: AlertType.warning,
    title: title,
    style: AlertStyle(
        isTitleSelectable: true,
        isDescSelectable: true,
        isOverlayTapDismiss: true,
        backgroundColor: Colors.white,
        titleStyle: TextStyle(
          fontFamily: "Poppins-Medium",
          fontWeight: FontWeight.bold,
          fontSize: maxHeight * 0.035,
          color: Colors.black,
        ),
        descStyle: TextStyle(
          fontFamily: "Poppins-Medium",
          fontSize: maxHeight * 0.025,
          color: Colors.grey.shade800,
        )),
    desc: desc,
    buttons: [
      DialogButton(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: AlignmentDirectional.bottomCenter,
            colors: [
              AppColors.appGradient1,
              AppColors.appGradient2,
            ]),
        radius: BorderRadius.circular(maxHeight * 0.01),
        height: maxHeight * 0.05,
        width: maxWidth * 0.04,
        child: Center(
          child: Text(
            label1,
            style: TextStyle(
              color: Colors.white,
              fontSize: maxHeight * 0.028,
              fontFamily: "Poppins-Medium",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onPressed: onTap1,
        color: AppColors.appYellow,
      ),
      DialogButton(
        border: Border.all(color: Colors.black, width: 1),
        height: maxHeight * 0.05,
        width: maxWidth * 0.04,
        child: Text(
          label2,
          style: TextStyle(
            color: Colors.black,
            fontSize: maxHeight * 0.028,
            fontFamily: "Poppins-Medium",
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onTap2,
        color: Colors.transparent,
      )
    ],
  ).show();
}
