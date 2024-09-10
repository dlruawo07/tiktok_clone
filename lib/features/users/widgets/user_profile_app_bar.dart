import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserProfileAppBar extends StatelessWidget {
  const UserProfileAppBar({
    super.key,
    required this.data,
    required this.onEdit,
    required this.onGear,
  });

  final UserProfileModel data;
  final Function() onEdit;
  final Function() onGear;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      centerTitle: true,
      title: Text(data.username),
      actions: [
        IconButton(
          onPressed: onEdit,
          icon: const FaIcon(
            FontAwesomeIcons.solidPenToSquare,
            size: Sizes.size20,
          ),
        ),
        IconButton(
          onPressed: onGear,
          icon: const FaIcon(
            FontAwesomeIcons.gear,
            size: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
