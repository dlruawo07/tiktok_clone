import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class UserProfileButtonBar extends StatelessWidget {
  const UserProfileButtonBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: Sizes.size96,
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size12,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(
                Sizes.size4,
              ),
            ),
          ),
          child: const Text(
            "Follow",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Gaps.h3,
        Container(
          width: 44,
          height: 44,
          padding: const EdgeInsets.all(
            Sizes.size9,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                Sizes.size2,
              ),
            ),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.youtube,
              size: Sizes.size20,
            ),
          ),
        ),
        Gaps.h3,
        Container(
          width: 44,
          height: 44,
          padding: const EdgeInsets.all(
            Sizes.size9,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                Sizes.size2,
              ),
            ),
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.caretDown,
              size: Sizes.size14,
            ),
          ),
        ),
      ],
    );
  }
}
