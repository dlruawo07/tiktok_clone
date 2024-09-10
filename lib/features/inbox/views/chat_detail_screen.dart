import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/providers/chat_provider.dart';
import 'package:tiktok_clone/features/inbox/providers/message_provider.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_detail_app_bar.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_detail_chat_area.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_detail_text_input.dart';
import 'package:tiktok_clone/utils/get_size.dart';

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
        title: ChatDetailAppBar(
          widget: widget,
        ),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: _unfocus,
            child: ref.watch(chatProvider).when(
                  data: (data) => ChatDetailChatArea(
                    data: data,
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
            width: getDeviceWidth(context),
            child: ChatDetailTextInput(
              controller: _textController,
              isLoading: isLoading,
              onPressed: _onSendPressed,
            ),
          ),
        ],
      ),
    );
  }
}
