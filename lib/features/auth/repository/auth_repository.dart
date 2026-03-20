import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:heylo/common/utils/utils.dart';
import 'package:heylo/services/cloudinary_service.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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

  Future<bool> saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required String bio,

   // required ProviderRef ref,
    
    required BuildContext context,
  }) async {
    try {
      print("🔥 saveUserDataToFirebase called");
      String uid = _firebaseAuth.currentUser!.uid;
      String photoUrl = '';
      String email = _firebaseAuth.currentUser!.email ?? '';
      if (profilePic != null) {
        // Upload profile picture to Cloudinary and get URL
        final cloudinaryService = CloudinaryService();
        photoUrl = await cloudinaryService.uploadProfileImage(
          file: profilePic,
          folder: 'heylo/profile_images',
        );
      }

      await _firestore.collection('users').doc(uid).set({
        'uid' : uid,
        'name': name,
        'email' : email,
        'bio' : bio,
        'profilePic': photoUrl,
        'createdAt': Timestamp.now(),
      });
      return true;
    } catch (e) {
      showSnackBar(context: context, message: e.toString());
      return false;
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
