import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = ["Top", "Users", "Videos", "Sounds", "LIVE", "Shopping", "Brands"];

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

  void _onSearchChanged(String value) {
    print(value);
  }

  void _onSearchSubmitted(String value) {
    print(value);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // TODO: custom search in appBar title
  // TODO: hide keyboard when swiping left/right
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // NOTE: WOW
          title: CupertinoSearchTextField(
            controller: _textEditingController,
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted,
          ),
          // NOTE: PreferredSizeWidget - 특정 크기를 가지려고 하지만 자식 요소들의 크기를 제한하지 않는다
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelColor: Colors.grey.shade500,
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 20,
              padding: const EdgeInsets.all(Sizes.size6),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // NOTE: how many columns to have,
                crossAxisCount: 2,
                // NOTE: distance between grids
                crossAxisSpacing: Sizes.size10,
                mainAxisSpacing: Sizes.size10,
                // NOTE: ratio of grid (image 아래 text 등 포함하여 좀 더 깊게)
                childAspectRatio: 9 / 21,
              ),
              // NOTE: image의 크기를 강제로 맞춤
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    // NOTE: 아래 아마자둘운 container를 overflow하기 때문에
                    // borderRadius를 적용하려면 clip.hardEdge가 필요함
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      // NOTE: image 로딩 되는 동안 placeholder 렌더
                      child: FadeInImage.assetNetwork(
                        // NOTE: 어떻게 맞출 지 옵션
                        fit: BoxFit.cover,
                        placeholder: "assets/images/placeholder.jpg",
                        image:
                            "https://images.unsplash.com/photo-1722925542006-7d9f0ebc4da1?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
                  const DefaultTextStyle(
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Sizes.size12,
                      fontWeight: FontWeight.bold,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/59638614?v=4",
                          ),
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
            for (var tab in tabs.skip(1))
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
