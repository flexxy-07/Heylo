import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/common/utils/utils.dart';
import 'package:heylo/features/profile/controller/profile_controller.dart';
import 'package:heylo/models/user_model.dart';
import 'package:heylo/theme/app_pallete.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  static const String routeName = '/edit-profile';
  final UserModel? userData;

  const EditProfilePage({
    super.key,
    this.userData,
  });

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController bioController;
  File? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData?.name ?? '');
    bioController = TextEditingController(text: widget.userData?.bio ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  void selectImage() async {
    final image = await pickImageFromGallery(context);
    setState(() {
      selectedImage = image;
    });
  }

  void updateProfile() async {
    if (nameController.text.trim().isEmpty) {
      showSnackBar(context: context, message: 'Please enter your name');
      return;
    }

    setState(() => isLoading = true);

    try {
      if (selectedImage != null) {
        // Update profile picture
        await ref.read(profileControllerProvider).updateProfilePicture(
          context,
          selectedImage!,
          widget.userData?.profilePic,
        );
      }

      // You can also add functionality to update name and bio here
      // by creating an updateUserInfo method in ProfileRepository

      if (mounted) {
        showSnackBar(
          context: context,
          message: 'Profile updated successfully!',
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(
          context: context,
          message: 'Error: $e',
        );
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppPallete.surfaceContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: AppPallete.onSurface,
                        ),
                      ),
                    ),
                    Text(
                      'Edit Profile',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.onSurface,
                      ),
                    ),
                    SizedBox(
                      width: 48,
                    ), // Placeholder for alignment
                  ],
                ),
                const SizedBox(height: 48),

                // Profile Picture Section
                Center(
                  child: Stack(
                    children: [
                      selectedImage != null
                          ? CircleAvatar(
                              backgroundImage: FileImage(selectedImage!),
                              radius: 70,
                            )
                          : (widget.userData?.profilePic != null &&
                                  widget.userData!.profilePic.isNotEmpty
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.userData!.profilePic),
                                  radius: 70,
                                )
                              : Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppPallete.primary
                                            .withOpacity(0.1),
                                        blurRadius: 40,
                                        spreadRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    radius: 70,
                                    backgroundColor:
                                        AppPallete.surfaceContainerHigh,
                                    child: Icon(
                                      Icons.person,
                                      size: 64,
                                      color: AppPallete.primary,
                                    ),
                                  ),
                                )),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: isLoading ? null : selectImage,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppPallete.primary,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppPallete.background,
                                width: 4,
                              ),
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              size: 20,
                              color: AppPallete.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Name Field
                Text(
                  'Full Name',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  style: GoogleFonts.inter(color: AppPallete.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                  enabled: !isLoading,
                ),
                const SizedBox(height: 24),

                // Bio Field
                Text(
                  'Bio',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: bioController,
                  maxLines: 3,
                  style: GoogleFonts.inter(color: AppPallete.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'Tell us about yourself',
                  ),
                  enabled: !isLoading,
                ),
                const SizedBox(height: 48),

                // Update Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : updateProfile,
                    child: isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                AppPallete.onPrimary,
                              ),
                            ),
                          )
                        : Text(
                            'Update Profile',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
