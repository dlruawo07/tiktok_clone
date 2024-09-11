import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  // Firebase.initialize한 이후부터 인스턴스 사용 가능 (main.dart에서 함)
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

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
    final doc =
        await _db.collection("users").where("email", isEqualTo: email).get();
    final userId = doc.docs.first.reference.id;
    await _db.collection("users").doc(userId).update(
      {
        "isOnline": true,
      },
    );

    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    final email = _firebaseAuth.currentUser!.email;
    final doc =
        await _db.collection("users").where("email", isEqualTo: email).get();
    final userId = doc.docs.first.reference.id;
    await _db.collection("users").doc(userId).update(
      {
        "isOnline": false,
        "lastSeen": DateTime.now().millisecondsSinceEpoch,
      },
    );

    await _firebaseAuth.signOut();
  }

  Future<void> githubSignIn() async {
    await _firebaseAuth.signInWithProvider(
      GithubAuthProvider(),
    );
  }

  Stream<bool> getUserOnlineStatus(String userId) {
    return _db.collection("users").doc(userId).snapshots().map(
      (snapshot) {
        if (snapshot.exists) {
          return snapshot.data()?["isOnline"] ?? false;
        }
        return false;
      },
    );
  }
}
