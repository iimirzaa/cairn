import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class InfoBanner extends StatelessWidget {
  const InfoBanner({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.bannerBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.bannerBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: const TextStyle(
              fontSize: 12,
              height: 1.4,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}