import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/configures/constants/gaps.dart';
import 'package:tiktok_clone/configures/constants/sizes.dart';
import 'package:tiktok_clone/features/users/providers/users_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onSaveTap() {
    _formKey.currentState!.save();
    ref.read(usersProvider.notifier).updateBio(formData["bio"]!);
    ref.read(usersProvider.notifier).updateLink(formData["link"]!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size96,
          horizontal: Sizes.size36,
        ),
        child: Form(
          // Form에 키 부여
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your new bio:",
                style: TextStyle(
                  fontSize: Sizes.size20,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "bio",
                ),
                onSaved: (value) {
                  if (value != null) {
                    formData["bio"] = value;
                  }
                },
              ),
              Gaps.v96,
              const Text(
                "Your new link:",
                style: TextStyle(
                  fontSize: Sizes.size20,
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: "link",
                ),
                onSaved: (value) {
                  if (value != null) {
                    formData["link"] = value;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSaveTap,
                child: Center(
                  child: Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
