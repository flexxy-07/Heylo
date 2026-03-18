import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/common/utils/utils.dart';
import 'package:heylo/features/profile/controller/profile_controller.dart';
import 'package:heylo/theme/app_pallete.dart';
import 'package:image_picker/image_picker.dart';

class UserInformationPage extends ConsumerStatefulWidget {
  static const String routeName = '/user-information';
  const UserInformationPage({super.key});

  @override
  ConsumerState<UserInformationPage> createState() =>
      _UserInformationPageState();
}

class _UserInformationPageState extends ConsumerState<UserInformationPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  File? image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    bioController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery(context);
    setState(() {});
  }

  void storeUserData() async {
    String name = nameController.text.trim();
    String bio = bioController.text.trim();

    if (name.isNotEmpty) {
      ref
          .read(profileControllerProvider)
          .saveUserDataToFirebase(context, name, bio, image);
    } else {
      showSnackBar(context: context, message: 'Please enter your name');
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
                const SizedBox(height: 40),
                Text(
                  'Profile Setup',
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppPallete.onSurface,
                    height: 1.1,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Complete your profile to start connecting',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: AppPallete.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 48),
                Center(
                  child: Stack(
                    children: [
                      image == null
                          ? Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppPallete.primary.withOpacity(0.1),
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
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(image!),
                              radius: 70,
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: selectImage,
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
                            child: const Icon(
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
                TextField(
                  controller: nameController,
                  style: GoogleFonts.inter(color: AppPallete.onSurface),
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: bioController,
                  maxLines: 3,
                  style: GoogleFonts.inter(color: AppPallete.onSurface),
                  decoration: const InputDecoration(hintText: 'Bio (optional)'),
                ),
                const SizedBox(height: 80),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: AppPallete.primaryGradient,
                    borderRadius: BorderRadius.circular(99), // full roundness
                  ),
                  child: ElevatedButton(
                    onPressed: storeUserData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'CONTINUE',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: AppPallete.onPrimary,
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
