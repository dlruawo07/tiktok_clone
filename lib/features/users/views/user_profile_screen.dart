import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/views/settings_screen.dart';
import 'package:tiktok_clone/features/users/views/edit_profile_screen.dart';
import 'package:tiktok_clone/features/users/providers/users_provider.dart';
import 'package:tiktok_clone/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_about.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_app_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_button_bar.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_posts.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_social_info.dart';
import 'package:tiktok_clone/features/users/widgets/user_profile_username.dart';

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
                    UserProfileAppBar(
                      data: data,
                      onEdit: _onEditPressed,
                      onGear: _onGearPressed,
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
                          UserProfileUsername(
                            username: data.username,
                          ),
                          Gaps.v20,
                          const UserProfileSocialInfo(),
                          Gaps.v14,
                          const UserProfileButtonBar(),
                          Gaps.v14,
                          UserProfileAbout(
                            bio: data.bio,
                            link: data.link,
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
                body: const UserProfilePosts(),
              ),
            ),
          ),
        );
  }
}
