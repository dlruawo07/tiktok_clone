import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/router.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({
    super.key,
  });

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialDate =
        DateTime(initialDate.year - 12, initialDate.month, initialDate.day);
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  void _onNextTap() {
    // stateful 위젯 내에서는 어디서든 context를 사용할 수 있다.
    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => const InterestsScreen(),
    //   ),
    //   (route) => false,
    // );
    context.goNamed(CustomRouter.interestsName);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    // 텍스트 필드값 지정
    _birthdayController.value = TextEditingValue(
      text: textDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Column(
          // crossAxisAlignment는 수평
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "When is your birthday?",
              style: TextStyle(
                fontSize: Sizes.size20 + Sizes.size2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v4,
            const Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              enabled: false,
              // 입력창
              controller: _birthdayController,
              decoration: InputDecoration(
                // placeholder
                hintText: "Birthday",
                // underline border
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
                // underline border
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            GestureDetector(
              onTap: _onNextTap,
              child: const FormButton(
                disabled: false,
                title: "Next",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        // Cupertino - 애플 UI 관련 위젯들
        child: CupertinoDatePicker(
          // 최대 날짜값
          maximumDate: initialDate,
          // 초기 날짜값
          initialDateTime: initialDate,
          // 날짜만
          mode: CupertinoDatePickerMode.date,
          // 날짜 변경 시 텍스트 필드값 업데이트
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
