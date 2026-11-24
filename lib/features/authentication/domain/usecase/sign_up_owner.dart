import 'package:cairn/core/error/failures.dart';
import 'package:cairn/core/rules/validation_rules.dart';
import 'package:cairn/features/authentication/domain/entities/owner_user.dart';
import 'package:cairn/features/authentication/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class SignUpOwner {
  const SignUpOwner(this._repository);
  final AuthRepository _repository;

  /// Throws [ValidationFailure] before any network call if input is invalid.
  Future<OwnerUser> call(SignUpParams params) async {
    final errors = params.validate();
    if (errors.isNotEmpty) throw ValidationFailure(errors);

    return _repository.signUpOwner(
      fullName: params.fullName,
      companyName: params.companyName,
      email: params.email,
      phone: params.phone,
      password: params.password,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
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

  /// Field key -> error message. Empty map means valid.
  Map<String, String> validate() {
    final all = <String, String?>{
  'fullName': ValidationRules.personName(fullName),
  'companyName': ValidationRules.companyName(companyName),
  'email': ValidationRules.email(email),
  'phone': ValidationRules.phone(phone),
  'password': ValidationRules.password(password),
};
    return {
      for (final e in all.entries)
        if (e.value != null) e.key: e.value!,
    };
  }

  @override
  List<Object?> get props => [fullName, companyName, email, phone, password];
}