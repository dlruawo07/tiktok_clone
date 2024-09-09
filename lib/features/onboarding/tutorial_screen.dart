import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/configures/router.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

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
      // to the right
      setState(() {
        _direction = Direction.right;
      });
    } else {
      // to the left
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
    context.go(CustomRouter.homePath);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
            ),
            // 탭이 2개인 경우에만 사용 가능
            child: AnimatedCrossFade(
              firstChild: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v64,
                  Text(
                    "Watch cool videos!",
                    style: TextStyle(
                      fontSize: Sizes.size34,
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
                        fontSize: Sizes.size34,
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
          color: isDarkMode(context) ? Colors.black : Colors.white,
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
              child: const Text(
                "Enter the app!",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
