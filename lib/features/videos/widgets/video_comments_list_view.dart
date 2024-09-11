import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

// TODO: Try comments as likes (no fake data: Avatar, creator, text, likes)
class VideoCommentsListView extends StatelessWidget {
  const VideoCommentsListView({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.only(
        top: Sizes.size10,
        left: Sizes.size16,
        right: Sizes.size16,
        bottom: Sizes.size96 + Sizes.size32,
      ),
      // itemBuilder로 생기는 item들 사이마다
      separatorBuilder: (context, index) => Gaps.v20,
      itemCount: 10,
      itemBuilder: (context, index) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            child: Text("A"),
          ),
          Gaps.h10,
          // 줄바꿈
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Test",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade500,
                  ),
                ),
                Gaps.v3,
                const Text(
                  "That's not it I've seen the same thing but also in a cave.",
                ),
              ],
            ),
          ),
          Gaps.h10,
          Column(
            children: [
              FaIcon(
                FontAwesomeIcons.heart,
                size: Sizes.size20,
                color: Colors.grey.shade500,
              ),
              Gaps.v2,
              Text(
                "52.2K",
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
