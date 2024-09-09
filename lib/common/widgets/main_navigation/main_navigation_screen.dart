import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab_bar.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/configures/constants/tabs.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_timeline_screen.dart';
import 'package:tiktok_clone/configures/router.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  final String tab;

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _selectedIndex = navigationTabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${navigationTabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(CustomRouter.recordingName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      // TextField 입력 시 키보드가 올라오고 scaffold는 자동으로 위젯들의 크기를 조정한다
      // 이를 방지하기 위한 옵션
      resizeToAvoidBottomInset: false,
      backgroundColor:
          isDark || _selectedIndex == 0 ? Colors.black : Colors.white,
      body: Stack(
        children: [
          // 출력하거나 숨기는 위젯. default = offstage: true (숨김)
          // 숨김 처리 되어도 state는 그대로 갖고 있음.
          // Offstage를 남발하면 너무 많은 위젯들이 렌더 되기 때문에 느려질 수 있음.
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: isDark || _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size1,
          ),
          child: NavTabBar(
            onTap: _onTap,
            selectedIndex: _selectedIndex,
            onPostVideoButtonTap: _onPostVideoButtonTap,
          ),
        ),
      ),
    );
  }
}
