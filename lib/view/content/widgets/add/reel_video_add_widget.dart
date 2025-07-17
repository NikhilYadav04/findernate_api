import 'package:flutter/material.dart';
import 'package:social_media_clone/controller/content/content_controller.dart';
import 'package:social_media_clone/core/constants/appColors.dart';
import 'package:social_media_clone/view/content/screens/reel/video_picker.dart';
import 'dart:io';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/svg.dart';

class ReelAddWidget extends StatefulWidget {
  final double maxHeight;
  final double maxWidth;
  final ProviderContent provider;

  const ReelAddWidget({
    Key? key,
    required this.maxHeight,
    required this.maxWidth,
    required this.provider,
  }) : super(key: key);

  @override
  State<ReelAddWidget> createState() => _ReelAddWidgetState();
}

class _ReelAddWidgetState extends State<ReelAddWidget> {
  VideoPlayerController? _videoController;

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _pickAndPlayVideo() async {
    File? video = await pickVideo(context);
    if (video != null) {
      await widget.provider.pickReelVideo(video);
      _videoController?.dispose();
      _videoController = VideoPlayerController.file(video)
        ..initialize().then((_) {
          setState(() {});
          _videoController?.setLooping(true);
          _videoController?.play();
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;
    final hasVideo = provider.videoFile != null;

    return hasVideo
        ? GestureDetector(
            onDoubleTap: _pickAndPlayVideo,
            child: Container(
              width: double.infinity,
              height: widget.maxHeight * 0.40,
              decoration: BoxDecoration(
                color: Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(widget.maxHeight * 0.01),
                border: Border.all(color: AppColors.borderColor1),
              ),
              child: _videoController != null &&
                      _videoController!.value.isInitialized
                  ? ClipRRect(
                      borderRadius:
                          BorderRadius.circular(widget.maxHeight * 0.01),
                      child: AspectRatio(
                        aspectRatio: _videoController!.value.aspectRatio,
                        child: GestureDetector(
                          onTap: () {
                            if (_videoController!.value.isPlaying) {
                              _videoController!.pause();
                            } else {
                              _videoController!.play();
                            }
                            setState(() {});
                          },
                          child: VideoPlayer(_videoController!),
                        ),
                      ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
          )
        : Container(
            width: double.infinity,
            height: widget.maxHeight * 0.25,
            decoration: BoxDecoration(
              color: Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(widget.maxHeight * 0.01),
              border: Border.all(color: AppColors.borderColor1),
            ),
            child: GestureDetector(
              onDoubleTap: _pickAndPlayVideo,
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: _pickAndPlayVideo,
                  child: SvgPicture.asset(
                    "assets/images/svg/ic_plus_blue.svg",
                    color: AppColors.borderColor1,
                    height: widget.maxHeight * 0.05,
                  ),
                ),
              ),
            ),
          );
  }
}
