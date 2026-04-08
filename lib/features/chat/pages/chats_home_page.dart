import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/theme/app_pallete.dart';
import 'package:heylo/common/widgets/tech_grid.dart';
import 'package:heylo/features/select_contacts/pages/select_contact_screen.dart';

class ChatsHomePage extends StatelessWidget {
  static const String routeName = '/chats';
  const ChatsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: Stack(
        children: [
          // Background Tech Grid
          const TechGrid(),

          // Ambient Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppPallete.primary.withOpacity(0.03),
                boxShadow: [
                  BoxShadow(
                    color: AppPallete.primary.withOpacity(0.05),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),

                _buildSectionHeader('ACTIVE_CHANNELS'),

                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    itemBuilder: (context, index) {
                      return _buildChatTile(context, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, right: 8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, SelectContactScreen.routeName);
          },
          backgroundColor: AppPallete.primary,
          elevation: 8,
          child: const Icon(Icons.comment, color: AppPallete.background),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HUD Tag
                  // Container(
                  //   padding: const EdgeInsets.symmetric(
                  //     horizontal: 8,
                  //     vertical: 4,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: AppPallete.primary.withOpacity(0.3),
                  //     ),
                  //     borderRadius: BorderRadius.circular(4),
                  //   ),
                  //   child: Text(
                  //     'CHATS....../',
                  //     style: GoogleFonts.inter(
                  //       fontSize: 8,
                  //       fontWeight: FontWeight.bold,
                  //       color: AppPallete.primary,
                  //       letterSpacing: 2,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 12),
                  // Main Branding
                  Text(
                    'HEYLO',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: AppPallete.onSurface,
                      letterSpacing: -2,
                      height: 1,
                    ),
                  ),
                ],
              ),
              // Right side actions
              Row(
                children: [
                  // Glassmorphic Search Button
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppPallete.surfaceContainerLow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppPallete.outlineVariant.withOpacity(0.15),
                      ),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: AppPallete.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Profile/Logout Menu
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppPallete.surfaceContainerLow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppPallete.outlineVariant.withOpacity(0.15),
                      ),
                    ),
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: AppPallete.primary,
                        size: 24,
                      ),
                      color: AppPallete.surfaceContainer,
                      onSelected: (value) {
                        if (value == 'profile') {
                          Navigator.pushNamed(context, '/profile');
                        } else if (value == 'logout') {
                          // Quick inline logout instead
                          Navigator.pushNamed(context, '/profile'); // user can logout from profile page, or we can use ref here but it's a StatelessWidget. Let's convert if needed.
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return [
                          PopupMenuItem<String>(
                            value: 'profile',
                            child: Text(
                              'Profile & Logout',
                              style: GoogleFonts.inter(color: AppPallete.onSurface),
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
      child: Row(
        children: [
          Container(width: 4, height: 4, color: AppPallete.primary),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: AppPallete.onSurfaceVariant,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Divider(
              color: AppPallete.outlineVariant.withOpacity(0.1),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(BuildContext context, int index) {
    final names = ['Sarah', 'Mike', 'John', 'Alex', 'Kate'];
    final initials = ['S', 'M', 'J', 'A', 'K'];
    final times = ['10:30 AM', '09:45 AM', 'Yesterday', 'Mar 12', 'Mar 10'];
    final messages = [
      'Hey! How are you doing today?',
      'The project update is ready for review.',
      'Check out this new design concept.',
      'Are we still meeting at 5?',
      'Happy birthday! Hope you have a great day.',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/active-chat'),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppPallete.surfaceContainerLow.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppPallete.outlineVariant.withOpacity(0.05),
            ),
          ),
          child: Row(
            children: [
              // Avatar with Pulsing Effect (simulated)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: index < 2
                        ? AppPallete.primary.withOpacity(0.5)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: AppPallete.surfaceContainerHigh,
                  child: Text(
                    initials[index],
                    style: GoogleFonts.spaceGrotesk(
                      color: index < 2
                          ? AppPallete.primary
                          : AppPallete.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          names[index],
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppPallete.onSurface,
                          ),
                        ),
                        Text(
                          times[index],
                          style: GoogleFonts.spaceGrotesk(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppPallete.onSurfaceVariant,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      messages[index],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: AppPallete.onSurfaceVariant,
                        fontSize: 13,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              if (index < 2)
                Container(
                  margin: const EdgeInsets.only(left: 12),
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppPallete.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppPallete.primary,

                        blurRadius: 0,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: AppPallete.surfaceContainerLow.withOpacity(0.8),
        border: Border(
          top: BorderSide(color: AppPallete.outlineVariant.withOpacity(0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.chat_bubble_rounded, true, () {}),
          _buildNavItem(Icons.adjust_rounded, false, () {}), // Status icon
          _buildNavItem(Icons.person_rounded, false, () {
            Navigator.pushNamed(context, '/profile');
          }),
          _buildNavItem(Icons.settings_rounded, false, () {}),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive
                ? AppPallete.primary
                : AppPallete.onSurfaceVariant.withOpacity(0.5),
            size: 26,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: AppPallete.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
