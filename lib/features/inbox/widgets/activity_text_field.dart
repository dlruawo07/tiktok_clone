import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class ActivityTextField extends StatelessWidget {
  const ActivityTextField({
    super.key,
    required this.notification,
    required this.primaryText,
    required this.secondaryText,
  });

  final String notification;
  final String primaryText;
  final String secondaryText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: primaryText,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Theme.of(context).appBarTheme.foregroundColor,
          fontSize: Sizes.size14,
        ),
        // TextSpan에 다른 TextSpan을 자식으로 가질 수 있고 별도로 스타일링 가능
        children: [
          TextSpan(
            text: secondaryText,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
          ),
          TextSpan(
            text: " $notification",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}
