import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/images.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

class DiscoverPost extends StatelessWidget {
  const DiscoverPost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          Container(
            // 아래 아마자둘운 container를 overflow하기 때문에
            // borderRadius를 적용하려면 clip.hardEdge가 필요함
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Sizes.size4),
            ),
            child: AspectRatio(
              aspectRatio: 9 / 16,
              // image 로딩 되는 동안 placeholder 렌더
              child: FadeInImage.assetNetwork(
                // 어떻게 맞출 지 옵션
                fit: BoxFit.cover,
                placeholder: defaultImgPlaceholder,
                image: defaultGridImg,
              ),
            ),
          ),
          Gaps.v10,
          const Text(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            "This is a very long caption for my tiktok that I'm uploading right now",
            style: TextStyle(
              fontSize: Sizes.size18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.v8,
          if (constraints.maxWidth < 200 || constraints.maxWidth > 250)
            DefaultTextStyle(
              style: TextStyle(
                color: isDarkMode(context)
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
                fontSize: Sizes.size12,
                fontWeight: FontWeight.bold,
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(defaultImg),
                    radius: 12,
                  ),
                  Gaps.h4,
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      "A very very very very very long text",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gaps.h4,
                  FaIcon(
                    FontAwesomeIcons.heart,
                    color: Colors.grey,
                    size: Sizes.size14,
                  ),
                  Gaps.h3,
                  Text(
                    "2.0M",
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
