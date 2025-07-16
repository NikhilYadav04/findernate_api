//* Pops up the gallery picker (no built‑in maxCount),
//* then limits the result to 3 files max.
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_plus/image_picker_plus.dart';
import 'package:logger/logger.dart';

Future<File?> pickVideo(BuildContext context) async {
  ImagePickerPlus picker = ImagePickerPlus(context);
  SelectedImagesDetails? details = await picker.pickBoth(
    source: ImageSource.both,
    multiSelection: false,
    galleryDisplaySettings: GalleryDisplaySettings(
      tabsTexts: _tabsTexts(1),
      appTheme: AppTheme(
        focusColor: Colors.white,
        primaryColor: Colors.black,
      ),
      cropImage: false,
      showImagePreview: true,
    ),
  );

  if (details == null) return null;

  // Filter selected files to get the first video
  final videoFile = details.selectedFiles.firstWhere(
    (e) {
      final path = e.selectedFile.path.toLowerCase();
      return path.endsWith('.mp4') ||
          path.endsWith('.mov') ||
          path.endsWith('.avi') ||
          path.endsWith('.wmv') ||
          path.endsWith('.mkv') ||
          path.endsWith('.flv') ||
          path.endsWith('.webm');
    },
    orElse: () => throw Exception("No video file selected."),
  ).selectedFile;

  var logger = Logger();
  logger.d("Picked video file: $videoFile");

  return videoFile;
}

TabsTexts _tabsTexts(int limit) {
  return TabsTexts(
    photoText: 'Camera',
    videoText: 'Video',

    galleryText: "Select a Video",
    // deletingText: "You Can Select At Most $limit Images",
    // clearImagesText: "You Can Select At Most $limit Images",
    // limitingText: "You Can Select At Most $limit Images",
  );
}
