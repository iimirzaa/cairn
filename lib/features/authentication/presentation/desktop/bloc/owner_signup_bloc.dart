import 'package:cairn/core/error/failures.dart';
import 'package:cairn/features/authentication/domain/entities/owner_user.dart';
import 'package:cairn/features/authentication/domain/usecase/sign_up_owner.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'owner_signup_event.dart';
part 'owner_signup_state.dart';

class OwnerSignupBloc extends Bloc<OwnerSignupEvent, OwnerSignupState> {
  OwnerSignupBloc({required SignUpOwner signUpOwner})
      : _signUpOwner = signUpOwner,
        super(const OwnerSignupState()) {
    on<OwnerSignupSubmitted>(_onSubmitted);
    on<OwnerSignupFieldEdited>(_onFieldEdited);
  }

  final SignUpOwner _signUpOwner;

  Future<void> _onSubmitted(
    OwnerSignupSubmitted event,
    Emitter<OwnerSignupState> emit,
  ) async {
    emit(const OwnerSignupState(status: OwnerSignupStatus.loading));

    try {
      final user = await _signUpOwner(
        SignUpParams(
          fullName: event.fullName,
          companyName: event.companyName,
          email: event.email,
          phone: event.phone,
          password: event.password,
        ),
      );
      emit(OwnerSignupState(status: OwnerSignupStatus.success, user: user));
    } on ValidationFailure catch (f) {
      // Must come before the general Failure catch.
      emit(OwnerSignupState(
        status: OwnerSignupStatus.failure,
        fieldErrors: f.fieldErrors,
      ));
    } on Failure catch (f) {
      emit(OwnerSignupState(
        status: OwnerSignupStatus.failure,
        errorMessage: f.message,
      ));
    } catch (_) {
      emit(const OwnerSignupState(
        status: OwnerSignupStatus.failure,
        errorMessage: 'Something went wrong. Please try again.',
      ));
    }
  }

  void _onFieldEdited(
    OwnerSignupFieldEdited event,
    Emitter<OwnerSignupState> emit,
  ) {
    if (!state.fieldErrors.containsKey(event.field)) return;
    final updated = Map<String, String>.from(state.fieldErrors)
      ..remove(event.field);
    emit(OwnerSignupState(
      status: state.status,
      user: state.user,
      fieldErrors: updated,
    ));
  }
}