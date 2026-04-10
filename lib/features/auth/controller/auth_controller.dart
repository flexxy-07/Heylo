import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heylo/common/utils/utils.dart';
import 'package:heylo/features/auth/repository/auth_repository.dart';
import 'package:heylo/models/user_model.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

// Provider for initializing auth persistence on app startup
final authInitializationProvider = FutureProvider((ref) async {
  final authController = ref.watch(authControllerProvider);
  await authController.initializeAuthPersistence();
  return true;
});

final userDataAuthProvider = FutureProvider((ref){
  final AuthController = ref.watch(authControllerProvider);
  return AuthController.getCurrentUserData();
});

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  // ===== EMAIL & PASSWORD AUTHENTICATION =====
  Future<bool> signUpWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        showSnackBar(
          context: context,
          message: 'Please fill all fields',
        );
        return false;
      }

      if (password.length < 6) {
        showSnackBar(
          context: context,
          message: 'Password must be at least 6 characters',
        );
        return false;
      }

      await _authRepository.signUpWithEmail(email, password);
      showSnackBar(
        context: context,
        message: 'Account created successfully!',
      );
      return true;
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Sign up failed: $e',
      );
      return false;
    }
  }

  Future<bool> signInWithEmail(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        showSnackBar(
          context: context,
          message: 'Please fill all fields',
        );
        return false;
      }

      await _authRepository.signInWithEmail(email, password);
      showSnackBar(
        context: context,
        message: 'Signed in successfully!',
      );
      return true;
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Sign in failed: $e',
      );
      return false;
    }
  }

  Future<void> saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required String bio,
    required String phoneNumber,
    required BuildContext context,
  }) async {
    final isSuccess = await _authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      bio: bio,
      phoneNumber: phoneNumber,
      context: context,
    );

    if (isSuccess && context.mounted) {
      // Navigate to chat home page
      Navigator.pushReplacementNamed(context, '/chats');
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    return await _authRepository.getCurrentUserData();
  }

  // ===== LOGOUT =====
  Future<void> logout(BuildContext context) async {
    try {
      await _authRepository.logout();
      showSnackBar(
        context: context,
        message: 'Logged out successfully!',
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Logout failed: $e',
      );
    }
  }

  Stream<UserModel> userDataById(String userId){
     return _authRepository.userData(userId);
  }

  // ===== AUTH PERSISTENCE =====
  Future<void> initializeAuthPersistence() async {
    await _authRepository.initializeAuthPersistence();
  }

  Future<bool> getCachedLoginStatus() async {
    return await _authRepository.getCachedLoginStatus();
  }

  Stream<dynamic> get authStateChanges {
    return _authRepository.authStateChanges;
  }
}