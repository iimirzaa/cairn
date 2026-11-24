import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// "Already have an account? Log in". Reuse on login as "Don't have an account? Create one".
class AuthLinkRow extends StatelessWidget {
  const AuthLinkRow({
    super.key,
    required this.text,
    required this.linkText,
    required this.onTap,
  });

  final String text;
  final String linkText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: AppColors.primary,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$text ', style: style),
        InkWell(
          onTap: onTap,
          child: Text(
            linkText,
            style: style.copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}