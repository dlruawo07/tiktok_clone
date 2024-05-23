import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class EmailScreen extends StatelessWidget {
  const EmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            // NOTE: crossAxisAlignment는 수평
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "Create username",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v4,
              Text(
                "You can always change this later.",
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ));
  }
}
