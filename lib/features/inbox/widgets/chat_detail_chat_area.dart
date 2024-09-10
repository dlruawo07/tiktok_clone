import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/providers/message_provider.dart';

class ChatDetailChatArea extends ConsumerWidget {
  const ChatDetailChatArea({
    super.key,
    required this.data,
    required this.chatId,
  });

  final List<MessageModel> data;
  final String chatId;

  void _onLongPress(BuildContext context, WidgetRef ref, MessageModel message) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text("Warning"),
        message: const Text("This will delete your message"),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              ref
                  .watch(messagesProvider(chatId).notifier)
                  .deleteMessage(message);
              Navigator.of(context).pop();
            },
            isDestructiveAction: true,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      reverse: true,
      padding: EdgeInsets.only(
        top: Sizes.size20,
        bottom: MediaQuery.of(context).padding.bottom + Sizes.size96,
        left: Sizes.size14,
        right: Sizes.size14,
      ),
      itemBuilder: (context, index) {
        final message = data[index];
        final isMine =
            message.userId == ref.watch(authRepositoryProvider).user!.uid;
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            // TODO: Code challenge.
            // onLongPress: instead of just deleting, replace the text with [Deleted message].
            // delete message if the message was created in less than four minutes ago. (only my messages)
            GestureDetector(
              onLongPress: () => _onLongPress(context, ref, message),
              child: Container(
                padding: const EdgeInsets.all(
                  Sizes.size14,
                ),
                decoration: BoxDecoration(
                  color: isMine ? Colors.blue : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(Sizes.size20),
                    topRight: const Radius.circular(Sizes.size20),
                    bottomLeft: isMine
                        ? const Radius.circular(Sizes.size20)
                        : const Radius.circular(Sizes.size2),
                    bottomRight: isMine
                        ? const Radius.circular(Sizes.size2)
                        : const Radius.circular(Sizes.size20),
                  ),
                ),
                child: Text(
                  message.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size16,
                  ),
                ),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => Gaps.v10,
      itemCount: data.length,
    );
  }
}
