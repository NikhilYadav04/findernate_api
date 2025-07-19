import 'package:flutter/material.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/constants/appImages.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';

Widget homeAppBar(
    {required String unreadCount,
    required double maxHeight,
    required double maxWidth,
    required VoidCallback onTap1,
    required VoidCallback onTap2,
    required BuildContext context}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: maxWidth * 0.025),
    height: maxHeight * 0.095,
    width: double.infinity,
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: onTap1,
            child: Image.asset(
              AppImages.appBarLogo,
              scale: 0.8,
              color: Color.fromARGB(255, 228, 167, 76),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () async {},
                  child: badgeWidget(unreadCount,
                      "assets/images/svg/ic_notify.svg", maxHeight, maxWidth)),
              SizedBox(
                width: maxWidth * 0.04,
              ),
              //* Nav to Messages Page
              GestureDetector(
                onTap: onTap2,
                child: badgeWidget(unreadCount, "assets/images/svg/ic_chat.svg",
                    maxHeight, maxWidth),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget badgeWidget(
  String count,
  String imagePath, // Use image path instead of IconData
  double maxHeight,
  double maxWidth,
) {
  return count == "0"
      ? SvgPicture.asset(
          imagePath,
          height: maxHeight * 0.038,
          width: maxHeight * 0.038,
          fit: BoxFit.contain,
          color: Color.fromARGB(255, 228, 167, 76),
        )
      : badges.Badge(
          badgeContent: Center(
            child: Text(
              count,
              style: _textStyle2.copyWith(
                color: Colors.black,
                fontSize: maxHeight * 0.015,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          position: badges.BadgePosition.topEnd(
            top: -maxHeight * 0.017,
            end: -maxWidth * 0.01,
          ),
          showBadge: true,
          ignorePointer: false,
          badgeStyle: badges.BadgeStyle(
            borderSide: BorderSide(style: BorderStyle.solid, width: 1),
            padding: EdgeInsets.all(maxHeight * 0.006),
            shape: badges.BadgeShape.circle,
            borderRadius: BorderRadius.circular(maxHeight * 0.012),
            borderGradient: badges.BadgeGradient.linear(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white], // pure white border
            ),
            badgeGradient: badges.BadgeGradient.linear(
                begin: Alignment.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [AppColors.appGradient1, AppColors.appGradient2]),
            elevation: 0,
          ),
          child: SvgPicture.asset(
            imagePath,
            height: maxHeight * 0.038,
            width: maxHeight * 0.038,
            fit: BoxFit.contain,
            color: Color.fromARGB(255, 228, 167, 76),
          ),
        );
}

TextStyle _textStyle2 = TextStyle(fontFamily: "Poppins-Medium");
