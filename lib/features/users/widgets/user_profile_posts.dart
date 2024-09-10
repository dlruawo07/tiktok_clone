import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class UserProfilePosts extends StatelessWidget {
  const UserProfilePosts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: 20,
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
