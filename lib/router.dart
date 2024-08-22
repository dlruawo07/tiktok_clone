import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/password_screen.dart';
import 'package:tiktok_clone/features/authentication/signup_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class CustomRouter {
  static String signupPath = "/";
  static String signupName = "signup";
  static String loginPath = "/login";
  static String loginName = "login";
  static String usernamePath = "/username";
  static String usernameName = "username";
  static String birthdayPath = "/birthday";
  static String birthdayName = "birthday";
  static String emailPath = "/email";
  static String emailName = "email";
  static String loginFormPath = "/login-form";
  static String loginFormName = "login-form";
  static String passwordPath = "/password";
  static String passwordName = "password";
  static String discoverPath = "/discover";
  static String discoverName = "discover";
  static String activityPath = "/activity";
  static String activityName = "activity";
  static String chatDetailPath = "/chat-detail";
  static String chatDetailName = "chat-detail";
  static String chatPath = "/chat";
  static String chatName = "chat";
  static String inboxPath = "/inbox";
  static String inboxName = "inbox";
  static String navigationPath = "/navigation";
  static String navigationName = "navigation";
  static String interestsPath = "/interests";
  static String interestsName = "interests";
  static String tutorialPath = "/tutorial";
  static String tutorialName = "tutorial";
  static String settingsPath = "/settings";
  static String settingsName = "settings";
  static String profilePath = "/profile";
  static String profileName = "profile";
  static String timelinePath = "/timeline";
  static String timelineName = "timeline";
}

final router = GoRouter(
  routes: [
    GoRoute(
      name: CustomRouter.signupName,
      path: CustomRouter.signupPath,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      name: CustomRouter.usernameName,
      path: CustomRouter.usernamePath,
      builder: (context, state) => const UsernameScreen(),
    ),

    GoRoute(
      name: CustomRouter.emailName,
      path: CustomRouter.emailPath,
      builder: (context, state) =>
          EmailScreen(username: (state.extra as EmailScreenArguments).username),
    ),
    GoRoute(
      name: CustomRouter.passwordName,
      path: CustomRouter.passwordPath,
      builder: (context, state) => const PasswordScreen(),
    ),
    GoRoute(
      name: CustomRouter.birthdayName,
      path: CustomRouter.birthdayPath,
      builder: (context, state) => const BirthdayScreen(),
    ),
    GoRoute(
      name: CustomRouter.interestsName,
      path: CustomRouter.interestsPath,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      name: CustomRouter.tutorialName,
      path: CustomRouter.tutorialPath,
      builder: (context, state) => const TutorialScreen(),
    ),
    GoRoute(
      name: CustomRouter.loginName,
      path: CustomRouter.loginPath,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: CustomRouter.activityName,
      path: CustomRouter.activityPath,
      builder: (context, state) => const ActivityScreen(),
    ),
    GoRoute(
      name: CustomRouter.chatName,
      path: CustomRouter.chatPath,
      builder: (context, state) => const ChatScreen(),
    ),
    GoRoute(
      name: CustomRouter.chatDetailName,
      path: CustomRouter.chatDetailPath,
      builder: (context, state) => const ChatDetailScreen(),
    ),
    GoRoute(
      name: CustomRouter.discoverName,
      path: CustomRouter.discoverPath,
      builder: (context, state) => const DiscoverScreen(),
    ),
    GoRoute(
      name: CustomRouter.inboxName,
      path: CustomRouter.inboxPath,
      builder: (context, state) => const InboxScreen(),
    ),
    GoRoute(
      name: CustomRouter.loginFormName,
      path: CustomRouter.loginFormPath,
      builder: (context, state) => const LoginFormScreen(),
    ),
    GoRoute(
      name: CustomRouter.navigationName,
      path: CustomRouter.navigationPath,
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      name: CustomRouter.profileName,
      path: CustomRouter.profilePath,
      builder: (context, state) => const UserProfileScreen(),
    ),
    GoRoute(
      name: CustomRouter.settingsName,
      path: CustomRouter.settingsPath,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      name: CustomRouter.timelineName,
      path: CustomRouter.timelinePath,
      builder: (context, state) => const VideoTimelineScreen(),
    ),
    // GoRoute(
    //   name: "username",
    //   path: Routes.username,
    //   builder: (context, state) => const UsernameScreen(),
    //   pageBuilder: (context, state) {
    //     return CustomTransitionPage(
    //       child: const UsernameScreen(),
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return FadeTransition(
    //           opacity: animation,
    //           child: ScaleTransition(
    //             scale: animation,
    //             child: child,
    //           ),
    //         );
    //       },
    //     );
    //   },
    // ),
  ],
);
