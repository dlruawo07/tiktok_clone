import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final dynamic onTapFunction;

  const AuthButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.onTapFunction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: FractionallySizedBox(
        widthFactor: 1, // NOTE: width를 부모의 width의 1배로 설정
        child: Container(
          padding: const EdgeInsets.all(Sizes.size12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
          child: Stack(
            // NOTE: widget 위에 widget을 쌓는 구조
            alignment: Alignment.center,
            children: [
              Align(
                // NOTE: 스택에 있는 위젯 중 하나에 alignment 적용하는 위젯
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: Sizes.size14,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
