import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post_side_icon_button.dart';

class VideoPostSideIconBar extends StatelessWidget {
  const VideoPostSideIconBar({
    super.key,
    required this.videoData,
    required this.isLiked,
    required this.likeCount,
    required this.onToggleHeart,
    required this.onCommentsTap,
  });

  final VideoModel videoData;
  final bool isLiked;
  final int likeCount;
  final Function() onToggleHeart;
  final Function onCommentsTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 10,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            foregroundImage: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/tik-tok-52296.appspot.com/o/avatars%2F${videoData.creatorUid}?alt=media&token=b79558d3-bf90-4773-a0ff-247ef62e2b31&nocaching=${DateTime.now().toString()}",
            ),
            child: Text(
              videoData.creator,
              style: const TextStyle(
                fontSize: Sizes.size8,
              ),
            ),
          ),
          Gaps.v44,
          GestureDetector(
            onTap: onToggleHeart,
            child: VideoPostSideIconButton(
              icon: FontAwesomeIcons.solidHeart,
              color: isLiked ? Colors.red : null,
              text: "$likeCount likes",
            ),
          ),
          Gaps.v44,
          GestureDetector(
            onTap: () => onCommentsTap(context),
            child: VideoPostSideIconButton(
              icon: FontAwesomeIcons.solidComment,
              text: "${videoData.comments} comments",
            ),
          ),
          Gaps.v44,
          const VideoPostSideIconButton(
            icon: FontAwesomeIcons.share,
            text: "Share",
          ),
        ],
      ),
    );
  }
}
