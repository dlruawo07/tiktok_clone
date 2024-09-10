import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/providers/login_provider.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends ConsumerStatefulWidget {
  const LoginFormScreen({
    super.key,
  });

  @override
  LoginFormScreenState createState() => LoginFormScreenState();
}

class LoginFormScreenState extends ConsumerState<LoginFormScreen> {
  // unique ID + form의 state에 접근 + form의 메소드 트리거 가능
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, String> formData = {};

  void _onSubmitTap() {
    // Form의 state에 접근하여 validator 호출
    // 모든 FormField에 에러가 없을 때 true를 반환
    // 하나라도 에러가 있으면 false
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        // 모든 FormField 입력에 onSaved 콜백 함수 실행
        _formKey.currentState!.save();
        // context.goNamed(CustomRouter.interestsName);
        ref.read(loginProvider.notifier).login(
              formData["email"]!,
              formData["password"]!,
              context,
            );
      }
    }
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
          // Form에 키 부여
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                // 값 검증
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
                obscureText: true,
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
                child: FormButton(
                  disabled: ref.watch(loginProvider).isLoading,
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
