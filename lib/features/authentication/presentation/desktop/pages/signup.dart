import 'package:cairn/features/authentication/presentation/desktop/bloc/owner_signup_bloc.dart';
import 'package:cairn/features/authentication/presentation/desktop/widgets/sign_up_footer.dart';
import 'package:cairn/features/authentication/presentation/desktop/widgets/sign_up_heading.dart';
import 'package:cairn/features/authentication/presentation/desktop/widgets/sign_up_text_fields.dart';
import 'package:cairn/features/authentication/presentation/desktop/widgets/signup_header.dart';
import 'package:cairn/features/authentication/presentation/desktop/widgets/signup_sidebar.dart';
import 'package:cairn/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Route-level page: only provides the bloc.
class OwnerSignupPage extends StatelessWidget {
  const OwnerSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OwnerSignupBloc>(
      create: (_) => sl<OwnerSignupBloc>(),
      child: const _OwnerSignupView(),
    );
  }
}

class _OwnerSignupView extends StatefulWidget {
  const _OwnerSignupView();

  @override
  State<_OwnerSignupView> createState() => _OwnerSignupViewState();
}

class _OwnerSignupViewState extends State<_OwnerSignupView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _company = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _company.dispose();
    _email.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<OwnerSignupBloc>().add(
          OwnerSignupSubmitted(
            fullName: _name.text.trim(),
            companyName: _company.text.trim(),
            email: _email.text.trim(),
            phone: _phone.text.trim(),
            password: _password.text,
          ),
        );
  }

  void _onStateChanged(BuildContext context, OwnerSignupState state) {
    final messenger = ScaffoldMessenger.of(context);

    // General errors go in a snackbar. Field errors show under their inputs.
    if (state.status == OwnerSignupStatus.failure &&
        state.errorMessage != null) {
      messenger.showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    } else if (state.status == OwnerSignupStatus.success) {
      messenger.showSnackBar(
        SnackBar(content: Text('Welcome, ${state.user?.fullName}!')),
      );
      // TODO: navigate to the owner dashboard
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OwnerSignupBloc, OwnerSignupState>(
      listener: _onStateChanged,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              buildSignUpHeader(onHelpTap: () {}),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    // Raw pixels on purpose: compares against real window width.
                    final showSidebar = constraints.maxWidth >= 900;
                    return Row(
                      children: [
                        if (showSidebar)
                          Expanded(flex: 36, child: buildSignUpSidebar()),
                        Expanded(
                          flex: 64,
                          child: Center(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.w,
                                vertical: 32.h,
                              ),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 420.w),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildSignUpHeading(),
                                      SizedBox(height: 20.h),
                                      buildSignUpTextFields(
                                        nameController: _name,
                                        companyController: _company,
                                        emailController: _email,
                                        phoneController: _phone,
                                        passwordController: _password,
                                        fieldErrors: state.fieldErrors,
                                        onFieldEdited: (field) => context
                                            .read<OwnerSignupBloc>()
                                            .add(OwnerSignupFieldEdited(field)),
                                        onSubmit: _submit,
                                      ),
                                      SizedBox(height: 16.h),
                                      buildSignUpFooter(
                                        isLoading: state.isLoading,
                                        onSubmit: _submit,
                                        onLoginTap: () {}, // TODO: login page
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}