import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/theme/app_pallete.dart';

class ChatsHomePage extends StatelessWidget {
  static const String routeName = '/chats';
  const ChatsHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.onSurface,
                      letterSpacing: -1,
                    ),
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppPallete.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: AppPallete.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            
            // AI Suggestion Box
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppPallete.secondary.withOpacity(0.1),
                      AppPallete.primary.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppPallete.secondary.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: AppPallete.secondary, size: 24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'AI: "How about starting a conversation with Sarah?"',
                        style: GoogleFonts.inter(
                          color: AppPallete.secondary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(context, '/active-chat'),
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppPallete.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: AppPallete.surfaceContainerHigh,
                              child: Text(
                                ['S', 'M', 'J', 'A', 'K'][index],
                                style: GoogleFonts.spaceGrotesk(
                                  color: AppPallete.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ['Sarah', 'Mike', 'John', 'Alex', 'Kate'][index],
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: AppPallete.onSurface,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Hey! How are you doing today?',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      color: AppPallete.onSurfaceVariant,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '10:30 AM',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: AppPallete.onSurfaceVariant,
                                  ),
                                ),
                                if (index < 2) 
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      color: AppPallete.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      '1',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: AppPallete.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(
          color: AppPallete.surfaceContainerLow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.chat_bubble, true),
            _buildNavItem(Icons.call, false),
            _buildNavItem(Icons.person, false),
            _buildNavItem(Icons.settings, false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? AppPallete.primary.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(
        icon,
        color: isActive ? AppPallete.primary : AppPallete.onSurfaceVariant,
      ),
    );
  }
}
