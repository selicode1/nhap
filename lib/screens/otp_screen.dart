import 'package:flutter/material.dart';
// import 'package:nhap/screens/dashboard_screen.dart';
import 'package:nhap/screens/login_screen.dart';
import 'package:nhap/screens/main_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/otp_input_field.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  int _resendTimerSeconds = 60;
  bool _canResend = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );
    _animController.forward();

    _startResendTimer();
  }

  @override
  void dispose() {
    _otpController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _canResend = false;
      _resendTimerSeconds = 60;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _resendTimerSeconds--;
        });

        if (_resendTimerSeconds > 0) {
          _startResendTimer();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  Future<void> _resendOtp() async {
    if (!_canResend) return;

    // TODO: Add resend OTP logic here

    _startResendTimer();
  }

  Future<void> _verifyOtp() async {
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP code'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    // TODO: Add verify OTP logic here

                                Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => MainScreen(pageIndex: 0)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('OTP Verification'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => {
                                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()))
          },
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // OTP Illustration
              Icon(Icons.verified_user, size: 80, color: AppColors.primary),
              const SizedBox(height: 20),
                  Text(
                    'Please enter the 6-digit code sent to your email or phone',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.brightness == Brightness.light
                          ? Colors.black54
                          : Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // OTP input field
                  OtpInputField(controller: _otpController),
                  const SizedBox(height: 32),

                  // Verify button
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Resend OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code?",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.brightness == Brightness.light
                              ? Colors.black54
                              : Colors.white70,
                        ),
                      ),
                      TextButton(
                        onPressed: _canResend ? _resendOtp : null,
                        child: Text(
                          _canResend
                              ? 'Resend'
                              : 'Resend in $_resendTimerSeconds s',
                          style: TextStyle(
                            color: _canResend
                                ? AppColors.primary
                                : AppColors.primary.withOpacity(0.5),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
