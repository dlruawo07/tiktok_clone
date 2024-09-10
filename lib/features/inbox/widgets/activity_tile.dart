import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/widgets/activity_text_field.dart';

class ActivityTile extends StatelessWidget {
  const ActivityTile({
    super.key,
    required this.isDark,
    required this.notification,
    required this.onDismissed,
  });

  final bool isDark;
  final String notification;
  final Function onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) => onDismissed(notification),
      key: Key(notification),
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: const Padding(
          padding: EdgeInsets.only(
            left: Sizes.size10,
          ),
          child: FaIcon(
            FontAwesomeIcons.checkDouble,
            color: Colors.white,
            size: Sizes.size32,
          ),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Padding(
          padding: EdgeInsets.only(
            right: Sizes.size10,
          ),
          child: FaIcon(
            FontAwesomeIcons.trashCan,
            color: Colors.white,
            size: Sizes.size32,
          ),
        ),
      ),
      child: ListTile(
        minVerticalPadding: Sizes.size20,
        leading: Container(
          width: Sizes.size52,
          decoration: BoxDecoration(
            border: Border.all(
              color: isDark ? Colors.grey.shade800 : Colors.grey.shade400,
              width: Sizes.size1,
            ),
            shape: BoxShape.circle,
            color: isDark ? Colors.grey.shade800 : Colors.white,
          ),
          child: const Center(
            child: FaIcon(
              FontAwesomeIcons.bell,
            ),
          ),
        ),
        // 텍스트 위젯에 풍부함을 더해줌
        title: ActivityTextField(
          notification: notification,
          primaryText: "Account updated:",
          secondaryText: "Upload longer videos",
        ),
        trailing: const FaIcon(
          FontAwesomeIcons.chevronRight,
          size: Sizes.size14,
        ),
      ),
    );
  }
}
