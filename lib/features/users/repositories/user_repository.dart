import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiktok_clone/features/users/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // create profile
  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(
          profile.toJson(),
        );
  }

  // get profile
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<List<dynamic>> findAllUsers() async {
    final doc = await _db.collection("users").get();
    return doc.docs.map((doc) => doc["uid"]).toList();
  }

  // update avatar
  Future<void> uploadAvatar(File file, String filename) async {
    // 파일 저장공간 확보
    final fileRef = _storage.ref().child("avatars/$filename");
    // 파일 저장
    await fileRef.putFile(file);
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  String getAvatarFullPath(String uid) {
    return _storage.ref().child("avatars/$uid").fullPath;
  }

  Stream<UserProfileModel> watchUserProfile(String userId) {
    return _db.collection("users").doc(userId).snapshots().map(
      (snapshot) {
        if (!snapshot.exists) {
          return UserProfileModel.empty();
        }
        return UserProfileModel.fromJson(snapshot.data()!);
      },
    );
  }
}
