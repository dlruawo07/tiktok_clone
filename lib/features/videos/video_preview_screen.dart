import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

// NOTE: 라이브러리 시 ios/Runner/Info.plist에 아래 줄 추가
// <key>NSPhotoLibraryUsageDescription</key>
// <string>Allow photo library</string>

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;
  bool _savedVideo = false;

  Future<void> _initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) {
      return;
    }

    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: "TikTok Clone",
    );

    _savedVideo = true;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: Icon(
                _savedVideo ? Icons.check_rounded : Icons.save_alt_rounded,
              ),
            ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}
