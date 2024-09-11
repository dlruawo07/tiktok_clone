import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/providers/users_provider.dart';
import 'package:tiktok_clone/utils/chats.dart';

class ChatDetailAppBar extends ConsumerWidget {
  const ChatDetailAppBar({
    super.key,
    required this.chatId,
  });

  final String chatId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.read(authRepositoryProvider).user!;
    final recipientUid = getRecipientUid(chatId, me.uid);

    return FutureBuilder(
      future: ref.read(usersProvider.notifier).findUser(recipientUid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else {
          final user = UserProfileModel.fromJson(snapshot.data!);

          final bool isOnline =
              ref.watch(userOnlineStatusProvider(user.uid)).value ?? false;

          final timeDiff =
              DateTime.now().millisecondsSinceEpoch - user.lastSeen;
          String timeAgo = "ago";

          final toS = (timeDiff / 1000).round();
          final toM = (toS / 60).round();
          final toH = (toM / 60).round();
          final toD = (toH / 24).round();

          if (toS < 60) {
            timeAgo = "${toS}s $timeAgo";
          } else if (toM < 60) {
            timeAgo = "${toM}m $timeAgo";
          } else if (toH < 24) {
            timeAgo = "${toH}h $timeAgo";
          } else {
            timeAgo = "${toD}d $timeAgo";
          }

          return ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: Sizes.size8,
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: Sizes.size24,
                  foregroundImage: user.hasAvatar
                      ? NetworkImage(
                          "https://firebasestorage.googleapis.com/v0/b/tik-tok-52296.appspot.com/o/avatars%2F${user.uid}?alt=media&token=ec8c0815-601e-488d-9057-161b69d1b834",
                        )
                      : null,
                  child: Text(user.username),
                ),
                Positioned.fill(
                  left: 30,
                  top: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      color: isOnline ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 3,
                        color: Theme.of(context).appBarTheme.backgroundColor!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              user.username,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              isOnline ? "Active now" : timeAgo,
            ),
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
      },
    );
  }
}
