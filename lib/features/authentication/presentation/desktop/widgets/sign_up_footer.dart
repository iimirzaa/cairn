import 'package:cairn/core/theme/app_colors.dart';
import 'package:cairn/core/widgets/auth_link_row.dart';
import 'package:cairn/core/widgets/info_banner.dart';
import 'package:cairn/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSignUpFooter({
  required VoidCallback onSubmit,
  required VoidCallback onLoginTap,
  bool isLoading = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const InfoBanner(
        title: 'Driver signup is managed by you',
        message:
            'After signup, add drivers from your workspace and send their login invitations. Drivers cannot register themselves.',
      ),
      SizedBox(height: 16.h),
      Text(
        'By creating an account, you agree to the Terms of service and Privacy policy.',
        style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary),
      ),
      SizedBox(height: 12.h),
      PrimaryButton(
        label: 'Create owner account',
        isLoading: isLoading,
        onPressed: onSubmit,
      ),
      SizedBox(height: 16.h),
      Center(
        child: AuthLinkRow(
          text: 'Already have an account?',
          linkText: 'Log in',
          onTap: onLoginTap,
        ),
      ),
      SizedBox(height: 12.h),
      Center(
        child: Text(
          'Privacy policy  ·  Terms of service',
          style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary),
        ),
      ),
    ],
  );
}