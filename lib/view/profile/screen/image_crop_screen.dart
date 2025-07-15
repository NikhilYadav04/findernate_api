// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:custom_image_crop/custom_image_crop.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:social_media_clone/controller/profile/profile_controller.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/view/auth/widgets/auth_widgets_3.dart';

class SimpleCropScreen extends StatefulWidget {
  final File image;
  final ProviderProfile provider;

  final CustomCropShape shape;
  final Ratio? ratio;

  const SimpleCropScreen({
    Key? key,
    required this.image,
    required this.provider,
    this.shape = CustomCropShape.Circle,
    this.ratio,
  }) : super(key: key);

  @override
  _SimpleCropScreenState createState() => _SimpleCropScreenState();
}

class _SimpleCropScreenState extends State<SimpleCropScreen> {
  late CustomImageCropController _controller;
  CustomImageFit _imageFit = CustomImageFit.fillCropSpace;

  @override
  void initState() {
    super.initState();
    _controller = CustomImageCropController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //* Convert cropped image bytes to file
  Future<String?> _cropAndSaveToFile() async {
    final cropResult = await _controller.onCropImage();
    final Uint8List? croppedBytes = await cropResult?.bytes;
    if (croppedBytes == null) return null;

    final dir = await getTemporaryDirectory();
    final fileName = 'crop_${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(croppedBytes, flush: true);
    return file.path;
  }

  Future<void> _onCrop() async {
    //* Get the new file path
    final String? path = await _cropAndSaveToFile();
    if (path != null) {
      //* Now you have a real File
       widget.provider.imageFIle = File(path);
      Navigator.of(context).pop(path);
    } else {
      Navigator.of(context).pop(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: Center(
            child: Icon(
              Icons.arrow_back_ios,
              size: screenHeight * 0.035,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                _onCrop();
              },
              child: Center(
                child: Icon(
                  Icons.check,
                  size: screenHeight * 0.035,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
        centerTitle: true,
        title: postAddAppBar(
            maxHeight: screenHeight,
            maxWidth: screenWidth,
            title: 'Profile Picture'),
        toolbarHeight: screenHeight * 0.08,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            Expanded(
              child: CustomImageCrop(
                cropController: _controller,
                image: FileImage(widget.image),
                shape: widget.shape,
                ratio:
                    widget.shape == CustomCropShape.Ratio ? widget.ratio : null,
                canRotate: true,
                canMove: true,
                canScale: true,
                outlineColor: AppColors.appYellow,
                imageFit: _imageFit,
                imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              ),
            ),
            Container(
              color: AppColors.appYellow,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: _controller.reset,
                      iconSize: screenHeight * 0.04,
                      tooltip: 'Reset',
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_in),
                      onPressed: () =>
                          _controller.addTransition(CropImageData(scale: 1.25)),
                      iconSize: screenHeight * 0.04,
                      tooltip: 'Zoom In',
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_out),
                      onPressed: () =>
                          _controller.addTransition(CropImageData(scale: 0.8)),
                      iconSize: screenHeight * 0.04,
                      tooltip: 'Zoom Out',
                    ),
                    IconButton(
                      icon: const Icon(Icons.rotate_left),
                      onPressed: () => _controller
                          .addTransition(CropImageData(angle: -pi / 6)),
                      iconSize: screenHeight * 0.04,
                      tooltip: 'Rotate Left',
                    ),
                    IconButton(
                      icon: const Icon(Icons.rotate_right),
                      onPressed: () => _controller
                          .addTransition(CropImageData(angle: pi / 6)),
                      iconSize: screenHeight * 0.04,
                      tooltip: 'Rotate Right',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
