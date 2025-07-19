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
    debugPrint(
        'VideoPickerWidget initState, video: ${widget.selectedVideo?.path}');
    _loadVideo();
  }

  @override
  void didUpdateWidget(VideoPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint(
        'didUpdateWidget, old: ${oldWidget.selectedVideo?.path}, new: ${widget.selectedVideo?.path}');
    if (widget.selectedVideo?.path != oldWidget.selectedVideo?.path) {
      _loadVideo();
    }
  }

  Future<void> _loadVideo() async {
    debugPrint('Loading video...');
    // Dispose old controller
    _disposeVideoPlayer();
    setState(() => _isLoading = widget.selectedVideo != null);
    debugPrint('isLoading set to $_isLoading');

    if (widget.selectedVideo != null) {
      debugPrint('Creating controller for ${widget.selectedVideo!.path}');
      _videoController = VideoPlayerController.file(widget.selectedVideo!);
      try {
        await _videoController!.initialize();
        debugPrint(
            'Video initialized, duration: ${_videoController!.value.duration}');
        _videoController!.setLooping(true);
        _videoController!.addListener(() {
          if (mounted) {
            final playing = _videoController!.value.isPlaying;
            if (playing != _isPlaying) {
              setState(() => _isPlaying = playing);
              debugPrint('Play state changed: $_isPlaying');
            }
          }
        });
      } catch (e) {
        debugPrint('Error initializing video: $e');
      }
    }

    setState(() => _isLoading = false);
    debugPrint('isLoading set to $_isLoading after init');
  }

  void _disposeVideoPlayer() {
    if (_videoController != null) {
      debugPrint('Disposing video controller');
      _videoController!.removeListener(() {});
      _videoController!.dispose();
      _videoController = null;
    }
  }

  void _togglePlayPause() {
    if (_videoController == null) return;
    final isPlaying = _videoController!.value.isPlaying;
    debugPrint('Toggling play/pause, currently: $isPlaying');
    setState(() {
      if (isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    });
  }

  @override
  void dispose() {
    debugPrint('VideoPickerWidget dispose');
    _disposeVideoPlayer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        'Building, selectedVideo: ${widget.selectedVideo?.path}, isLoading: $_isLoading');
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
          key: ValueKey(widget.selectedVideo?.path ?? 'no_video'),
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
                ? _buildPlaceholder()
                : _buildVideoPlayer(),
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Padding(
      padding: EdgeInsets.all(widget.sw * 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
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
          _buildAddButton(),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
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
    );
  }

  Widget _buildVideoPlayer() {
    if (_isLoading) {
      debugPrint('Showing loader');
      return Center(
        child: CircularProgressIndicator(color: AppColors.white),
      );
    }
    if (_videoController == null || !_videoController!.value.isInitialized) {
      debugPrint('Controller null or not initialized');
      return Center(
        child: Icon(Icons.video_file,
            color: AppColors.white, size: widget.sw * 0.18),
      );
    }
    debugPrint('Rendering video player');
    return Stack(
      children: [
        Positioned.fill(
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: AnimatedOpacity(
                  opacity: _isPlaying ? 0 : 1,
                  duration: Duration(milliseconds: 300),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.black54,
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: widget.onTap,
            child: Container(
              padding: EdgeInsets.all(widget.sw * 0.02),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.edit,
                  color: AppColors.white, size: widget.sh * 0.02),
            ),
          ),
        ),
      ],
    );
  }
}
