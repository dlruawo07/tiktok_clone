import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/utils/get_size.dart';

class VideoRecordingBottomBar extends StatelessWidget {
  const VideoRecordingBottomBar({
    super.key,
    required this.startRecording,
    required this.stopRecording,
    required this.buttonAnimation,
    required this.progressAnimationController,
    required this.onAlbumTap,
  });

  final Function startRecording;
  final Function stopRecording;
  final Animation<double> buttonAnimation;
  final AnimationController progressAnimationController;
  final Function() onAlbumTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      width: getDeviceWidth(context),
      bottom: Sizes.size40,
      child: Row(
        children: [
          const Spacer(),
          GestureDetector(
            // TODO: CODE CHALLENGE - ZOOM IN/OUT WHEN SWIPE UP/DOWN WHILE TAPPING DOWN'
            // (onVerticalDragUpdate, DragUpdateDetails + _cameraController.getMaxZoomLevel,setZoomLevel)
            onTapDown: (details) => startRecording(),
            onTapUp: (details) => stopRecording(),
            child: ScaleTransition(
              scale: buttonAnimation,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: Sizes.size72,
                    height: Sizes.size72,
                    child: CircularProgressIndicator(
                      color: Colors.red.shade400,
                      strokeWidth: Sizes.size5,
                      value: progressAnimationController.value,
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
                onPressed: onAlbumTap,
                icon: const Icon(
                  Icons.image,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
