import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/inbox/views/chat_detail_screen.dart';

class ChatDetailAppBar extends ConsumerWidget {
  const ChatDetailAppBar({
    super.key,
    required this.widget,
  });

  final ChatDetailScreen widget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.read(authRepositoryProvider).user!;
    final participants = widget.chatId.split("-");
    // ignore: unused_local_variable
    final user = me.uid == participants[0] ? participants[1] : participants[0];
    // TODO: find user with given uid

    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: Sizes.size8,
      leading: Stack(
        children: [
          const CircleAvatar(
            radius: Sizes.size24,
            // TODO: user's avatar image url goes here
            // foregroundImage: NetworkImage(""),
            // TODO: user's username goes here
            child: Text("N"),
          ),
          Positioned.fill(
            left: 30,
            top: 30,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                    width: 3,
                    color: Theme.of(context).appBarTheme.backgroundColor!),
              ),
            ),
          ),
        ],
      ),
      title: Text(
        // TODO: user's username goes here
        "Nico ${widget.chatId}",
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      // TODO: if this user is logged in
      subtitle: const Text("Active now"),
      trailing: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            FontAwesomeIcons.flag,
            size: Sizes.size20,
          ),
          Gaps.h32,
          FaIcon(
            FontAwesomeIcons.ellipsis,
            size: Sizes.size20,
          ),
        ],
      ),
    );
  }
}
