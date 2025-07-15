import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

class WaterDropFAB extends StatefulWidget {
  final bool isVisible;
  final double sh;
  final double sw;
  final List<dynamic> _bottomCards;
  final List<VoidCallback> _navigationList;

  const WaterDropFAB({
    Key? key,
    required this.isVisible,
    required this.sh,
    required this.sw,
    required List<VoidCallback> navigationList,
    required List<dynamic> bottomCardsData,
  })  : _navigationList = navigationList,
        _bottomCards = bottomCardsData,
        super(key: key);

  @override
  State<WaterDropFAB> createState() => _WaterDropFABState();
}

class _WaterDropFABState extends State<WaterDropFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    if (widget.isVisible) _controller.forward();
  }

  @override
  void didUpdateWidget(covariant WaterDropFAB oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          height: widget.sh * 0.072,
          width: widget.sw * 0.162,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                backgroundColor: Colors.white,
                builder: (context) {
                  return Container(
                    height: widget.sh * 0.44,
                    padding: EdgeInsets.symmetric(
                      vertical: widget.sh * 0.02,
                      horizontal: widget.sw * 0.04,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 15,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                              colors: [
                                AppColors.appGradient1,
                                AppColors.appGradient2,
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: widget.sw * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Create",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins-Medium",
                                  fontSize: widget.sh * 0.025,
                                  color: Colors.black,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(
                                  Icons.close,
                                  size: widget.sh * 0.03,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              childAspectRatio: 1.8,
                            ),
                            itemCount: widget._bottomCards.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.appGradient1,
                                      AppColors.appGradient2
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: widget._navigationList[index],
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            widget._bottomCards[index].svgUrl,
                                            color: Colors.white,
                                            height: widget.sh * 0.04,
                                          ),
                                          const SizedBox(height: 8.0),
                                          Text(
                                            widget._bottomCards[index].label,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Poppins-Medium",
                                              fontSize: widget.sh * 0.02,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.appGradient1,
                    AppColors.appGradient2,
                  ],
                ),
                borderRadius: BorderRadius.circular(widget.sh * 0.04),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/svg/ic_plus.svg",
                  color: Colors.black,
                  width: widget.sw * 0.2,
                  height: widget.sh * 0.05,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}