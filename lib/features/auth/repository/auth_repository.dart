import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heylo/common/utils/utils.dart';
import 'package:heylo/models/user_model.dart';
import 'package:heylo/services/cloudinary_service.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Shared Preferences Keys
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';
  static const String _authTokenKey = 'auth_token';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userDataKey = 'user_data';
  // ===== EMAIL & PASSWORD AUTHENTICATION =====
  // ===== LOCAL PERSISTENCE METHODS =====
  Future<void> _saveAuthLocal(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userIdKey, user.uid);
      await prefs.setString(_userEmailKey, user.email ?? '');
      await prefs.setBool(_isLoggedInKey, true);
      print('✅ Auth persisted locally for user: ${user.email}');
    } catch (e) {
      print('❌ Failed to persist auth locally: $e');
    }
  }

  Future<void> _clearAuthLocal() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userIdKey);
      await prefs.remove(_userEmailKey);
      await prefs.remove(_authTokenKey);
      await prefs.remove(_isLoggedInKey);
      await prefs.remove(_userDataKey);
      print('✅ Local auth cache cleared');
    } catch (e) {
      print('❌ Failed to clear local auth: $e');
    }
  }

  Future<bool> getCachedLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      print('❌ Failed to get cached login status: $e');
      return false;
    }
  }

  // ===== EMAIL & PASSWORD AUTHENTICATION =====
  Future<UserCredential> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Persist auth locally after successful sign up
      await _saveAuthLocal(userCredential.user!);
      return userCredential;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  Future<UserCredential> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Persist auth locally after successful sign in
      await _saveAuthLocal(userCredential.user!);
      return userCredential;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  Future<bool> saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required String bio,
      required String phoneNumber,

   // required ProviderRef ref,
    
    required BuildContext context,
  }) async {
    try {
      print("🔥 saveUserDataToFirebase called");
      
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        showSnackBar(context: context, message: "User is not authenticated. Please sign in again.");
        return false;
      }
      
      String uid = currentUser.uid;
      String photoUrl = '';
      String email = currentUser.email ?? '';
      if (profilePic != null) {
        // Upload profile picture to Cloudinary and get URL
        final cloudinaryService = CloudinaryService();
        photoUrl = await cloudinaryService.uploadProfileImage(
          file: profilePic,
          folder: 'heylo/profile_images',
        );
      }
      final normalizedPhoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

      await _firestore.collection('users').doc(uid).set({
        'uid' : uid,
        'name': name,
        'email' : email,
        'bio' : bio,
        'profilePic': photoUrl,
        'createdAt': Timestamp.now(),
        'phoneNumber': normalizedPhoneNumber,
      });
      return true;
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
      return false;
    }
  }

  // ===== LOGOUT =====
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _clearAuthLocal();
      print('✅ User logged out successfully');
    } catch (e) {
      print('❌ Failed to logout: $e');
      throw Exception('Logout failed: $e');
    }
  }

  // ===== INITIALIZATION =====
  /// Initialize auth persistence on app start
  /// This restores the auth state from both Firebase and local cache
  Future<void> initializeAuthPersistence() async {
    try {
      // Firebase Auth already has built-in persistence
      // This ensures local cache is synced with Firebase state
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        await _saveAuthLocal(currentUser);
        print('✅ Auth persistence initialized for user: ${currentUser.email}');
      } else {
        await _clearAuthLocal();
      }
    } catch (e) {
      print('❌ Failed to initialize auth persistence: $e');
    }
  }

  // ===== USER STATE =====
  User? getCurrentUser() {  
    return _firebaseAuth.currentUser;
  }

  String? getCurrentUserEmail() {
    return _firebaseAuth.currentUser?.email;
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData = await _firestore.collection('users').doc(_firebaseAuth.currentUser?.uid).get();

    UserModel? user;
    if(userData.data() != null){
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }


}
