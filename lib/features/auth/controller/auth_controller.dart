import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heylo/common/utils/utils.dart';
import 'package:heylo/features/auth/repository/auth_repository.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  // ===== EMAIL & PASSWORD AUTHENTICATION =====
  Future<void> signUpWithEmail(
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
        return;
      }

      if (password.length < 6) {
        showSnackBar(
          context: context,
          message: 'Password must be at least 6 characters',
        );
        return;
      }

      await _authRepository.signUpWithEmail(email, password);
      showSnackBar(
        context: context,
        message: 'Account created successfully!',
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Sign up failed: $e',
      );
    }
  }

  Future<void> signInWithEmail(
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
        return;
      }

      await _authRepository.signInWithEmail(email, password);
      showSnackBar(
        context: context,
        message: 'Signed in successfully!',
      );
    } catch (e) {
      showSnackBar(
        context: context,
        message: 'Sign in failed: $e',
      );
    }
  }

  Future<void> saveUserDataToFirebase({
    required String name,
    required File? profilePic,
    required String bio,
    required BuildContext context,
  }) async {
    final isSuccess = await _authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      bio: bio,
      context: context,
    );

    if (isSuccess && context.mounted) {
      // Navigate to chat home page
      Navigator.pushReplacementNamed(context, '/chats');
    }
  }
}