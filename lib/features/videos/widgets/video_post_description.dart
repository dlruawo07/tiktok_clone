import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideoPostDescription extends StatelessWidget {
  const VideoPostDescription({
    super.key,
    required this.videoData,
  });

  final VideoModel videoData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "@${videoData.creator}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.v6,
          Text(
            videoData.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: Sizes.size12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
