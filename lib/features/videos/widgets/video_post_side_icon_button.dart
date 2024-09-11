import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class VideoPostSideIconButton extends StatelessWidget {
  const VideoPostSideIconButton({
    super.key,
    required this.icon,
    required this.text,
    this.color,
  });

  final IconData icon;
  final String text;
  final MaterialColor? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(
          icon,
          color: color ?? Colors.white,
          size: Sizes.size24,
        ),
        Gaps.v4,
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
