class ModelBottomBarItems {
  String selectedIconPath;
  String unselectedIconPath;
  ModelBottomBarItems({
    required this.selectedIconPath,
    required this.unselectedIconPath,
  });
}

List<ModelBottomBarItems> bottomBarItems = [
  ModelBottomBarItems(
    selectedIconPath: 'assets/images/main/ic_selected_home.svg',
    unselectedIconPath: 'assets/images/main/ic_home.svg',
  ),
  ModelBottomBarItems(
    selectedIconPath: 'assets/images/main/ic_selected_search.svg',
    unselectedIconPath: 'assets/images/main/ic_search.svg',
  ),
  ModelBottomBarItems(
    selectedIconPath: 'assets/images/main/ic_selected_reel.svg',
    unselectedIconPath: 'assets/images/main/ic_reel.svg',
  ),
  ModelBottomBarItems(
    selectedIconPath: 'assets/images/main/ic_selected_profile.svg',
    unselectedIconPath: 'assets/images/main/ic_profile.svg',
  ),
];
