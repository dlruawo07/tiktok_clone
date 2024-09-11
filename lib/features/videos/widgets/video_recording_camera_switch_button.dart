import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/flash.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/camera_flash_mode_button.dart';

class VideoRecordingCameraSwitchButton extends StatelessWidget {
  const VideoRecordingCameraSwitchButton({
    super.key,
    required this.flashMode,
    required this.toggleSelfieMode,
    required this.setFlashMode,
  });

  final FlashMode flashMode;
  final Function() toggleSelfieMode;
  final Function setFlashMode;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: Sizes.size40,
      right: Sizes.size5,
      child: Column(
        children: [
          IconButton(
            color: Colors.white,
            onPressed: toggleSelfieMode,
            icon: const Icon(
              Icons.cameraswitch,
            ),
          ),
          for (var i = 0; i < Flash.icons.length; i++)
            FlashModeButton(
              isSelected: flashMode == Flash.modes[i],
              onPressed: () => setFlashMode(Flash.modes[i]),
              icon: Flash.icons[i],
            ),
        ],
      ),
    );
  }
}
