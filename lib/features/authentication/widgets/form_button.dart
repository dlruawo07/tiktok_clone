import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.title,
  });

  final bool disabled;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      // NOTE: 컨테이너의 애니메이션을 감지하는 위젯
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size12,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.size5),
          color:
              disabled ? Colors.grey.shade300 : Theme.of(context).primaryColor,
        ),
        duration: const Duration(
          milliseconds: 250,
        ),
        // NOTE: 텍스트 스타일의 애니메이션을 감지하는 위젯
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          // NOTE: 애니메이션이 적용되는 시간
          duration: const Duration(
            milliseconds: 250,
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
