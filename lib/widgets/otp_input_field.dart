import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';

class OtpInputField extends StatelessWidget {
  final TextEditingController controller;
  
  const OtpInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light 
            ? Colors.grey.shade50 
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? Colors.grey.shade200
              : Colors.grey.shade700,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 6,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 8,
          color: theme.brightness == Brightness.light
              ? AppColors.neutral900
              : Colors.white,
        ),
        decoration: InputDecoration(
          hintText: '------',
          hintStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 8,
            color: theme.brightness == Brightness.light
                ? Colors.grey.shade300
                : Colors.grey.shade600,
          ),
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        cursorColor: AppColors.primary,
        cursorWidth: 2,
        onChanged: (value) {
          // Force rebuild to update
          if (value.length == 6) {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}