import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/theme/app_pallete.dart';
import 'package:heylo/features/auth/pages/login_page.dart';
import 'package:heylo/common/widgets/tech_grid.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: Stack(
        children: [
          // Background Tech Grid
          const TechGrid(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     const SizedBox(height: 80),

                    // App Identity Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppPallete.primary.withOpacity(0.3),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'HEYLO....../',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.primary,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Main Header
                    Text(
                      'YOUR\nWORLD,\nSYNCHRONIZED.',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 52,
                        height: 0.9,
                        fontWeight: FontWeight.w900,
                        color: AppPallete.onSurface,
                        letterSpacing: -2,
                      ),
                    ),

                    const SizedBox(height: 48),

                    // App Features (Replacing Technical Jargon)
                    _buildHudItem(
                      'PRIVATE & SECURE',
                      'End-to-end encrypted messaging soul.',
                    ),
                    _buildHudItem(
                      'INSTANT DELIVERY',
                      'Real-time communication at your fingertips.',
                    ),
                    _buildHudItem(
                      'SEAMLESS SYNC',
                      'Access your chats anywhere, anytime.',
                    ),

                    const Spacer(),

                    // Action Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   '0.014s / UPLINK_ESTABLISHED',
                              //   style: GoogleFonts.inter(
                              //     fontSize: 10,
                              //     color: AppPallete.onSurfaceVariant,
                              //     letterSpacing: 1,
                              //   ),
                              // ),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => navigateToLogin(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: AppPallete.primary.withOpacity(
                                          0.5,
                                        ),
                                      ),
                                      bottom: BorderSide(
                                        color: AppPallete.primary.withOpacity(
                                          0.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'START CHATTING',
                                        style: GoogleFonts.spaceGrotesk(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppPallete.primary,
                                          letterSpacing: 4,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 16,
                                        color: AppPallete.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // Floating Minimalist Elements
          Positioned(
            top: 100,
            right: 40,
            child: _buildFloatingCoord('VER: 1.0.0', 'BUILD: 2026'),
          ),
        ],
      ),
    );
  }

  Widget _buildHudItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 4, height: 4, color: AppPallete.primary),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                  color: AppPallete.onSurfaceVariant,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppPallete.onSurface.withOpacity(0.8),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingCoord(String tag1, String tag2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          tag1,
          style: GoogleFonts.inter(
            fontSize: 8,
            color: AppPallete.primary.withAlpha(100),
            letterSpacing: 1,
          ),
        ),
        Text(
          tag2,
          style: GoogleFonts.inter(
            fontSize: 8,
            color: AppPallete.primary.withAlpha(100),
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}

