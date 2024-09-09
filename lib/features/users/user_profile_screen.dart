import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/edit_profile_screen.dart';
import 'package:tiktok_clone/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({
    super.key,
  });

  @override
  UserProfileScreenState createState() => UserProfileScreenState();
}

class UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onEditPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(usersProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CupertinoActivityIndicator(
              radius: Sizes.size20,
            ),
          ),
          data: (data) => SafeArea(
            child: DefaultTabController(
              length: 2,
              // SliverAppBar, TabBar, TabBarView 등 여러 개의 스크롤 되는 위젯들이 있을 때 사용
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      backgroundColor:
                          Theme.of(context).appBarTheme.backgroundColor,
                      centerTitle: true,
                      title: Text(data.username),
                      actions: [
                        IconButton(
                          onPressed: _onEditPressed,
                          icon: const FaIcon(
                            FontAwesomeIcons.solidPenToSquare,
                            size: Sizes.size20,
                          ),
                        ),
                        IconButton(
                          onPressed: _onGearPressed,
                          icon: const FaIcon(
                            FontAwesomeIcons.gear,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Avatar(
                            username: data.username,
                            hasAvatar: data.hasAvatar,
                            uid: data.uid,
                          ),
                          Gaps.v20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "@${data.username}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: Sizes.size14,
                                ),
                              ),
                              Gaps.h5,
                              FaIcon(
                                FontAwesomeIcons.solidCircleCheck,
                                color: Colors.blue.shade500,
                                size: Sizes.size14,
                              ),
                            ],
                          ),
                          Gaps.v20,
                          SizedBox(
                            height: Sizes.size48,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const UserCount(
                                  count: "97",
                                  category: "Following",
                                ),
                                VerticalDivider(
                                  thickness: Sizes.size1,
                                  width: Sizes.size32,
                                  color: Colors.grey.shade400,
                                  indent: Sizes.size14,
                                  endIndent: Sizes.size14,
                                ),
                                const UserCount(
                                  count: "10.5M",
                                  category: "Followers",
                                ),
                                VerticalDivider(
                                  thickness: Sizes.size1,
                                  width: Sizes.size32,
                                  color: Colors.grey.shade400,
                                  indent: Sizes.size14,
                                  endIndent: Sizes.size14,
                                ),
                                const UserCount(
                                  count: "193.4M",
                                  category: "Likes",
                                ),
                              ],
                            ),
                          ),
                          Gaps.v14,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: Sizes.size96,
                                padding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size12,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      Sizes.size4,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  "Follow",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Gaps.h3,
                              Container(
                                width: 44,
                                height: 44,
                                padding: const EdgeInsets.all(
                                  Sizes.size9,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      Sizes.size2,
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.youtube,
                                    size: Sizes.size20,
                                  ),
                                ),
                              ),
                              Gaps.h3,
                              Container(
                                width: 44,
                                height: 44,
                                padding: const EdgeInsets.all(
                                  Sizes.size9,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      Sizes.size2,
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.caretDown,
                                    size: Sizes.size14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gaps.v14,
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size32,
                            ),
                            child: Text(
                              data.bio,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Gaps.v14,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.link,
                                size: Sizes.size14,
                              ),
                              Gaps.h4,
                              Text(
                                data.link,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Gaps.v10,
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      delegate: PersistentTabBar(),
                      pinned: true,
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: 20,
                      padding: EdgeInsets.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        // how many columns to have,
                        crossAxisCount: 3,
                        // distance between grids
                        crossAxisSpacing: Sizes.size2,
                        mainAxisSpacing: Sizes.size2,
                        // ratio of grid (image 아래 text 등 포함하여 좀 더 깊게)
                        childAspectRatio: 9 / 15,
                      ),
                      // image의 크기를 강제로 맞춤
                      itemBuilder: (context, index) => Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 9 / 14,
                            // image 로딩 되는 동안 placeholder 렌더
                            child: FadeInImage.assetNetwork(
                              // 어떻게 맞출 지 옵션
                              fit: BoxFit.cover,
                              placeholder: "assets/images/placeholder.jpg",
                              image:
                                  "https://images.unsplash.com/photo-1722925542006-7d9f0ebc4da1?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                            ),
                          ),
                          Gaps.v10,
                        ],
                      ),
                    ),
                    const Center(
                      child: Text("Page two"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
//     return CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           // floating: true,
//           // stretch: true,
//           pinned: true,
//           // snap: true,
//           backgroundColor: Colors.teal,
//           collapsedHeight: 80,
//           expandedHeight: 200,
//           flexibleSpace: FlexibleSpaceBar(
//             title: const Text("Hello!"),
//             background: Image.asset(
//               "assets/images/placeholder.jpg",
//               fit: BoxFit.cover,
//             ),
//             stretchModes: const [
//               StretchMode.blurBackground,
//               StretchMode.fadeTitle,
//               StretchMode.zoomBackground,
//             ],
//           ),
//         ),
//         SliverFixedExtentList(
//           delegate: SliverChildBuilderDelegate(
//             childCount: 50,
//             (context, index) => Container(
//               color: Colors.amber[100 * (index % 9)],
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Text("Item $index"),
//               ),
//             ),
//           ),
//           itemExtent: 100,
//         ),
//         SliverPersistentHeader(
//           pinned: true,
//           delegate: CustomDelegate(),
//         ),
//         SliverGrid(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) => Padding(
//               padding: const EdgeInsets.all(Sizes.size10),
//               child: Container(
//                 color: Colors.blue[100 * (index % 9)],
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text("Item $index"),
//                 ),
//               ),
//             ),
//             childCount: 50,
//           ),
//           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//             maxCrossAxisExtent: 100,
//             mainAxisSpacing: Sizes.size20,
//             crossAxisSpacing: Sizes.size20,
//             childAspectRatio: 1,
//           ),
//         ),
//       ],
//     );
  }
}

// class CustomDelegate extends SliverPersistentHeaderDelegate {
//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: Colors.indigo,
//       child: const FractionallySizedBox(
//         heightFactor: 1,
//         child: Center(
//           child: Text(
//             "Title!!!",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
// }

class UserCount extends StatelessWidget {
  const UserCount({
    required this.count,
    required this.category,
    super.key,
  });

  final String count;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size14,
          ),
        ),
        Text(
          category,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

//   // PersistentHeader가 scroll 이후 변경되는 사이즈
//   @override
//   double get maxExtent => 150;

//   @override
//   double get minExtent => 80;

//   //true 를 반환해야함
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }
