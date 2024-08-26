import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/camera_flash_mode_button.dart';

// NOTE: 카메라 & 마이크 사용 시 ios/Runner/Info.plist에 아래 줄 추가
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
  final _flashIcons = [
    Icons.flash_off_rounded,
    Icons.flash_on_rounded,
    Icons.flash_auto_rounded,
    Icons.flashlight_on_rounded,
  ];

  final _flashModes = [
    FlashMode.off,
    FlashMode.always,
    FlashMode.auto,
    FlashMode.torch
  ];

  late DateTime recordingStartTime;

  // ignore: unused_field
  bool _hasPermission = false;

  bool _isSelfieMode = false;

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

    // NOTE: ONLY FOR iOS (to fix sync issue)
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
    if (_cameraController.value.isRecordingVideo) {
      return;
    }

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
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
      // NOTE: ImageSource.camera - OS 카메라 사용
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
    initPermissions();

    // NOTE: application의 state 추적 (사용자가 앱을 나가거나 등)
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
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !_hasPermission || !_cameraController.value.isInitialized
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
                  Transform.scale(
                    scale: 1 /
                        (_cameraController.value.aspectRatio *
                            MediaQuery.of(context).size.aspectRatio),
                    child: CameraPreview(_cameraController),
                  ),
                  Positioned(
                    top: Sizes.size40,
                    right: Sizes.size5,
                    child: Column(
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: _toggleSelfieMode,
                          icon: const Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        for (var i = 0; i < _flashIcons.length; i++)
                          FlashModeButton(
                            isSelected: _flashMode == _flashModes[i],
                            onPressed: () => _setFlashMode(_flashModes[i]),
                            icon: _flashIcons[i],
                          ),
                      ],
                    ),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: Sizes.size40,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          // TODO: CODE CHALLENGE - ZOOM IN/OUT WHEN SWIPE UP/DOWN WHILE TAPPING DOWN'
                          // (onVerticalDragUpdate, DragUpdateDetails + _cameraController.getMaxZoomLevel,setZoomLevel)
                          onTapDown: (details) => _startRecording(),
                          onTapUp: (details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size60 + Sizes.size12,
                                  height: Sizes.size60 + Sizes.size12,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size5,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size64,
                                  height: Sizes.size64,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const Icon(
                                Icons.image,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
