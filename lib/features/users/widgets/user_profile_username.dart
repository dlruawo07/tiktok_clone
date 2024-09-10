import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class UserProfileUsername extends StatelessWidget {
  const UserProfileUsername({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "@$username",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size14,
          ),
        ),
        Gaps.h5,
        FaIcon(
          FontAwesomeIcons.solidCircleCheck,
          color: Colors.blue.shade500,
          size: Sizes.size14,
        ),
      ],
    );
  }
}
