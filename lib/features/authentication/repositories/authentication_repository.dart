import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  // Firebase.initialize한 이후부터 인스턴스 사용 가능 (main.dart에서 함)
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;
}

final authRepositoryProvider = Provider(
  (ref) => AuthenticationRepository(),
);
