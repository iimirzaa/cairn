import 'package:cairn/core/rules/validation_rules.dart';
import 'package:cairn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'sign_up_text_field.dart';

Widget buildSignUpTextFields({
  required TextEditingController nameController,
  required TextEditingController companyController,
  required TextEditingController emailController,
  required TextEditingController phoneController,
  required TextEditingController passwordController,
  Map<String, String> fieldErrors = const {},
  ValueChanged<String>? onFieldEdited,
  VoidCallback? onSubmit,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SignUpTextField(
              label: 'Full name',
              hint: 'Enter your full name',
              controller: nameController,
              validator:  ValidationRules.personName,
              serverError: fieldErrors['fullName'],
              onChanged: (_) => onFieldEdited?.call('fullName'),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: SignUpTextField(
              label: 'Company name',
              hint: 'Your company name',
              controller: companyController,
              validator:  ValidationRules.companyName,
              serverError: fieldErrors['companyName'],
              onChanged: (_) => onFieldEdited?.call('companyName'),
            ),
          ),
        ],
      ),
      SizedBox(height: 16.h),
      SignUpTextField(
        label: 'Work email',
        hint: 'you@company.com',
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: ValidationRules.email,
        serverError: fieldErrors['email'],
        onChanged: (_) => onFieldEdited?.call('email'),
      ),
      SizedBox(height: 16.h),
      SignUpTextField(
        label: 'Phone number',
        hint: '+92 300 1234567',
        controller: phoneController,
        keyboardType: TextInputType.phone,
        validator: ValidationRules.phone,
        serverError: fieldErrors['phone'],
        onChanged: (_) => onFieldEdited?.call('phone'),
      ),
      SizedBox(height: 16.h),
      SignUpTextField(
        label: 'Password',
        hint: 'Create a password',
        controller: passwordController,
        isPassword: true,
        textInputAction: TextInputAction.done,
        validator: ValidationRules.password,
        serverError: fieldErrors['password'],
        onChanged: (_) => onFieldEdited?.call('password'),
        onSubmitted: (_) => onSubmit?.call(),
      ),
      SizedBox(height: 8.h),
      Text(
        'Use at least 8 characters, with a number and a symbol.',
        style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary),
      ),
    ],
  );
}