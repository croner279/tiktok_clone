import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class authenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // main.dart에서 Firebase.initializeApp한 다음, FirebaseAuth.instance 쓰면 끝남. Firebase Authentication과 바로 소통 가능.

  bool get isLoggedIn => user != null;
  User? get user => _firebaseAuth.currentUser;
}

// 코드를 실행해서 값을 getter 안에 넣어주면 그걸 property처럼 쓸 수 있음.
final authRepo = Provider((ref) => authenticationRepository());
