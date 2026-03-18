import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heylo/models/user_model.dart';
import 'package:heylo/services/cloudinary_service.dart';

class ProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final CloudinaryService cloudinaryService;

  ProfileRepository({
    required this.firestore,
    required this.auth,
    CloudinaryService? cloudinaryService,
  }) : cloudinaryService = cloudinaryService ?? CloudinaryService();

  /// Save user data to Firebase with Cloudinary image upload
  Future<void> saveUserDataToFirebase({
    required String name,
    required String bio,
    required File? profilePic,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = '';

      // Upload profile picture to Cloudinary if provided
      if (profilePic != null) {
        photoUrl = await cloudinaryService.uploadProfileImage(
          file: profilePic,
          folder: 'heylo/profile_images',
        );
      }

      var user = UserModel(
        name: name,
        uid: uid,
        profilePic: photoUrl,
        isOnline: true,
        phoneNumber: auth.currentUser?.phoneNumber ?? '',
        groupId: [],
        bio: bio,
      );

      await firestore.collection('users').doc(uid).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to save user data: ${e.toString()}');
    }
  }

  /// Update user profile picture
  Future<void> updateProfilePicture({
    required File newProfilePic,
    String? currentProfilePicUrl,
  }) async {
    try {
      String uid = auth.currentUser!.uid;

      // Upload new image to Cloudinary and optionally delete old one
      final newPhotoUrl = await cloudinaryService.updateProfileImage(
        oldImageUrl: currentProfilePicUrl,
        newImageFile: newProfilePic,
      );

      // Update the photoUrl in Firestore
      await firestore.collection('users').doc(uid).update({
        'profilePic': newPhotoUrl,
      });
    } catch (e) {
      throw Exception('Failed to update profile picture: ${e.toString()}');
    }
  }

  /// Get user data from Firebase
  Future<UserModel?> getUserData(String uid) async {
    var userData = await firestore.collection('users').doc(uid).get();
    if (userData.data() != null) {
      return UserModel.fromMap(userData.data()!);
    }
    return null;
  }

  /// Get current user data stream for real-time updates
  Stream<UserModel?> getUserDataStream(String uid) {
    return firestore.collection('users').doc(uid).snapshots().map((snapshot) {
      if (snapshot.data() != null) {
        return UserModel.fromMap(snapshot.data()!);
      }
      return null;
    });
  }
}
