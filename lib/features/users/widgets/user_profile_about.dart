import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class UserProfileAbout extends StatelessWidget {
  const UserProfileAbout({
    super.key,
    required this.bio,
    required this.link,
  });

  final String bio;
  final String link;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.v2,
        Text(
          bio,
          textAlign: TextAlign.center,
        ),
        Gaps.v10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.link,
              size: Sizes.size14,
            ),
            Gaps.h4,
            Text(
              link,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Gaps.v10,
      ],
    );
  }
}
