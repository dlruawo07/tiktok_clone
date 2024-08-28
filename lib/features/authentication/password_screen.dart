import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({
    super.key,
  });

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // NOTE: 텍스트필드 이벤트리스너
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  num _isPasswordValid() {
    int result = 0;

    final hasLowerCaseLetters = RegExp(r'[a-z]').hasMatch(_password);
    final hasUpperCaseLetters = RegExp(r'[A-Z]').hasMatch(_password);
    final hasNumbers = RegExp(r'[0-9]').hasMatch(_password);
    final hasSpecialChars =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(_password);

    if (_password.isNotEmpty &&
        _password.length >= 8 &&
        _password.length <= 20) {
      result = 1;

      if (hasLowerCaseLetters &&
          hasUpperCaseLetters &&
          hasNumbers &&
          hasSpecialChars) {
        result = 2;
      }
    }

    return result;
  }

  void _onScaffoldTap() {
    // NOTE: 현재 포커스된 위젯을 포커스 해제하기
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_isPasswordValid() == 0) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign up"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            // NOTE: crossAxisAlignment는 수평
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size20 + Sizes.size2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v16,
              // NOTE: 입력창
              TextField(
                controller: _passwordController,
                onEditingComplete: _onSubmit,
                // NOTE: 입력값 안 보이게
                obscureText: _obscureText,
                decoration: InputDecoration(
                  // NOTE: 앞에 아이콘 위젯 추가
                  // prefixIcon: const Icon(Icons.ac_unit), (or just prefix)
                  // NOTE: 뒤에 아이콘 위젯 추가
                  // suffixIcon: const Icon(Icons.cancel_outlined), (or jest suffix)
                  suffix: Row(
                    // NOTE: 수평 axis 사이즈를 최소화
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade400,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  hintText: "Make it strong!",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v8,
              const Text(
                "Your password must have:",
                style: TextStyle(
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v8,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size16,
                    color: _isPasswordValid() != 0
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text("8 to 20 characters"),
                ],
              ),
              Gaps.v2,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size16,
                    color: _isPasswordValid() == 2
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  Gaps.h5,
                  const Text("Letters, numbers, and special characters"),
                ],
              ),
              Gaps.v16,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: _isPasswordValid() != 2,
                  title: "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
