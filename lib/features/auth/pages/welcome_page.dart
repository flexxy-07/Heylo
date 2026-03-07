import 'package:flutter/material.dart';
import 'package:heylo/features/auth/pages/login_page.dart';
import 'package:heylo/theme/app_pallete.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Spacing from top
                const SizedBox(height: 80),

                // Title and Features
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Heylo Title with Glow Effect
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppPallete.primary.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        'Heylo',
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.primary,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),

                    // Feature Cards
                    Column(
                      spacing: 32,
                      children: [
                        FeatureCard(
                          icon: Icons.chat_bubble_outline,
                          title: 'Instant Messaging',
                          subtitle: 'Connect with friends instantly',
                        ),
                        FeatureCard(
                          icon: Icons.shield_outlined,
                          title: 'Secure & Private',
                          subtitle: 'End-to-end encryption',
                        ),
                        FeatureCard(
                          icon: Icons.bolt,
                          title: 'Lightning Fast',
                          subtitle: 'Real-time communication',
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Get Started Button and Footer
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Get Started tapped')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPallete.primary,
                          foregroundColor: AppPallete.primaryForeground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Terms and Privacy
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 12,
                          color: AppPallete.mutedForeground,
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(text: 'By continuing, you agree to our '),
                          TextSpan(
                            text: 'Terms & Privacy\nPolicy',
                            style: TextStyle(
                              color: AppPallete.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const FeatureCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon Card - Small Elevated Card
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppPallete.cardElevated,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppPallete.primary.withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppPallete.primary,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Text Content
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppPallete.foreground,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 13,
                  color: AppPallete.mutedForeground,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),)
      ],
    );
  }
}
