import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/core/router/appRouter.dart';
import 'package:social_media_clone/core/utils/dateFormatter.dart';

class StoryBar extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;

  const StoryBar({
    Key? key,
    required this.maxHeight,
    required this.maxWidth,
  }) : super(key: key);

  @override
  State<StoryBar> createState() => _StoryBarState();
}

class _StoryBarState extends State<StoryBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      color: Colors.white,
      height: widget.maxHeight * 0.08,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.maxWidth * 0.03),
        itemCount: 7,
        separatorBuilder: (context, index) => SizedBox(width: widget.maxWidth * 0.02),
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () async {
                // final yellowCanvasPath = await createFullScreenCanvasFile();

                Navigator.pushNamed(
                  context,
                  '/add-story-screen',
                  arguments: {
                    'transition': TransitionType.fade,
                    'duration': 300,
                    'title': 'Edit This Story',
                    // 'imagePath': yellowCanvasPath,
                    'middleBottomWidget': Center(
                      child: FittedBox(
                        child: Text(
                          "Edit Your Story",
                          style: TextStyle(
                              fontFamily: "Poppins-Medium",
                              color: Colors.white,
                              fontSize: widget.maxHeight * 0.022),
                        ),
                      ),
                    ),
                    'onDoneButtonStyle': Container(
                      margin: EdgeInsets.only(right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      height: widget.maxHeight * 0.048,
                      width: widget.maxWidth * 0.1,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: widget.maxHeight * 0.02,
                      ),
                    )
                  },
                );
                final date = DateFormatter.showUserStatus(DateTime.now());
                var logger = Logger();
                logger.d(date);
              },
              child: Container(
                width: (widget.maxHeight * 0.0378) * 2, // diameter
                height: (widget.maxHeight * 0.0378) * 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [AppColors.appGradient1, AppColors.appGradient2]),
                  shape: BoxShape.circle,
                
                ),
                child: Center(
                  child: SvgPicture.asset("assets/images/svg/ic_plus.svg",
                      color: Colors.black,
                      width: widget.maxWidth * 0.2,
                      height: widget.maxHeight * 0.04),
                ),
              ),
            );
          }
          return Stack(
            alignment: Alignment.center,
            children: [
              InkWell(
                onTap: () {
                  //* Navigate to story view
                  Navigator.pushNamed(context, '/story-view', arguments: {
                    'transition': TransitionType.fade,
                    'duration': 200,
                  });
                },
                child: Container(
                  width: widget.maxHeight * 0.085,
                  height: widget.maxHeight * 0.085,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF58529), // orange
                        Color(0xFFDD2A7B), // pink
                        Color(0xFF8134AF), // purple
                        Color(0xFF515BD4), // blue
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: CircleAvatar(
                        radius: widget.maxHeight * 0.0385,
                        backgroundImage:
                            AssetImage("assets/images/user/${index}.jpeg"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}