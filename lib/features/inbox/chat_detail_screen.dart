import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/features/inbox/view_models/messages_view_model.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  final String chatId;

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textController = TextEditingController();

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  void _onSendPressed() {
    final text = _textController.text;
    if (text == "") {
      return;
    }

    ref.read(messagesProvider.notifier).sendMessage(text);

    _textController.text = "";
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: Sizes.size8,
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
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
            "Nico ${widget.chatId}",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
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
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _unfocus,
            child: ref.watch(chatProvider).when(
                  data: (data) => ListView.separated(
                    reverse: true,
                    padding: EdgeInsets.only(
                      top: Sizes.size20,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size96,
                      left: Sizes.size14,
                      right: Sizes.size14,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine = message.userId ==
                          ref.watch(authRepositoryProvider).user!.uid;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          // TODO: Code challenge.
                          // onLongPress: instead of just deleting, replace the text with [Deleted message].
                          // delete message if the message was created in less than four minutes ago. (only my messages)
                          Container(
                            padding: const EdgeInsets.all(
                              Sizes.size14,
                            ),
                            decoration: BoxDecoration(
                              color: isMine
                                  ? Colors.blue
                                  : Theme.of(context).primaryColor,
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
                        ],
                      );
                    },
                    separatorBuilder: (context, index) => Gaps.v10,
                    itemCount: data.length,
                  ),
                  error: (error, stackTrance) => Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: BottomAppBar(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Send a message...",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size8,
                            vertical: Sizes.size16,
                          ),
                          child: FaIcon(
                            FontAwesomeIcons.faceSmile,
                            size: Sizes.size20,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            Sizes.size12,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: isLoading ? null : _onSendPressed,
                    icon: FaIcon(
                      isLoading
                          ? FontAwesomeIcons.hourglass
                          : FontAwesomeIcons.paperPlane,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
