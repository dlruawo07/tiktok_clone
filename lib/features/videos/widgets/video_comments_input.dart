import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/utils/get_size.dart';

// TODO: User avatar should be real (no fake data)
class VideoCommentsInput extends StatelessWidget {
  const VideoCommentsInput({
    super.key,
    required this.isDark,
    required this.isWriting,
    required this.onWriting,
    required this.stopWriting,
  });

  final bool isDark;
  final bool isWriting;
  final Function() onWriting;
  final Function() stopWriting;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      width: getDeviceWidth(context),
      child: BottomAppBar(
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey.shade500,
              foregroundColor: Colors.white,
              child: const Text("A"),
            ),
            Gaps.h10,
            Expanded(
              child: SizedBox(
                height: Sizes.size48,
                child: TextField(
                  onTap: onWriting,
                  // expands 옵션 사용 시 minLines와 maxLines를 설정해야함
                  minLines: null,
                  maxLines: null,
                  // 텍스트 필드가 늘어나게 해줌
                  expands: true,
                  // 키보드의 done 대신 return
                  textInputAction: TextInputAction.newline,
                  cursorColor: Theme.of(context).primaryColor,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(
                        right: Sizes.size14,
                      ),
                      // 아이콘을 전부 왼쪽 정렬
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: FaIcon(
                              FontAwesomeIcons.at,
                              color: isDark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade900,
                              size: Sizes.size20,
                            ),
                          ),
                          Gaps.h8,
                          GestureDetector(
                            onTap: () {},
                            child: FaIcon(
                              FontAwesomeIcons.gift,
                              color: isDark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade900,
                              size: Sizes.size20,
                            ),
                          ),
                          Gaps.h8,
                          GestureDetector(
                            onTap: () {},
                            child: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              color: isDark
                                  ? Colors.grey.shade500
                                  : Colors.grey.shade900,
                              size: Sizes.size20,
                            ),
                          ),
                          Gaps.h8,
                          GestureDetector(
                            // 추후 업로드로 변경
                            onTap: stopWriting,
                            child: FaIcon(
                              FontAwesomeIcons.circleArrowUp,
                              color: Theme.of(context).primaryColor,
                              size: Sizes.size20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    hintText: "Write a comment...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        Sizes.size12,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor:
                        isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    contentPadding: const EdgeInsets.only(
                      left: Sizes.size12,
                      right: Sizes.size12,
                      top: Sizes.size20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
