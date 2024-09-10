import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/breakpoints.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/configures/constants/tabs.dart';
import 'package:tiktok_clone/features/discover/widgets/discover_grid_post.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';
import 'package:tiktok_clone/utils/get_size.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({
    super.key,
  });

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController = TextEditingController(
    text: "Initial Text",
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: discoverTabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // WOW
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: CupertinoSearchTextField(
              controller: _textEditingController,
              onChanged: (String value) {},
              onSubmitted: (String value) {},
              style: TextStyle(
                color: isDarkMode(context) ? Colors.white : null,
              ),
            ),
          ),
          // PreferredSizeWidget - 특정 크기를 가지려고 하지만 자식 요소들의 크기를 제한하지 않는다
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              for (var tab in discoverTabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          // controller: _tabController,
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                // how many columns to have,
                crossAxisCount:
                    getDeviceWidth(context) > Breakpoints.lg ? 5 : 2,
                // distance between grids
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                // ratio of grid (image 아래 text 등 포함하여 좀 더 깊게)
                childAspectRatio: 9 / 21,
              ),
              // image의 크기를 강제로 맞춤
              itemBuilder: (context, index) => const DiscoverPost(),
            ),
            for (var tab in discoverTabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
