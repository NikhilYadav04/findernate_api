import 'package:flutter/material.dart';
import 'package:social_media_clone/model/user/posts/model_post.dart';

class PreviewContent extends StatelessWidget {
  final double sh;
  final double sw;
  final PostModel list;

  const PreviewContent({
    Key? key,
    required this.sh,
    required this.sw,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(horizontal: sw * 0.03),
        height: sh * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
                color: Colors.grey.shade800,
              ),
              height: sh * 0.08,
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: sh * 0.03,
                      backgroundImage: NetworkImage(list.createdByImageURL),
                    ),
                    SizedBox(width: sw * 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ypd_774",
                          style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            color: Colors.white,
                            fontSize: sh * 0.022,
                          ),
                        ),
                        Text(
                          "Mumbai, India",
                          style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            color: Colors.grey.shade300,
                            fontSize: sh * 0.015,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    )),
                width: double.infinity,
                child: Image.network(
                  list.mediaUrl[0],
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // you can add more widgets below if needed
          ],
        ),
      ),
    );
  }
}
