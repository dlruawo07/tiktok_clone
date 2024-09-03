import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/features/authentication/signup_screen.dart';
import 'package:tiktok_clone/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/features/inbox/chat_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
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
  static String signUpPath = "/";
  static String signUpName = "signUp";
  static String timelinePath = "/timeline";
  static String timelineName = "timeline";
  static String tutorialPath = "/tutorial";
  static String tutorialName = "tutorial";
  static String usernamePath = "/username";
  static String usernameName = "username";
}

final routerProvider = Provider(
  (ref) {
    // // 유저가 로그인을 하거나 로그아웃을 하면 리빌드
    // ref.watch(authState);

    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepositoryProvider).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != CustomRouter.signUpPath &&
              state.matchedLocation != CustomRouter.loginPath) {
            return CustomRouter.signUpPath;
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
          path: CustomRouter.signUpPath,
          name: CustomRouter.signUpName,
          builder: (context, state) => const SignUpScreen(),
        ),
        // GoRoute(
        //   path: CustomRouter.passwordPath,
        //   name: CustomRouter.passwordName,
        //   builder: (context, state) => const PasswordScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.birthdayPath,
        //   name: CustomRouter.birthdayName,
        //   builder: (context, state) => const BirthdayScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.tutorialPath,
        //   name: CustomRouter.tutorialName,
        //   builder: (context, state) => const TutorialScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.chatDetailPath,
        //   name: CustomRouter.chatDetailName,
        //   builder: (context, state) => const ChatDetailScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.discoverPath,
        //   name: CustomRouter.discoverName,
        //   builder: (context, state) => const DiscoverScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.inboxPath,
        //   name: CustomRouter.inboxName,
        //   builder: (context, state) => const InboxScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.loginFormPath,
        //   name: CustomRouter.loginFormName,
        //   builder: (context, state) => const LoginFormScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.navigationPath,
        //   name: CustomRouter.navigationName,
        //   builder: (context, state) => const MainNavigationScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.profilePath,
        //   name: CustomRouter.profileName,
        //   builder: (context, state) => const UserProfileScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.settingsPath,
        //   name: CustomRouter.settingsName,
        //   builder: (context, state) => const SettingsScreen(),
        // ),
        // GoRoute(
        //   path: CustomRouter.timelinePath,
        //   name: CustomRouter.timelineName,
        //   builder: (context, state) => const VideoTimelineScreen(),
        // ),
        // GoRoute(
        //   path: Routes.username,
        //   name: "username",
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
  },
);
