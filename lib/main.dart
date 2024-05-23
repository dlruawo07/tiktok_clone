import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/authentication/sign_up_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFFE9435A),
      ),
      // Scaffold: 매우 중요
      // screen-based 보다는 feature-based 개발이 좋음 (feature can have multiple screens)
      home: const SignUpScreen(),
    );
  }
}
