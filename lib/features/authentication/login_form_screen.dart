import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  // NOTE: unique ID + form의 state에 접근 + form의 메소드 트리거 가능
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    // NOTE: Form의 state에 접근하여 validator 호출
    // 모든 FormField에 에러가 없을 때 true를 반환
    // 하나라도 에러가 있으면 false
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // NOTE: 모든 FormField 입력에 onSaved 콜백 함수 실행
        _formKey.currentState!.save();
      }
    }

    // NOTE: stateful 위젯 내에서는 어디서든 context를 사용할 수 있다.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(
          // NOTE: Form에 키 부여
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                // NOTE: 값 검증
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please write your email";
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    formData['email'] = value;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Password",
                ),
                // NOTE: 값 검증
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Please write your password";
                  }
                  return null;
                },
                onSaved: (value) {
                  if (value != null) {
                    formData['password'] = value;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmitTap,
                child: const FormButton(
                  disabled: false,
                  title: "Log in",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
