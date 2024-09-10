import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/configures/router.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_tile.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  final Duration _duration = const Duration(
    milliseconds: 300,
  );

  void _onChatTap(String chatId) {
    context.pushNamed(
      CustomRouter.chatDetailName,
      pathParameters: {
        "chatId": chatId,
      },
    );
  }

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        duration: _duration,
      );
      _items.add(_items.length);
    }
  }

  void _deleteItem({
    required int index,
    required String username,
    String? imageUrl,
    required int recentChatTime,
    required String recentChatText,
  }) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        // 사이즈가 바뀌는 애니메이션 위젯
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red.shade500,
            child: ChatTile(
              index: index,
              username: username,
              imageUrl: imageUrl,
              recentChatTime: recentChatTime,
              recentChatText: recentChatText,
              deleteItem: _deleteItem,
              onTap: _onChatTap,
            ),
          ),
        ),
        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authRepositoryProvider).user!;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Direct messages",
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            // TODO: Code challenge: on press => show all users. and on user tap, create a chat room.
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      // List의 요소들에 애니메이션 효과를 주는 위젯
      body: AnimatedList(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        key: _key,
        // itemBuilder에 기본적으로 animation을 받는다
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: ChatTile(
                index: index,
                username: "KJ",
                imageUrl:
                    "https://firebasestorage.googleapis.com/v0/b/tik-tok-52296.appspot.com/o/avatars%2F${user.uid}?alt=media&token=b79558d3-bf90-4773-a0ff-247ef62e2b31&nocaching=${DateTime.now().toString()}",
                recentChatTime: 1725929843252,
                recentChatText: "Don't forget to make a video",
                deleteItem: _deleteItem,
                onTap: _onChatTap,
              ),
            ),
          );
        },
      ),
    );
  }
}
