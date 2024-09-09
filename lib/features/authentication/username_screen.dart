import 'package:flutter/material.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/email_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({
    super.key,
  });

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();

  String _username = "";

  void _onNextTap() {
    if (_username.isEmpty) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EmailScreen(
          username: _username,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            const Text(
              "Create username",
              style: TextStyle(
                fontSize: Sizes.size22,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v4,
            const Text(
              "You can always change this later.",
              style: TextStyle(
                fontSize: Sizes.size14,
                color: Colors.black54,
              ),
            ),
            Gaps.v16,
            TextField(
              // 입력창
              controller: _usernameController,
              decoration: InputDecoration(
                // placeholder
                hintText: "Username",
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
              child: FormButton(
                disabled: _username.isEmpty,
                title: "Next",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
