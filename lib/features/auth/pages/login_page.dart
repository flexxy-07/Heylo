import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/features/auth/controller/auth_controller.dart';
import 'package:heylo/theme/app_pallete.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const String routeName = '/login-page';
  const LoginPage({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAuthentication() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authController = ref.read(authControllerProvider);

    if (_isSignUp) {
      await authController.signUpWithEmail(context, email, password);
    } else {
      await authController.signInWithEmail(context, email, password);
    }

    setState(() => _isLoading = false);

    // Navigate to next screen on success
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/chats',
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppPallete.surfaceContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppPallete.onSurface,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Title
                      Text(
                        _isSignUp ? 'Create Account' : 'Welcome Back',
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
                        _isSignUp
                            ? 'Sign up to get started'
                            : 'Sign in to continue chatting',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppPallete.onSurfaceVariant,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Email Field
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: GoogleFonts.inter(
                          color: AppPallete.onSurface,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'your@email.com',
                          hintStyle: GoogleFonts.inter(
                            color: AppPallete.onSurfaceVariant,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppPallete.surfaceContainer,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppPallete.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: GoogleFonts.inter(
                          color: AppPallete.onSurface,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: GoogleFonts.inter(
                            color: AppPallete.onSurfaceVariant,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppPallete.surfaceContainer,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppPallete.primary,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Toggle Sign In / Sign Up
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              _isSignUp = !_isSignUp;
                            });
                          },
                          child: Text(
                            _isSignUp
                                ? 'Already have an account? Sign in'
                                : "Don't have an account? Sign up",
                            style: GoogleFonts.inter(
                              color: AppPallete.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Auth Button at the bottom
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: AppPallete.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _isLoading ? null : _handleAuthentication,
                    borderRadius: BorderRadius.circular(12),
                    child: Center(
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              _isSignUp ? 'Sign Up' : 'Sign In',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
