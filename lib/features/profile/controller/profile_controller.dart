import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heylo/features/auth/controller/auth_controller.dart';
import 'package:heylo/features/profile/repository/profile_repository.dart';
import 'package:heylo/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heylo/features/chat/pages/chats_home_page.dart';
import 'package:heylo/services/cloudinary_service.dart';

final profileRepositoryProvider = Provider((ref) => ProfileRepository(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
      cloudinaryService: CloudinaryService(),
    ));

final profileControllerProvider = Provider((ref) {
  final profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileController(profileRepository: profileRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider((ref) {
  final profileController = ref.watch(profileControllerProvider);
  return profileController.getUserData();
});

class ProfileController {
  final ProfileRepository profileRepository;
  final Ref ref;

  ProfileController({
    required this.profileRepository,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    final authRepository = ref.read(authRepositoryProvider);
    String? uid = authRepository.getCurrentUser()?.uid;
    if (uid != null) {
      return await profileRepository.getUserData(uid);
    }
    return null;
  }

  void saveUserDataToFirebase(
    BuildContext context,
    String name,
    String bio,
    File? profilePic,
  ) async {
    try {
      await profileRepository.saveUserDataToFirebase(
        name: name,
        bio: bio,
        profilePic: profilePic,
      );
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ChatsHomePage()),
          (route) => false,
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  /// Update user profile picture with Cloudinary
  Future<void> updateProfilePicture(
    BuildContext context,
    File newProfilePic,
    String? currentProfilePicUrl,
  ) async {
    try {
      await profileRepository.updateProfilePicture(
        newProfilePic: newProfilePic,
        currentProfilePicUrl: currentProfilePicUrl,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile picture updated successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
      // Refresh user data
      ref.refresh(userDataAuthProvider);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
