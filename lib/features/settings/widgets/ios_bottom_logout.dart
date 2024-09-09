import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/providers/signup_provider.dart';

class LogoutBottomIOS extends ConsumerWidget {
  const LogoutBottomIOS({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            title: const Text("Are you sure?"),
            message: const Text("Please don't go."),
            actions: [
              CupertinoActionSheetAction(
                isDefaultAction: true,
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Not log out"),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  ref.read(signUpProvider.notifier).signOut();
                  context.go("/");
                },
                isDestructiveAction: true,
                child: const Text("Yes please"),
              ),
            ],
          ),
        );
      },
      title: const Text("Log out (iOS / Bottom)"),
      textColor: Colors.red,
    );
  }
}
