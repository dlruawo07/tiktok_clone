import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/providers/signup_provider.dart';

class LogoutIOS extends ConsumerWidget {
  const LogoutIOS({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Please don't go"),
            actions: [
              CupertinoDialogAction(
                onPressed: () => context.pop(),
                child: const Text("No"),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  ref.read(signupProvider.notifier).signOut();
                  context.go("/");
                },
                isDestructiveAction: true,
                child: const Text("Yes"),
              ),
            ],
          ),
        );
      },
      title: const Text("Log out (iOS)"),
      textColor: Colors.red,
    );
  }
}
