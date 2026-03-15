import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heylo/features/auth/controller/auth_controller.dart';
import 'package:heylo/theme/app_pallete.dart';

class OtpPage extends ConsumerStatefulWidget {
  static const String routeName = '/otp';
  const OtpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleOTPVerification(String verificationId) async {
    final otp = _controllers.map((c) => c.text).join();

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 4 digits')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final authController = ref.read(authControllerProvider);
    await authController.verifyOTP(
      context,
      verificationId,
      otp,
    );

    setState(() => _isLoading = false);

    // If verification successful, navigate to chats
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
    // Get arguments from navigation
    final args = ModalRoute.of(context)?.settings.arguments as Map?
        ?? {};
    final verificationId = args['verificationId'] as String? ?? '';
    final phone = args['phone'] as String? ?? '';

    return Scaffold(
      backgroundColor: AppPallete.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                'Verify your\nnumber',
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
                phone.isNotEmpty
                    ? 'Enter the 4-digit code sent to $phone'
                    : 'Enter the 4-digit code sent to your phone',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppPallete.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 70,
                    height: 70,
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppPallete.primary,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppPallete.surfaceContainerLowest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const Spacer(),
              Container(
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  gradient: AppPallete.primaryGradient,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _isLoading ? null : () => _handleOTPVerification(verificationId),
                    borderRadius: BorderRadius.circular(9999),
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
                              'Verify',
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
              const SizedBox(height: 12),
              Center(
                child: TextButton(
                  onPressed: _isLoading ? null : () {
                    // Resend OTP logic (will be implemented with resendToken)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Resending OTP...')),
                    );
                  },
                  child: Text(
                    "RESEND CODE",
                    style: GoogleFonts.inter(
                      color: AppPallete.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
