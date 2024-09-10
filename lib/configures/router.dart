import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/views/main_navigation_screen.dart';
import 'package:tiktok_clone/features/authentication/views/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/views/login_screen.dart';
import 'package:tiktok_clone/features/authentication/views/password_screen.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/authentication/views/signup_screen.dart';
import 'package:tiktok_clone/features/authentication/views/username_screen.dart';
import 'package:tiktok_clone/features/inbox/views/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/views/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/views/chat_screen.dart';
import 'package:tiktok_clone/features/onboarding/views/interests_screen.dart';
import 'package:tiktok_clone/features/onboarding/views/tutorial_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';

class CustomRouter {
  static String activityPath = "/activity";
  static String activityName = "activity";
  static String birthdayPath = "/birthday";
  static String birthdayName = "birthday";
  static String chatDetailPath = ":chatId";
  static String chatDetailName = "chat-detail";
  static String chatPath = "/chats";
  static String chatName = "chats";
  static String discoverPath = "/discover";
  static String discoverName = "discover";
  static String emailPath = "/email";
  static String emailName = "email";
  static String inboxPath = "/inbox";
  static String inboxName = "inbox";
  static String interestsPath = "/tutorial";
  static String interestsName = "interests";
  static String loginFormPath = "/login-form";
  static String loginFormName = "login-form";
  static String loginPath = "/login";
  static String loginName = "login";
  static String navigationPath = "/navigation";
  static String navigationName = "navigation";
  static String passwordPath = "/password";
  static String passwordName = "password";
  static String profilePath = "/profile";
  static String profileName = "profile";
  static String recordingPath = "/upload";
  static String recordingName = "postVideo";
  static String settingsPath = "/settings";
  static String settingsName = "settings";
  static String signupPath = "/";
  static String signupName = "signup";
  static String timelinePath = "/timeline";
  static String timelineName = "timeline";
  static String tutorialPath = "/tutorial";
  static String tutorialName = "tutorial";
  static String usernamePath = "/username";
  static String usernameName = "username";
  static String homePath = "/home";
}

final routerProvider = Provider(
  (ref) {
    // TODO: 유저가 로그인을 하거나 로그아웃을 하면 리빌드
    // ref.watch(authState);

    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepositoryProvider).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != CustomRouter.signupPath &&
              state.matchedLocation != CustomRouter.loginPath) {
            return CustomRouter.signupPath;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          path: CustomRouter.activityPath,
          name: CustomRouter.activityName,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          path: CustomRouter.chatPath,
          name: CustomRouter.chatName,
          builder: (context, state) => const ChatScreen(),
          routes: [
            GoRoute(
              path: CustomRouter.chatDetailPath,
              name: CustomRouter.chatDetailName,
              builder: (context, state) => ChatDetailScreen(
                chatId: state.pathParameters["chatId"]!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: CustomRouter.interestsPath,
          name: CustomRouter.interestsName,
          builder: (context, state) => const InterestsScreen(),
        ),
        GoRoute(
          path: CustomRouter.loginPath,
          name: CustomRouter.loginName,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: "/:tab(home|discover|inbox|profile)",
          name: CustomRouter.navigationName,
          builder: (context, state) => MainNavigationScreen(
            tab: state.pathParameters["tab"]!,
          ),
        ),
        GoRoute(
          path: CustomRouter.recordingPath,
          name: CustomRouter.recordingName,
          pageBuilder: (context, state) => CustomTransitionPage(
            transitionDuration: const Duration(
              milliseconds: 200,
            ),
            child: const VideoRecordingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    SlideTransition(
              position: Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          builder: (context, state) => const VideoRecordingScreen(),
        ),
        GoRoute(
          path: CustomRouter.signupPath,
          name: CustomRouter.signupName,
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: CustomRouter.usernamePath,
          name: CustomRouter.usernameName,
          builder: (context, state) => const UsernameScreen(),
        ),
        GoRoute(
          path: CustomRouter.loginFormPath,
          name: CustomRouter.loginFormName,
          builder: (context, state) => const LoginFormScreen(),
        ),
        GoRoute(
          path: CustomRouter.passwordPath,
          name: CustomRouter.passwordName,
          builder: (context, state) => const PasswordScreen(),
        ),
        GoRoute(
          path: CustomRouter.tutorialPath,
          name: CustomRouter.tutorialName,
          builder: (context, state) => const TutorialScreen(),
        ),
      ],
    );
  },
);
