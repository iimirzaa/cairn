part of 'owner_signup_bloc.dart';

abstract class OwnerSignupEvent extends Equatable {
  const OwnerSignupEvent();

  @override
  List<Object?> get props => [];
}

class OwnerSignupSubmitted extends OwnerSignupEvent {
  const OwnerSignupSubmitted({
    required this.fullName,
    required this.companyName,
    required this.email,
    required this.phone,
    required this.password,
  });

  final String fullName;
  final String companyName;
  final String email;
  final String phone;
  final String password;

  @override
  List<Object?> get props => [fullName, companyName, email, phone, password];
}

/// User typed in a field, so clear that field's server error.
class OwnerSignupFieldEdited extends OwnerSignupEvent {
  const OwnerSignupFieldEdited(this.field);
  final String field;

  @override
  List<Object?> get props => [field];
}