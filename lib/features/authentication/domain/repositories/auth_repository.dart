import 'package:cairn/features/authentication/domain/entities/owner_user.dart';

abstract class AuthRepository {
  /// Throws a [Failure] (see core/error/failures.dart) on error.
  Future<OwnerUser> signUpOwner({
    required String fullName,
    required String companyName,
    required String email,
    required String phone,
    required String password,
  });
}