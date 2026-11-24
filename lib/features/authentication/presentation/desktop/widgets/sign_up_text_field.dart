import 'package:cairn/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpTextField extends StatefulWidget {
  const SignUpTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.serverError,
    this.onChanged,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    this.onSubmitted,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? serverError; // error from use case / backend
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool isPassword;
  final ValueChanged<String>? onSubmitted;

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  final _focusNode = FocusNode();

  bool _obscure = true;
  bool _touched = false; // user has typed something at least once
  bool _validateLive = false; // true after the first time the field loses focus

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    // Validate when the user leaves the field (only if they interacted with it).
    if (!_focusNode.hasFocus && _touched) {
      setState(() => _validateLive = true);
      _fieldKey.currentState?.validate();
    }
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          key: _fieldKey,
          focusNode: _focusNode,
          controller: widget.controller,
          validator: widget.validator,
          forceErrorText: widget.serverError, // backend error under the field
          onChanged: (value) {
            _touched = true;
            widget.onChanged?.call(value);
          },
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.isPassword && _obscure,
          onFieldSubmitted: widget.onSubmitted,
          // No live errors until the field has been left once.
          autovalidateMode: _validateLive
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          style: TextStyle(fontSize: 13.sp, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: AppColors.hint),
            errorStyle: TextStyle(fontSize: 11.sp, color: AppColors.error),
            errorMaxLines: 2,
            isDense: true,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            border: _border(AppColors.border),
            enabledBorder: _border(AppColors.border),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error),
            suffixIcon: widget.isPassword
                ? TextButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    child: Text(
                      _obscure ? 'Show' : 'Hide',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}