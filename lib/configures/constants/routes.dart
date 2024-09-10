import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/authentication/views/login_screen.dart';
import 'package:tiktok_clone/features/authentication/views/signup_screen.dart';
import 'package:tiktok_clone/features/authentication/views/username_screen.dart';

class Routes {
  static String index = "/";
  static String login = "/login";
  static String username = "/username";
  static String birthday = "/birthday";
  static String email = "/email";
  static String loginFormProvider = "/login-form";
  static String password = "/password";
  static String discover = "/discover";
  static String activity = "/activity";
  static String chatDetail = "/chat-detail";
  static String chat = "/chat";
  static String inbox = "/inbox";
  static String navigation = "/navigation";
  static String interests = "/interests";
  static String tutorial = "/tutorial";
  static String settings = "/settings";
  static String profile = "/profile";
  static String timeline = "/timeline";

  static Map<String, WidgetBuilder> routesMap = {
    Routes.index: (context) => const SignupScreen(),
    Routes.username: (context) => const UsernameScreen(),
    Routes.login: (context) => const LoginScreen(),
    // Routes.email: (context) => const EmailScreen(),
  };
}

class EmailScreenArguments {
  final String username;

  const EmailScreenArguments({
    required this.username,
  });
}
