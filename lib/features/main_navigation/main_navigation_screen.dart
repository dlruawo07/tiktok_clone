import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({
    super.key,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 1;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text("Record video"),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NOTE: TextField 입력 시 키보드가 올라오고 scaffold는 자동으로 위젯들의 크기를 조정한다
      // NOTE: 이를 방지하기 위한 옵션
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex != 0 ? Colors.white : Colors.black,
      body: Stack(
        children: [
          // NOTE: 출력하거나 숨기는 위젯. default = offstage: true (숨김)
          // NOTE: 숨김 처리 되어도 state는 그대로 갖고 있음.
          // NOTE: Offstage를 남발하면 너무 많은 위젯들이 렌더 되기 때문에 느려질 수 있음.
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
          ),
          Offstage(
            offstage: _selectedIndex != 4,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        color: _selectedIndex == 0 ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.size1,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(1),
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                child: PostVideoButton(
                  inverted: _selectedIndex != 0,
                ),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                selectedIndex: _selectedIndex,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// // NOTE: Cupertino style scaffold
// return CupertinoTabScaffold(
//   tabBar: CupertinoTabBar(
//     items: const [
//       BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.house),
//         label: "Home",
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(CupertinoIcons.search),
//         label: "Search",
//       ),
//     ],
//   ),
//   // NOTE: 위젯을 반환하는 함수
//   tabBuilder: (context, index) => screens[index],
// );

// // Material Design Ver.3
// return Scaffold(
//   body: screens[_selectedIndex],
//   bottomNavigationBar: NavigationBar(
//     labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//     selectedIndex: _selectedIndex,
//     onDestinationSelected: _onTap,
//     destinations: const [
//       NavigationDestination(
//         icon: FaIcon(
//           FontAwesomeIcons.house,
//           color: Colors.teal,
//         ),
//         label: "Home",
//       ),
//       NavigationDestination(
//         icon: FaIcon(
//           FontAwesomeIcons.magnifyingGlass,
//           color: Colors.amber,
//         ),
//         label: "Search",
//       ),
//       NavigationDestination(
//         icon: FaIcon(FontAwesomeIcons.house),
//         label: "Home",
//       ),
//       NavigationDestination(
//         icon: FaIcon(FontAwesomeIcons.house),
//         label: "Home",
//       ),
//     ],
//   ),
// );

// Material Design Ver.2
// BottomNavigationBar(
//   currentIndex: _selectedIndex,
//   onTap: _onTap,
//   // selectedItemColor: Theme.of(context).primaryColor,
//   backgroundColor: Colors.white,
//   elevation: 0,
//   items: const [
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.house),
//       label: "Home",
//       tooltip: "What are you?",
//       // NOTE: Item이 4개 이상인 경우 탭 시 내비게이션바 전체 배경 색상이 바뀐다
//       // NOTE: 하지만 BottomNavigationBar의 타입을 shifting으로 변경 시 아이템이 4개 미만이어도 적용 가능하다
//       backgroundColor: Colors.amber,
//     ),
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
//       label: "Search",
//       tooltip: "What are you?",
//       backgroundColor: Colors.blue,
//     ),
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
//       label: "",
//       tooltip: "What are you?",
//       backgroundColor: Colors.pink,
//     ),
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
//       label: "Inbox",
//       tooltip: "What are you?",
//       backgroundColor: Colors.yellow,
//     ),
//     BottomNavigationBarItem(
//       icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
//       label: "Profile",
//       tooltip: "What are you?",
//       backgroundColor: Colors.teal,
//     ),
//   ],
// ),