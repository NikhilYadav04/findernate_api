import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media_clone/model/bottom_bar/model_bottom_bar_items.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

List<BottomBarItem> bottomItems = [
  BottomBarItem(
    icon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[0].unselectedIconPath),
    ),
    selectedIcon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[0].selectedIconPath),
    ),
    selectedColor: Colors.white,
    unSelectedColor: Colors.white,
    title: const Text(''),
  ),
  BottomBarItem(
    icon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[1].unselectedIconPath),
    ),
    selectedIcon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[1].unselectedIconPath),
    ),
    selectedColor: Colors.white,
    unSelectedColor: Colors.white,
    title: const Text(''),
  ),
  BottomBarItem(
    icon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[2].unselectedIconPath),
    ),
    selectedIcon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[2].selectedIconPath),
    ),
    selectedColor: Colors.white,
    unSelectedColor: Colors.white,
    title: const Text(''),
  ),
  BottomBarItem(
    icon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[3].unselectedIconPath),
    ),
    selectedIcon: SizedBox(
      height: 28,
      width: 28,
      child: SvgPicture.asset(bottomBarItems[3].selectedIconPath),
    ),
    selectedColor: Colors.white,
    unSelectedColor: Colors.white,
    title: const Text(''),
  ),
];

class BottomCardModel {
  final String svgUrl;
  final String label;

  BottomCardModel({required this.svgUrl, required this.label});
}

List<BottomCardModel> bottomCards = [
  BottomCardModel(
    svgUrl: 'assets/svg/camera.svg', // dummy local SVG path
    label: 'Upload Post',
  ),
  BottomCardModel(
    svgUrl: 'assets/images/main/ic_reel.svg', // dummy local SVG path
    label: 'Create Reel',
  ),
    BottomCardModel(
    svgUrl: 'assets/images/main/ic_reel.svg', // dummy local SVG path
    label: 'Go Live',
  ),
    BottomCardModel(
    svgUrl: 'assets/svg/camera.svg', // dummy local SVG path
    label: 'Business',
  ),
];
