import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:social_media_clone/core/constants/appColors.dart';

class VideoPickerWidget extends StatefulWidget {
  final double sw;
  final double sh;
  final File? selectedVideo;
  final VoidCallback onTap;

  const VideoPickerWidget({
    Key? key,
    required this.sw,
    required this.sh,
    required this.selectedVideo,
    required this.onTap,
  }) : super(key: key);

  @override
  _VideoPickerWidgetState createState() => _VideoPickerWidgetState();
}

class _VideoPickerWidgetState extends State<VideoPickerWidget> {
  VideoPlayerController? _videoController;
  bool _isPlaying = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedVideo != null) {
      _initializeVideoPlayer();
    }
  }

  @override
  void didUpdateWidget(VideoPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedVideo != oldWidget.selectedVideo) {
      if (widget.selectedVideo != null) {
        _initializeVideoPlayer();
      } else {
        _disposeVideoPlayer();
      }
    }
  }

  void _initializeVideoPlayer() async {
    if (widget.selectedVideo == null) return;

    setState(() {
      _isLoading = true;
    });

    _disposeVideoPlayer();

    _videoController = VideoPlayerController.file(widget.selectedVideo!);

    try {
      await _videoController!.initialize();
      _videoController!.addListener(() {
        if (mounted) {
          setState(() {
            _isPlaying = _videoController!.value.isPlaying;
          });
        }
      });
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error initializing video: $e');
    }
  }

  void _disposeVideoPlayer() {
    _videoController?.dispose();
    _videoController = null;
  }

  void _togglePlayPause() {
    if (_videoController == null) return;

    setState(() {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    });
  }

  @override
  void dispose() {
    _disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Video',
          style: TextStyle(
            fontSize: widget.sh * 0.02,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: widget.sh * 0.015),
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: double.infinity,
            height: widget.selectedVideo == null
                ? widget.sh * 0.3
                : widget.sh * 0.45,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade500,
                width: 1.0,
              ),
            ),
            child: widget.selectedVideo == null
                ? Padding(
                    padding: EdgeInsets.all(widget.sw * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Video Camera Icon - Bigger and Darker
                        Container(
                          width: widget.sw * 0.16,
                          height: widget.sw * 0.16,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.videocam_outlined,
                            color: Colors.grey.shade600,
                            size: widget.sw * 0.08,
                          ),
                        ),
                        SizedBox(height: widget.sh * 0.02),

                        // Title - Darker
                        Text(
                          'Add Videos',
                          style: TextStyle(
                            fontSize: widget.sh * 0.02,
                            fontFamily: 'Poppins-SemiBold',
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(height: widget.sh * 0.008),

                        // Subtitle - Darker
                        Flexible(
                          child: Text(
                            'Upload up to 1 video (MP4, MOV, AVI - max 50MB each)',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: widget.sh * 0.014,
                              fontFamily: 'Poppins-Regular',
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                          ),
                        ),
                        SizedBox(height: widget.sh * 0.02),

                        // Add Video Button with Gradient
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: widget.sw * 0.05,
                            vertical: widget.sh * 0.01,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                              colors: [
                                AppColors.appGradient1,
                                AppColors.appGradient2,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.appGradient1.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.video_library_outlined,
                                color: Colors.white,
                                size: widget.sh * 0.018,
                              ),
                              SizedBox(width: widget.sw * 0.015),
                              Text(
                                'Add Video',
                                style: TextStyle(
                                  fontSize: widget.sh * 0.016,
                                  fontFamily: 'Poppins-Medium',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Stack(
                      children: [
                        // Video Player
                        if (_videoController != null &&
                            _videoController!.value.isInitialized)
                          Positioned.fill(
                            child: AspectRatio(
                              aspectRatio: _videoController!.value.aspectRatio,
                              child: VideoPlayer(_videoController!),
                            ),
                          )
                        else
                          // Loading or placeholder
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: AppColors.black.withOpacity(0.8),
                            child: Center(
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      color: AppColors.white,
                                    )
                                  : Icon(
                                      Icons.video_file,
                                      color: AppColors.white,
                                      size: widget.sw * 0.18,
                                    ),
                            ),
                          ),

                        // Play/Pause Button Overlay
                        if (_videoController != null &&
                            _videoController!.value.isInitialized)
                          Positioned.fill(
                            child: GestureDetector(
                              onTap: _togglePlayPause,
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: AnimatedOpacity(
                                    opacity: _isPlaying ? 0.0 : 1.0,
                                    duration: Duration(milliseconds: 300),
                                    child: Container(
                                      width: widget.sw * 0.15,
                                      height: widget.sw * 0.15,
                                      decoration: BoxDecoration(
                                        color: AppColors.black.withOpacity(0.7),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        _isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: AppColors.white,
                                        size: widget.sw * 0.08,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        // Video Controls Overlay
                        if (_videoController != null &&
                            _videoController!.value.isInitialized)
                          Positioned(
                            bottom: 8,
                            left: 8,
                            right: 8,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: widget.sw * 0.02,
                                vertical: widget.sh * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.videocam,
                                    color: AppColors.white,
                                    size: widget.sh * 0.015,
                                  ),
                                  SizedBox(width: widget.sw * 0.01),
                                  Text(
                                    'Video',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: widget.sh * 0.012,
                                      fontFamily: 'Poppins-Medium',
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '${_formatDuration(_videoController!.value.position)} / ${_formatDuration(_videoController!.value.duration)}',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: widget.sh * 0.01,
                                      fontFamily: 'Poppins-Medium',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        // Change Video Button
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: widget.onTap,
                            child: Container(
                              padding: EdgeInsets.all(widget.sw * 0.02),
                              decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: AppColors.white,
                                size: widget.sh * 0.02,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
