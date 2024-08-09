import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/onboarding/tutorial_screen.dart';
import 'package:tiktok_clone/features/onboarding/widgets/interest_button.dart';

const interests = [
  "Daily Life",
  "Comedy",
  "Entertainment",
  "Animals",
  "Food",
  "Beauty & Style",
  "Drama",
  "Learning",
  "Talent",
  "Sports",
  "Auto",
  "Family",
  "Fitness & Health",
  "DIY & Life Hacks",
  "Arts & Crafts",
  "Dance",
  "Outdoors",
  "Oddly Satisfying",
  "Home & Garden"
];

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({
    super.key,
  });

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  void _onScroll() {
    if (_scrollController.offset > 110 && _showTitle) {
      return;
    }
    setState(() {
      _showTitle = _scrollController.offset > 110 ? true : false;
    });
  }

  void _onNextTap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TutorialScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _onScroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedOpacity(
          opacity: _showTitle ? 1 : 0,
          duration: const Duration(
            milliseconds: 300,
          ),
          child: const Text("Choose your interests"),
        ),
      ),
      // NOTE: 오른쪽에 스크롤바 표시
      body: Scrollbar(
        // NOTE: 스크롤 컨트롤러
        controller: _scrollController,
        child: SingleChildScrollView(
          // NOTE: 스크롤 컨트롤러
          controller: _scrollController,
          child: Padding(
            padding: const EdgeInsets.only(
              left: Sizes.size14,
              right: Sizes.size14,
              bottom: Sizes.size14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v28,
                const Text(
                  "Choose your interests",
                  style: TextStyle(
                    fontSize: Sizes.size36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v16,
                const Text(
                  "Get better video recommendations",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                  ),
                ),
                Gaps.v44,
                // NOTE: 위젯들을 감싸주는 위젯
                Wrap(
                  // NOTE: 위젯 사이의 공백 (세로)
                  runSpacing: 20,
                  // NOTE: 위젯 사이의 공백 (가로)
                  spacing: 20,
                  children: [
                    for (var interest in interests)
                      InterestButton(
                        interest: interest,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 110,
        child: Padding(
          padding: const EdgeInsets.only(
            top: Sizes.size2,
            bottom: Sizes.size24,
            left: Sizes.size12,
            right: Sizes.size12,
          ),
          child: CupertinoButton(
            onPressed: _onNextTap,
            color: Theme.of(context).primaryColor,
            child: const Text("Next"),
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(
          //     vertical: Sizes.size18,
          //   ),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).primaryColor,
          //   ),
          //   child: const Text(
          //     "Next",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: Sizes.size16,
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
