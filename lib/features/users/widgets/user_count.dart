import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class UserCount extends StatelessWidget {
  const UserCount({
    required this.count,
    required this.category,
    super.key,
  });

  final String count;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size14,
          ),
        ),
        Text(
          category,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
