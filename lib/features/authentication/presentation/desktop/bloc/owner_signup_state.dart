part of 'owner_signup_bloc.dart';

enum OwnerSignupStatus { initial, loading, success, failure }

class OwnerSignupState extends Equatable {
  const OwnerSignupState({
    this.status = OwnerSignupStatus.initial,
    this.user,
    this.errorMessage,
    this.fieldErrors = const {},
  });

  final OwnerSignupStatus status;
  final OwnerUser? user;
  final String? errorMessage; // general error (network/server)
  final Map<String, String> fieldErrors; // per-field errors

  bool get isLoading => status == OwnerSignupStatus.loading;

  @override
  List<Object?> get props => [status, user, errorMessage, fieldErrors];
}