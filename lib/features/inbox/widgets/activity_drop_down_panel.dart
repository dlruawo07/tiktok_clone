import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/configures/constants/tabs.dart';

class ActivityDropDownPanel extends StatelessWidget {
  const ActivityDropDownPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(
            Sizes.size4,
          ),
          bottomRight: Radius.circular(
            Sizes.size4,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var tab in activityTabs)
            ListTile(
              title: Row(
                children: [
                  Icon(
                    tab["icon"],
                    size: Sizes.size16,
                  ),
                  Gaps.h20,
                  Text(
                    tab["title"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
