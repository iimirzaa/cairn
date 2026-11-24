import 'package:cairn/core/theme/app_colors.dart';
import 'package:cairn/features/authentication/presentation/desktop/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnerApp extends StatelessWidget {
  const OwnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Set this to your design frame (Figma artboard) size.
      designSize: const Size(1440, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Cairn',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: AppColors.primary,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: child,
        );
      },
      child: const OwnerSignupPage(),
    );
  }
}