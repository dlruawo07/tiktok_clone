import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({
    super.key,
  });

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // NOTE: to the right
      setState(() {
        _direction = Direction.right;
      });
    } else {
      // NOTE: to the left
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails detail) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterTap() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => MainNavigationScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // NOTE: 드래그 이벤트 발생 시
      onPanUpdate: _onPanUpdate,
      // NOTE: 드래그 이벤트 종료 시
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            // NOTE: 탭이 2개인 경우에만 사용 가능
            child: AnimatedCrossFade(
              firstChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v64,
                  Text(
                    "Watch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size32 + Sizes.size3,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v12,
                  Text(
                    "Videos are personalized for you based on what you watch, like, and share.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
              secondChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v64,
                  FractionallySizedBox(
                    widthFactor: 1,
                    child: Text(
                      "Follow the rules!",
                      style: TextStyle(
                        fontSize: Sizes.size32 + Sizes.size3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gaps.v12,
                  Text(
                    "Take care of one another! Please!",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                  ),
                ],
              ),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(
                milliseconds: 300,
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            height: 120,
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size36,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              opacity: _showingPage == Page.second ? 1 : 0,
              duration: const Duration(
                milliseconds: 300,
              ),
              child: CupertinoButton(
                onPressed: _onEnterTap,
                color: Theme.of(context).primaryColor,
                child: const Text("Enter the app!"),
              ),
            )),
      ),
    );
  }
}

// // NOTE: 자식 위젯에 대해 디폴트 탭 컨트롤러를 만들어줌
// return DefaultTabController(
//   length = 3,
//   child = Scaffold(
//     body: const SafeArea(
//       // NOTE: 한 탭 당 하나의 자식 위젯을 가지는 페이지 뷰 위젯
//       child: TabBarView(
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Gaps.v32,
//                 Text(
//                   "Watch cool videos!",
//                   style: TextStyle(
//                     fontSize: Sizes.size32 + Sizes.size3,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Gaps.v12,
//                 Text(
//                   "Videos are personalized for you based on what you watch, like, and share.",
//                   style: TextStyle(
//                     fontSize: Sizes.size16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Gaps.v32,
//                 Text(
//                   "Follow the rules!",
//                   style: TextStyle(
//                     fontSize: Sizes.size32 + Sizes.size3,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Gaps.v12,
//                 Text(
//                   "Videos are personalized for you based on what you watch, like, and share.",
//                   style: TextStyle(
//                     fontSize: Sizes.size16,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Gaps.v32,
//                 Text(
//                   "Enjoy the ride!",
//                   style: TextStyle(
//                     fontSize: Sizes.size32 + Sizes.size3,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Gaps.v12,
//                 Text(
//                   "Videos are personalized for you based on what you watch, like, and share.",
//                   style: TextStyle(
//                     fontSize: Sizes.size16,
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     ),
//     bottomNavigationBar: BottomAppBar(
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//             // vertical: Sizes.size48,
//             ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // NOTE: 탭 셀렉터 표시 (TabBarView와 함께 사용 시 DefaultTabController 아래 둘 다 있어아 햠)
//             TabPageSelector(
//               color: Colors.white,
//               selectedColor: Colors.black38,
//             ),
//           ],
//         ),
//       ),
//     ),
//   ),
// );
