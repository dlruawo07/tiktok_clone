import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';

class ChatDetailTextInput extends StatelessWidget {
  const ChatDetailTextInput({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onPressed,
  });

  final TextEditingController controller;
  final bool isLoading;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Send a message...",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size8,
                    vertical: Sizes.size16,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.faceSmile,
                    size: Sizes.size20,
                    color: Colors.grey.shade600,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Sizes.size12,
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: isLoading ? null : onPressed,
            icon: FaIcon(
              isLoading
                  ? FontAwesomeIcons.hourglass
                  : FontAwesomeIcons.paperPlane,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
