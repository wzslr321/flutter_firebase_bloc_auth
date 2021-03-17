import 'package:firebase_auth/firebase_auth.dart';

import '../exceptions/firebase_exception.dart';

class UserRepository {
  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return 'Signed up';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return 'Logged out';
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  bool isSignedIn() {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User?> getUser() async {
    try {
      final user = _firebaseAuth.currentUser;
      return user;
    } on FirebaseException catch (_error, _stackTrace) {
      throw CustomFirebaseException(_error, _stackTrace);
    }
  }
}
