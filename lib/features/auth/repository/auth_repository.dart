import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ===== EMAIL & PASSWORD AUTHENTICATION =====
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  // ===== USER STATE =====
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? getCurrentUserEmail() {
    return _firebaseAuth.currentUser?.email;
  }

  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }
}