import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/icons.dart';
import 'package:tiktok_clone/configures/constants/tabs.dart';

class NavTabBar extends StatefulWidget {
  final Function onTap;
  final int selectedIndex;
  final Function() onPostVideoButtonTap;

  const NavTabBar({
    super.key,
    required this.onTap,
    required this.selectedIndex,
    required this.onPostVideoButtonTap,
  });

  @override
  State<NavTabBar> createState() => _NavTabBarState();
}

class _NavTabBarState extends State<NavTabBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < 5; i++)
          i != 2
              ? NavTab(
                  text: navigationTabs[i][0].toUpperCase() +
                      navigationTabs[i].substring(1),
                  isSelected: widget.selectedIndex == i,
                  icon: navigationIcons[i],
                  selectedIcon: selectedNavigationIcons[i],
                  selectedIndex: widget.selectedIndex,
                  onTap: () => widget.onTap(i),
                )
              : Row(
                  children: [
                    Gaps.h24,
                    GestureDetector(
                      onTap: widget.onPostVideoButtonTap,
                      child: PostVideoButton(
                        inverted: widget.selectedIndex != 0,
                      ),
                    ),
                    Gaps.h24
                  ],
                ),
      ],
    );
  }
}
