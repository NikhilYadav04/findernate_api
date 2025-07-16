import 'dart:io';

import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

//* Pops up the gallery picker (no built‑in maxCount),
//* then limits the result to 3 files max.
Future<List<File>?> pickImages(BuildContext context, int limit,bool multi) async {
  ImagePickerPlus picker = ImagePickerPlus(context);
  SelectedImagesDetails? details = await picker.pickBoth(
    source: ImageSource.both,
    multiSelection: multi,
    galleryDisplaySettings: GalleryDisplaySettings(
      tabsTexts: _tabsTexts(limit),
      appTheme: AppTheme(
        focusColor: Colors.white,
        primaryColor: Colors.black,
      ),
      cropImage: true,
      showImagePreview: true,
    ),
  );

  if (details == null) return null;

  //* Take only the first 3 files they selected:
  var onlyImages = details.selectedFiles
      .where((e) {
        final path = e.selectedFile.path.toLowerCase();
        return path.endsWith('.jpg') ||
            path.endsWith('.jpeg') ||
            path.endsWith('.png') ||
            path.endsWith('.gif') ||
            path.endsWith('.bmp') ||
            path.endsWith('.webp');
      })
      .take(limit)
      .map((e) => e.selectedFile)
      .toList();

  var logger = Logger();
  logger.d("Picked image files: $onlyImages");

  return onlyImages;
}

//* Example button that calls pickImages() and prints the result.
ElevatedButton preview1(BuildContext context) {
  return ElevatedButton(
    onPressed: () async {
      List<File>? files = await pickImages(context, 3,true);

      if (files != null && files.isNotEmpty) {
        print("Selected files (max ): $files");
        // handle your List<File> here
      } else {
        return;
      }
    },
    child: const Text("Preview 1"),
  );
}

TabsTexts _tabsTexts(int limit) {
  return TabsTexts(
    photoText: 'Camera',
    videoText: 'Video',

    galleryText: "Select $limit Image",
    // deletingText: "You Can Select At Most $limit Images",
    // clearImagesText: "You Can Select At Most $limit Images",
    // limitingText: "You Can Select At Most $limit Images",
  );
}

Future<void> displayDetails(
    SelectedImagesDetails details, BuildContext context) async {
  await Navigator.of(context).push(
    CupertinoPageRoute(
      builder: (context) {
        return DisplayImages(
            selectedBytes: details.selectedFiles,
            details: details,
            aspectRatio: details.aspectRatio);
      },
    ),
  );
}

class DisplayImages extends StatefulWidget {
  final List<SelectedByte> selectedBytes;
  final double aspectRatio;
  final SelectedImagesDetails details;
  const DisplayImages({
    Key? key,
    required this.details,
    required this.selectedBytes,
    required this.aspectRatio,
  }) : super(key: key);

  @override
  State<DisplayImages> createState() => _DisplayImagesState();
}

class _DisplayImagesState extends State<DisplayImages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selected images/videos')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          SelectedByte selectedByte = widget.selectedBytes[index];
          if (!selectedByte.isThatImage) {
            return Container(
              child: Center(
                child: Text("Videos feature not implemented"),
              ),
            );
          } else {
            return SizedBox(
              width: double.infinity,
              child: Image.file(selectedByte.selectedFile),
            );
          }
        },
        itemCount: widget.selectedBytes.length,
      ),
    );
  }
}
