import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/providers/signup_provider.dart';

class LogoutAOS extends ConsumerWidget {
  const LogoutAOS({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            icon: const FaIcon(FontAwesomeIcons.skull),
            title: const Text("Are you sure?"),
            content: const Text("Please don't go"),
            actions: [
              TextButton(
                onPressed: () => context.pop(),
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
                  ref.read(signUpProvider.notifier).signOut();
                  context.go("/");
                },
                child: const Text("Yes"),
              ),
            ],
          ),
        );
      },
      title: const Text("Log out (Android)"),
      textColor: Colors.red,
    );
  }
}
