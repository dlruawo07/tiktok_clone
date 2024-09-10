import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/providers/social_auth_provider.dart';
import 'package:tiktok_clone/features/authentication/views/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';

import 'package:tiktok_clone/configures/router.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({
    super.key,
  });

  void _onLoginTap(BuildContext context) {
    context.pushNamed(CustomRouter.loginName);
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
    // context.pushNamed(CustomRouter.usernameName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    "Sign up",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gaps.v20,
                  const Opacity(
                    opacity: 0.8,
                    child: Text(
                      "Create a profile, follow other accounts, make your own videos, and more.",
                      style: TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: "Use email & password",
                      icon: const FaIcon(FontAwesomeIcons.user),
                      onTapFunction: () => _onEmailLoginTap(context),
                    ),
                    Gaps.v16,
                    AuthButton(
                      text: "Continue with Github",
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onTapFunction: () => ref
                          .read(socialAuthProvider.notifier)
                          .githubSignIn(context),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            text: "Use email & password",
                            icon: const FaIcon(FontAwesomeIcons.user),
                            onTapFunction: () => _onEmailLoginTap(context),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            text: "Continue with Github",
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            onTapFunction: () => ref
                                .read(socialAuthProvider.notifier)
                                .githubSignIn(context),
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      "Log in",
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
      },
    );
  }
}
