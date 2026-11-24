import 'package:cairn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SidebarPoint {
  const SidebarPoint(this.title, this.subtitle);
  final String title;
  final String subtitle;
}

Widget buildSignUpSidebar({
  String eyebrow = 'BUILT FOR FLEET OWNERS',
  String headline = 'Your fleet.\nOne clear view.',
  String description =
      'Keep bookings, vehicles and drivers moving together — from one workspace.',
  List<SidebarPoint> points = const [
    SidebarPoint('Plan with confidence', 'Book trips and dispatch the right vehicle.'),
    SidebarPoint('Stay close to your fleet', 'See trips, availability and route updates.'),
    SidebarPoint('Bring your drivers onboard', 'You create driver accounts and control access.'),
  ],
}) {
  return Container(
    width: double.infinity,
    height: double.infinity,
    color: AppColors.dark,
    padding: EdgeInsets.symmetric(horizontal: 28.w),
    alignment: Alignment.centerLeft,
    child: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            eyebrow,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 28.h),
          Text(
            headline,
            style: TextStyle(
              fontSize: 30.sp,
              height: 1.25,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 28.h),
          Text(
            description,
            style: TextStyle(
              fontSize: 13.sp,
              height: 1.5,
              color: const Color(0xFFD6DFE1),
            ),
          ),
          SizedBox(height: 20.h),
          for (var i = 0; i < points.length; i++) ...[
            _buildPoint(i + 1, points[i]),
            SizedBox(height: 14.h),
          ],
        ],
      ),
    ),
  );
}

Widget _buildPoint(int index, SidebarPoint point) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${index.toString().padLeft(2, '0')}  ${point.title}',
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 2.h),
      Text(
        point.subtitle,
        style: TextStyle(fontSize: 11.sp, color: const Color(0xFFB5C2C5)),
      ),
    ],
  );
}