import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.index,
    required this.username,
    this.imageUrl,
    required this.recentChatTime,
    required this.recentChatText,
    required this.deleteItem,
    required this.onTap,
  });

  final int index;
  final String username;
  final String? imageUrl;
  final int recentChatTime;
  final String recentChatText;
  final Function deleteItem;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('yyyy-MM-dd HH:mm').format(
      DateTime.fromMillisecondsSinceEpoch(recentChatTime),
    );
    return ListTile(
      onLongPress: () => deleteItem(
        index: index,
        username: username,
        imageUrl: imageUrl,
        recentChatTime: recentChatTime,
        recentChatText: recentChatText,
      ),
      onTap: () => onTap(
        index.toString(),
      ),
      leading: CircleAvatar(
        radius: 30,
        foregroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        child: Text(username),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
            ),
          ),
        ],
      ),
      subtitle: Text(
        recentChatText,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}
