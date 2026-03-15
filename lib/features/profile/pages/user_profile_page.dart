import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/theme/app_pallete.dart';

class UserProfilePage extends StatelessWidget {
  static const String routeName = '/profile';
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
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
                        child: const Icon(Icons.arrow_back, color: AppPallete.onSurface),
                      ),
                    ),
                    Text(
                      'Profile',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.onSurface,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppPallete.surfaceContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.edit, color: AppPallete.primary),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Profile Image with Glow
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppPallete.primary.withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: AppPallete.surfaceContainerHigh,
                  child: Text(
                    'S',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.primary,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Text(
                'Sarah Jenkins',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.onSurface,
                ),
              ),
              Text(
                'Digital Designer • NYC',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppPallete.onSurfaceVariant,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Settings Groups
              _buildSettingsGroup([
                _buildSettingsItem(Icons.person_outline, 'Account Information'),
                _buildSettingsItem(Icons.notifications_none, 'Notifications'),
                _buildSettingsItem(Icons.lock_outline, 'Privacy & Security'),
              ]),
              
              const SizedBox(height: 24),
              
              _buildSettingsGroup([
                _buildSettingsItem(Icons.help_outline, 'Help & Support'),
                _buildSettingsItem(Icons.info_outline, 'About Heylo'),
              ]),
              
              const SizedBox(height: 40),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'LOGOUT',
                    style: GoogleFonts.inter(
                      color: AppPallete.error,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: AppPallete.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: AppPallete.onSurfaceVariant, size: 22),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppPallete.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: AppPallete.onSurfaceVariant, size: 20),
        ],
      ),
    );
  }
}
