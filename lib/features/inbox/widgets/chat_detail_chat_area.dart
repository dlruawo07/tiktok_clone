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

  void _deleteMessage(
      BuildContext context, WidgetRef ref, MessageModel message) {
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

  Radius _getTop(int index, bool isMine, bool prevIsMine) {
    if (!isMine && (index == data.length - 1 || prevIsMine) ||
        isMine && !prevIsMine) {
      return const Radius.circular(Sizes.size20);
    }
    return const Radius.circular(Sizes.size2);
  }

  Radius _getBottom(int index, bool isMine, bool nextIsMine) {
    if (isMine && (index == 0 || !nextIsMine) || !isMine && nextIsMine) {
      return const Radius.circular(Sizes.size20);
    }
    return const Radius.circular(Sizes.size2);
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
      separatorBuilder: (context, index) => Gaps.v6,
      itemCount: data.length,
      itemBuilder: (context, index) {
        final message = data[index];
        final prevMessage = index + 1 < data.length ? data[index + 1] : message;
        final nextMessage = index - 1 >= 0 ? data[index - 1] : message;

        bool isMine =
            message.userId == ref.watch(authRepositoryProvider).user!.uid;
        bool prevIsMine = index + 1 < data.length
            ? prevMessage.userId == ref.watch(authRepositoryProvider).user!.uid
            : false;
        bool nextIsMine = index - 1 >= 0
            ? nextMessage.userId == ref.watch(authRepositoryProvider).user!.uid
            : false;

        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            GestureDetector(
              onLongPress: () => _deleteMessage(context, ref, message),
              child: Container(
                padding: const EdgeInsets.all(
                  Sizes.size14,
                ),
                decoration: BoxDecoration(
                  color: isMine ? Colors.blue : Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: _getTop(index, isMine, prevIsMine),
                    topRight: _getTop(index, isMine, prevIsMine),
                    bottomLeft: _getBottom(index, isMine, nextIsMine),
                    bottomRight: _getBottom(index, isMine, nextIsMine),
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
    );
  }
}
