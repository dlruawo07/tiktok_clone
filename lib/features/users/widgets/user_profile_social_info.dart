import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/user_count.dart';

class UserProfileSocialInfo extends StatelessWidget {
  const UserProfileSocialInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const UserCount(
            count: "97",
            category: "Following",
          ),
          VerticalDivider(
            thickness: Sizes.size1,
            width: Sizes.size32,
            color: Colors.grey.shade400,
            indent: Sizes.size14,
            endIndent: Sizes.size14,
          ),
          const UserCount(
            count: "10.5M",
            category: "Followers",
          ),
          VerticalDivider(
            thickness: Sizes.size1,
            width: Sizes.size32,
            color: Colors.grey.shade400,
            indent: Sizes.size14,
            endIndent: Sizes.size14,
          ),
          const UserCount(
            count: "193.4M",
            category: "Likes",
          ),
        ],
      ),
    );
  }
}
