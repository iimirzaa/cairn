import 'package:cairn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSignUpHeading({
  String eyebrow = 'FLEET OWNER',
  String title = 'Create your owner account',
  String subtitle = 'Set up your company, then add your vehicles and drivers.',
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        eyebrow,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
          color: AppColors.primary,
        ),
      ),
      SizedBox(height: 8.h),
      Text(
        title,
        style: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
      SizedBox(height: 6.h),
      Text(
        subtitle,
        style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
      ),
    ],
  );
}