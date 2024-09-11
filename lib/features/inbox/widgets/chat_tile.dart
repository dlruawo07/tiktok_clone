import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/providers/users_provider.dart';

class ChatTile extends ConsumerWidget {
  const ChatTile({
    super.key,
    required this.chatId,
    required this.user,
    this.imageUrl,
    required this.onTap,
  });

  final String chatId;
  final UserProfileModel user;
  final String? imageUrl;
  final Function onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeDiff = DateTime.now().millisecondsSinceEpoch - user.lastSeen;
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

    final isOnline =
        ref.watch(userOnlineStatusProvider(user.uid)).value ?? false;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          child: ListTile(
            onTap: () => onTap(chatId),
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  user.username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            trailing: Text(
              isOnline ? "" : timeAgo,
            ),
          ),
        ),
        Container(
          height: Sizes.size1,
          color: Colors.grey.shade200,
        ),
      ],
    );
  }
}
