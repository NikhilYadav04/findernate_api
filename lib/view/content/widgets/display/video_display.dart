import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:visibility_detector/visibility_detector.dart';

class FeedPlayer extends StatefulWidget {
  final String videoURL;
  final String? thumbNailURL;

  const FeedPlayer({
    Key? key,
    required this.videoURL,
    required this.thumbNailURL,
  }) : super(key: key);

  @override
  State<FeedPlayer> createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  late BetterPlayerController _betterPlayerController;
  bool _isPlaying = false;
  bool _isMuted = false;
  bool _hasFinished = false;

  // Track playback position and total duration
  Duration _position = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _isMuted = false;
    _hasFinished = false;
    _initializePlayer();
  }

  void _initializePlayer() {
    final dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoURL,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
      ),
      placeholder: widget.thumbNailURL != null
          ? Image.network(widget.thumbNailURL!, fit: BoxFit.cover)
          : null,
      bufferingConfiguration: BetterPlayerBufferingConfiguration(
        minBufferMs: 20000,
        maxBufferMs: 50000,
        bufferForPlaybackMs: 1000,
        bufferForPlaybackAfterRebufferMs: 2000,
      ),
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: false,
        looping: false,
        autoDispose: true,
        aspectRatio: 9 / 16,
        fit: BoxFit.cover,
        handleLifecycle: true,
        showPlaceholderUntilPlay: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
          loadingWidget: Center(
            child: SpinKitCircle(
              color: Color(0xFFFCD45C),
              size: 35,
            ),
          ),
        ),
      ),
      betterPlayerDataSource: dataSource,
    );

    // Listen to player events
    _betterPlayerController.addEventsListener((event) {
      switch (event.betterPlayerEventType) {
        case BetterPlayerEventType.play:
          setState(() {
            _isPlaying = true;
            _hasFinished = false;
          });
          break;
        case BetterPlayerEventType.pause:
          setState(() => _isPlaying = false);
          break;
        case BetterPlayerEventType.finished:
          _betterPlayerController.pause();
          setState(() {
            _isPlaying = false;
            _hasFinished = true;
          });
          break;
        default:
          break;
      }
    });

    // Track playback position and total duration
    _betterPlayerController.videoPlayerController?.addListener(() {
      final pos = _betterPlayerController.videoPlayerController!.value.position;
      final tot = _betterPlayerController.videoPlayerController!.value.duration;
      setState(() {
        _position = pos;
        _totalDuration = tot!;
      });
    });
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = d.inHours;
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    } else {
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(_betterPlayerController),
      onVisibilityChanged: (visibility) {
        final visible = visibility.visibleFraction;
        if (visible > 0.8 && !_isPlaying && !_hasFinished) {
          _betterPlayerController.play();
        } else if (visible <= 0.8 && _isPlaying) {
          _betterPlayerController.pause();
        }
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BetterPlayer(controller: _betterPlayerController),
          ),

          // Duration display at top center
          if (_totalDuration > Duration.zero)
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${_formatDuration(_position)} / ${_formatDuration(_totalDuration)}',
                  style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      color: Colors.white,
                      fontSize: 14),
                ),
              ),
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () async {
                      if (_isPlaying) {
                        await _betterPlayerController.pause();
                      } else {
                        if (_hasFinished) {
                          await _betterPlayerController.seekTo(Duration.zero);
                          setState(() => _hasFinished = false);
                        }
                        await _betterPlayerController.play();
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () async {
                      if (_isMuted) {
                        await _betterPlayerController.setVolume(1.0);
                      } else {
                        await _betterPlayerController.setVolume(0.0);
                      }
                      setState(() => _isMuted = !_isMuted);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
