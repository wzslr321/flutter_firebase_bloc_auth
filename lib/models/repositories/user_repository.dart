import 'package:firebase_auth/firebase_auth.dart';

import '../exceptions/firebase_exception.dart';

class UserRepository {
  UserRepository() : _firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signIn({required String email, required String password}) {
    try {
      return _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_error, _stackTrace) {
      throw CustomFirebaseException(_error, _stackTrace);
    }
  }

  Future<void> signUp({required String email, required String password}) {
    try {
      return _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (_error, _stackTrace) {
      throw CustomFirebaseException(_error, _stackTrace);
    }
  }

  Future<void> signOut() {
    try {
      return _firebaseAuth.signOut();
    } on FirebaseAuthException catch (_error, _stackTrace) {
      throw CustomFirebaseException(_error, _stackTrace);
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
