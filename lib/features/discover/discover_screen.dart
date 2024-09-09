import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/breakpoints.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/images.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/configures/constants/tabs.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';

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

  void _onSearchChanged(String value) {}

  void _onSearchSubmitted(String value) {}

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
    final width = MediaQuery.of(context).size.width;
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
              onChanged: _onSearchChanged,
              onSubmitted: _onSearchSubmitted,
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
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                // distance between grids
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                // ratio of grid (image 아래 text 등 포함하여 좀 더 깊게)
                childAspectRatio: 9 / 21,
              ),
              // image의 크기를 강제로 맞춤
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    Container(
                      // 아래 아마자둘운 container를 overflow하기 때문에
                      // borderRadius를 적용하려면 clip.hardEdge가 필요함
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size4),
                      ),
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        // image 로딩 되는 동안 placeholder 렌더
                        child: FadeInImage.assetNetwork(
                          // 어떻게 맞출 지 옵션
                          fit: BoxFit.cover,
                          placeholder: defaultImgPlaceholder,
                          image: defaultGridImg,
                        ),
                      ),
                    ),
                    Gaps.v10,
                    const Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      "This is a very long caption for my tiktok that I'm uploading right now",
                      style: TextStyle(
                        fontSize: Sizes.size18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gaps.v8,
                    if (constraints.maxWidth < 200 ||
                        constraints.maxWidth > 250)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: isDarkMode(context)
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                          fontSize: Sizes.size12,
                          fontWeight: FontWeight.bold,
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(defaultImg),
                              radius: 12,
                            ),
                            Gaps.h4,
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                "A very very very very very long text",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Gaps.h4,
                            FaIcon(
                              FontAwesomeIcons.heart,
                              color: Colors.grey,
                              size: Sizes.size14,
                            ),
                            Gaps.h3,
                            Text(
                              "2.0M",
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
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
