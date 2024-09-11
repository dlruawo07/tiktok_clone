import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class VideoPostAnimatedPlayButton extends StatelessWidget {
  const VideoPostAnimatedPlayButton({
    super.key,
    required this.animationController,
    required this.isPaused,
    required this.animationDuration,
  });

  final AnimationController animationController;
  final bool isPaused;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      // Event가 Icon으로 가는 것을 무시함
      child: IgnorePointer(
        // 사이즈 변화
        // animationController의 변화를 감지하는 방법 2
        child: AnimatedBuilder(
          animation: animationController,
          // animation의 변화를 감지하고 무언가를 수행하는 함수
          builder: (context, child) {
            return Transform.scale(
              scale: animationController.value,
              // child = 아래의 AnimatedOpacity 위젯
              child: AnimatedOpacity(
                opacity: isPaused ? 1 : 0,
                duration: animationDuration,
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.play,
                    color: Colors.white,
                    size: Sizes.size52,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
