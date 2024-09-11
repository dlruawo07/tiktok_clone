import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/configures/router.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/inbox/providers/message_provider.dart';
import 'package:tiktok_clone/features/inbox/widgets/chat_tile.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';
import 'package:tiktok_clone/features/users/providers/users_provider.dart';
import 'package:tiktok_clone/utils/chats.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  // final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  // final List<int> _items = [];
  late User _me;
  late Future<List<UserProfileModel>> _users;

  // final Duration _duration = const Duration(
  //   milliseconds: 300,
  // );

  void _onChatTap(String chatId) {
    ref.read(messagesProvider(chatId).notifier).createChatRoom();
    context.pushNamed(
      CustomRouter.chatDetailName,
      pathParameters: {
        "chatId": chatId,
      },
    );
  }

  // void _addItem() {
  //   if (_key.currentState != null) {
  //     _key.currentState!.insertItem(
  //       _items.length,
  //       duration: _duration,
  //     );
  //     _items.add(_items.length);
  //   }
  // }

  // void _deleteItem({
  //   required int index,
  //   required String username,
  //   String? imageUrl,
  //   required int recentChatTime,
  //   required String recentChatText,
  // }) {
  //   if (_key.currentState != null) {
  //     _key.currentState!.removeItem(
  //       index,
  //       // 사이즈가 바뀌는 애니메이션 위젯
  //       (context, animation) => SizeTransition(
  //         sizeFactor: animation,
  //         child: Container(
  //           color: Colors.red.shade500,
  //           child: ChatTile(
  //             chatId: chatId,
  //             username: username,
  //             imageUrl: imageUrl,
  //             deleteItem: _deleteItem,
  //             onTap: _onChatTap,
  //           ),
  //         ),
  //       ),
  //       duration: _duration,
  //     );
  //     _items.removeAt(index);
  //   }
  // }

  Future<List<UserProfileModel>> _fetchAllUsers(User me) async {
    final List<dynamic> userUids =
        await ref.read(usersProvider.notifier).findAllUsers();
    final filteredUids = userUids.where((uid) => uid != me.uid).toList();
    final List<UserProfileModel> users = await Future.wait(
      filteredUids.map(
        (uid) async {
          final userData = await ref.read(usersProvider.notifier).findUser(uid);
          return UserProfileModel.fromJson(userData!);
        },
      ),
    );
    users.sort((a, b) => a.username.compareTo(b.username));

    return users;
  }

  @override
  void initState() {
    super.initState();
    _me = ref.read(authRepositoryProvider).user!;
    _users = _fetchAllUsers(_me);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("All Users"),
      ),
      body: FutureBuilder(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            final users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                final chatId = createChatId(_me.uid, user.uid);

                return ChatTile(
                  chatId: chatId,
                  user: user,
                  onTap: _onChatTap,
                );
              },
            );
          }
        },
      ),
    );
  }
}
