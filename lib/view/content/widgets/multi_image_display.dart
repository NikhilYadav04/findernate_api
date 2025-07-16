import 'package:flutter/material.dart';
import 'package:social_media_clone/controller/content/content_controller.dart';
import 'dart:io';

import 'package:social_media_clone/core/constants/appColors.dart';

import 'package:flutter_svg/svg.dart';
import 'package:social_media_clone/view/content/widgets/multi_image_picker.dart';

class PostAddImageWidget extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;
  final ProviderContent provider;

  const PostAddImageWidget({
    Key? key,
    required this.provider,
    required this.maxHeight,
    required this.maxWidth,
  }) : super(key: key);

  @override
  State<PostAddImageWidget> createState() => _PostAddImageWidgetState();
}

class _PostAddImageWidgetState extends State<PostAddImageWidget> {
  @override
  Widget build(BuildContext context) {
    final length = widget.provider.imageFiles?.length ?? 0;
    

    return length == 0
        ? Container(
            width: double.infinity,
            height: widget.maxHeight * 0.25,
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(widget.maxHeight * 0.01),
              border: Border.all(color: AppColors.borderColor1),
            ),
            child: IconButton(
              onPressed: () async {
                List<File>? images = await pickImages(context, 3, true);
                await widget.provider.pickImageFromGallery(images);
                setState(() {});
              },
              icon: Center(
                child: SvgPicture.asset(
                  "assets/images/svg/ic_plus_blue.svg",
                  color: AppColors.borderColor1,
                  height: widget.maxHeight * 0.05,
                ),
              ),
            ))
        : GestureDetector(
            onDoubleTap: () async {
              List<File>? images = await pickImages(context, 3, true);
              await widget.provider.pickImageFromGallery(images);
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              height: widget.maxHeight * 0.40,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(widget.maxHeight * 0.01),
                border: Border.all(color: Colors.grey.shade500),
              ),
              child: PageView.builder(
                itemCount: widget.provider.imageFiles?.length ?? 0,
                itemBuilder: (context, index) {
                  final imageFile = widget.provider.imageFiles?[index];
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(widget.maxHeight * 0.01),
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                },
              ),
            ));
  }
}
