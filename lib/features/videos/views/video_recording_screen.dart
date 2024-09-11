import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/views/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/video_recording_bottom_bar.dart';
import 'package:tiktok_clone/features/videos/widgets/video_recording_camera_switch_button.dart';
import 'package:tiktok_clone/utils/get_size.dart';

// 카메라 & 마이크 사용 시 ios/Runner/Info.plist에 아래 줄 추가
// <key>NSCameraUsageDescription</key>
// <string>Allow camera</string>
// <key>NSMicrophoneUsageDescription</key>
// <string>Allow microphone</string>

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({
    super.key,
  });

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  late final bool _noCamera = kDebugMode && Platform.isIOS;
  late FlashMode _flashMode;
  late CameraController _cameraController;
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 300,
    ),
  );
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 10,
    ),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    // ONLY FOR iOS (to fix sync issue)
    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  Future<void> initPermissions() async {
    final camPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final camDenied =
        camPermission.isDenied || camPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!camDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    if (_flashMode == newFlashMode) {
      await _cameraController.setFlashMode(FlashMode.auto);
      _flashMode = FlashMode.auto;
    } else {
      await _cameraController.setFlashMode(newFlashMode);
      _flashMode = newFlashMode;
    }
    setState(() {});
  }

  Future<void> _startRecording() async {
    if (_noCamera) {
      return;
    }
    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (_noCamera) {
      return;
    }
    if (!_cameraController.value.isRecordingVideo) {
      return;
    }

    final video = await _cameraController.stopVideoRecording();

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    if (!mounted) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      // ImageSource.camera - OS 카메라 사용
      source: ImageSource.gallery,
    );
    if (video == null) {
      return;
    }

    if (!mounted) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) {
      return;
    }
    if (!_hasPermission) {
      return;
    }
    if (!_cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }

    // application의 state 추적 (사용자가 앱을 나가거나 등)
    WidgetsBinding.instance.addObserver(this);

    _progressAnimationController.addListener(() {
      setState(() {});
    });

    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: getDeviceWidth(context),
        height: getDeviceHeight(context),
        child: !_hasPermission
            ? const SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Initializing...",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size20,
                      ),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    Transform.scale(
                      scale: 1 /
                          (_cameraController.value.aspectRatio *
                              getDeviceAspectRatio(context)),
                      child: CameraPreview(_cameraController),
                    ),
                  const Positioned(
                    top: Sizes.size40,
                    left: Sizes.size10,
                    child: CloseButton(
                      color: Colors.white,
                    ),
                  ),
                  if (!_noCamera)
                    VideoRecordingCameraSwitchButton(
                      flashMode: _flashMode,
                      toggleSelfieMode: _toggleSelfieMode,
                      setFlashMode: _setFlashMode,
                    ),
                  VideoRecordingBottomBar(
                    startRecording: _startRecording,
                    stopRecording: _stopRecording,
                    buttonAnimation: _buttonAnimation,
                    progressAnimationController: _progressAnimationController,
                    onAlbumTap: _onPickVideoPressed,
                  ),
                ],
              ),
      ),
    );
  }
}
