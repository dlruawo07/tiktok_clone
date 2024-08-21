import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/routes.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({
    super.key,
  });

  void _onLoginTap(BuildContext context) {
    // NOTE: LoginScreen을 context에 푸쉬
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const LoginScreen(),
    //   ),
    // );
    Navigator.of(context).pushNamed(Routes.login);
  }

  void _onEmailLoginTap(BuildContext context) {
    // NOTE: UsernameScreen을 context에 푸쉬
    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => const UsernameScreen(),
    //   ),
    // );
    // NOTE: PageRouteBuilder 사용법
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(seconds: 1),
    //     reverseTransitionDuration: const Duration(seconds: 1),
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation = Tween(
    //         begin: const Offset(0, 1),
    //         end: Offset.zero,
    //       ).animate(animation);
    //       final opacityAnimation = Tween(
    //         begin: 0.5,
    //         end: 1.0,
    //       ).animate(animation);
    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: opacityAnimation,
    //           child: child,
    //         ),
    //       );
    //     },
    //   ),
    // );
    Navigator.of(context).pushNamed(Routes.username);
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
          bottomNavigationBar: BottomAppBar(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Sizes.size3,
              ),
              child: Row(
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
