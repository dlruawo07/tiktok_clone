import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

class NavTab extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final int selectedIndex;
  final Function onTap;

  const NavTab({
    super.key,
    required this.text,
    required this.isSelected,
    required this.icon,
    required this.selectedIcon,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: isDark || selectedIndex == 0 ? Colors.black : Colors.white,
          child: AnimatedOpacity(
            opacity: isSelected ? 1 : 0.5,
            duration: const Duration(
              milliseconds: 200,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedIcon : icon,
                  color: isDark || selectedIndex == 0
                      ? Colors.white
                      : Colors.black,
                  size: 25,
                ),
                Gaps.v4,
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: isDark || selectedIndex == 0
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
