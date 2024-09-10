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
                  username: user.username,
                  onTap: _onChatTap,
                );
              },
            );
          }
        },
      ),
    );
    // final user = ref.read(authRepositoryProvider).user!;
    // return Scaffold(
    //   appBar: AppBar(
    //     elevation: 1,
    //     title: const Text(
    //       "Direct messages",
    //     ),
    //     actions: [
    //       IconButton(
    //         onPressed: _addItem,
    //         // TODO: Code challenge: on press => show all users. and on user tap, create a chat room.
    //         icon: const FaIcon(
    //           FontAwesomeIcons.plus,
    //         ),
    //       ),
    //     ],
    //   ),
    //   // List의 요소들에 애니메이션 효과를 주는 위젯
    //   body: AnimatedList(
    //     padding: const EdgeInsets.symmetric(
    //       vertical: Sizes.size10,
    //     ),
    //     key: _key,
    //     // itemBuilder에 기본적으로 animation을 받는다
    //     itemBuilder: (context, index, animation) {
    //       return FadeTransition(
    //         key: UniqueKey(),
    //         opacity: animation,
    //         child: SizeTransition(
    //           sizeFactor: animation,
    //           child: ChatTile(
    //             index: index,
    //             username: "KJ",
    //             imageUrl:
    //                 "https://firebasestorage.googleapis.com/v0/b/tik-tok-52296.appspot.com/o/avatars%2F${user.uid}?alt=media&token=b79558d3-bf90-4773-a0ff-247ef62e2b31&nocaching=${DateTime.now().toString()}",
    //             recentChatTime: 1725929843252,
    //             recentChatText: "Don't forget to make a video",
    //             deleteItem: _deleteItem,
    //             onTap: _onChatTap,
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
