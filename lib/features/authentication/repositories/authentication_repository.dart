import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  // Firebase.initialize한 이후부터 인스턴스 사용 가능 (main.dart에서 함)
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  // 유저의 인증 상태 (로그인, 로그아웃)
  // Stream이기 때문에 변경 추적 가능
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> emailSignup(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> emailSignIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(
      GithubAuthProvider(),
    );
  }

  Future<void> findUserWithUid() async {}
}
