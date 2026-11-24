import 'package:cairn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSignUpHeader({
  String workspaceLabel = 'OWNER WORKSPACE',
  VoidCallback? onHelpTap,
}) {
  return Container(
    height: 56.h,
    width: double.infinity,
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.symmetric(horizontal: 32.w),
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        // Logo + workspace label share one baseline
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'carin',
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(width: 32.w),
            Text(
              workspaceLabel,
              maxLines: 1,
              softWrap: false,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.8,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        InkWell(
          onTap: onHelpTap,
          child: Text(
            'Help & support',
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    ),
  );
}