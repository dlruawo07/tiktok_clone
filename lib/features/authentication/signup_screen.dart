import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  void _onLoginTap(BuildContext context) {
    // NOTE: LoginScreen을 context에 푸쉬
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _onEmailLoginTap(BuildContext context) {
    // NOTE: UsernameScreen을 context에 푸쉬
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        // if (orientation == Orientation.landscape) {
        //   return const Scaffold(
        //     body: Center(
        //       child: Text("Please rotate your phone."),
        //     ),
        //   );
        // }
        // NOTE: Scaffold 매우 중요
        return Scaffold(
          // NOTE: SafeArea 내부에 있는 것은 모두 특정 공간에 있을 것이라는 보장
          // (휴대폰의 상태바 등에 가려지지 않을 것을 보장)
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    S.of(context).signupTitle("TikTok", DateTime.now()),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.8,
                    child: Text(
                      S.of(context).signupSubtitle(0),
                      style: const TextStyle(
                        fontSize: Sizes.size14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      text: S.of(context).emailPasswordButton,
                      icon: const FaIcon(FontAwesomeIcons.user),
                      onTapFunction: () => _onEmailLoginTap(context),
                    ),
                    Gaps.v16,
                    // const AuthButton(
                    //   text: "Continue with Facebook",
                    //   icon: FaIcon(FontAwesomeIcons.facebook),
                    // ),
                    AuthButton(
                      text: S.of(context).appleButton,
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      onTapFunction: () {},
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            text: S.of(context).emailPasswordButton,
                            icon: const FaIcon(FontAwesomeIcons.user),
                            onTapFunction: () => _onEmailLoginTap(context),
                          ),
                        ),
                        Gaps.h16,
                        // const AuthButton(
                        //   text: "Continue with Facebook",
                        //   icon: FaIcon(FontAwesomeIcons.facebook),
                        // ),
                        Expanded(
                          child: AuthButton(
                            text: S.of(context).appleButton,
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            onTapFunction: () {},
                          ),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
          // NOTE: Scaffold에서 아래 바
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size3,
              ),
              child: Row(
                // NOTE: mainAxisAlignment는 수직
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).login("male"),
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
