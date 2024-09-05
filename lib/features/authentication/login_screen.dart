import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({
    super.key,
  });

  void _onSignUpTap(BuildContext context) {
    // 가장 최근 위젯 삭제(LoginScreen)
    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    // context.pushNamed(CustomRouter.loginFormName);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size40,
          ),
          child: Column(
            children: [
              Gaps.v80,
              Text("Log in to TikTok",
                  // copyWith - headlineLarge의 특성 + 새로운 특성이 필요할 때
                  style: Theme.of(context).textTheme.headlineSmall!
                  // .copyWith(color: Colors.black),
                  ),
              Gaps.v20,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "Manage your account, check notifications, comment on videos, and more.",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              AuthButton(
                text: "Use email & password",
                icon: const FaIcon(FontAwesomeIcons.user),
                onTapFunction: () => _onEmailLoginTap(context),
              ),
              Gaps.v16,
              AuthButton(
                text: "Continue with Github",
                icon: const FaIcon(FontAwesomeIcons.github),
                onTapFunction: () =>
                    ref.read(socialAuthProvider.notifier).githubSignIn(context),
              ),
              Gaps.v16,
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size3,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
