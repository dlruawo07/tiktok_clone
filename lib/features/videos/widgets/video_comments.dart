import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments_input.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments_list_view.dart';
import 'package:tiktok_clone/utils/error_snackbar.dart';
import 'package:tiktok_clone/utils/get_size.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({
    super.key,
  });

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;
  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  _onWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Container(
      // BottomSheet의 사이즈를 조정하기 위해 height 값 할당
      height: getDeviceHeight(context) * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size12,
        ),
      ),
      child: Scaffold(
        backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: isDark ? Colors.grey.shade800 : Colors.grey.shade50,
          // appBar에서 뒤로가기 버튼 제거
          automaticallyImplyLeading: false,
          title: const Text(
            "comments",
            style: TextStyle(
              fontSize: Sizes.size14,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(
                FontAwesomeIcons.xmark,
              ),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                // 스크롤바 필요 시
                controller: _scrollController,
                child: VideoCommentsListView(
                  scrollController: _scrollController,
                ),
              ),
              // bottomNavigationBar로 하면 키보드가 올라왔을 때 숨기 때문에 Positioned로 아래에 붙이기
              VideoCommentsInput(
                isDark: isDark,
                isWriting: _isWriting,
                onWriting: _onWriting,
                stopWriting: _stopWriting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
