import 'package:cairn/core/error/exceptions.dart';
import 'package:cairn/core/error/failures.dart';
import 'package:cairn/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:cairn/features/authentication/domain/entities/owner_user.dart';
import 'package:cairn/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  @override
  Future<OwnerUser> signUpOwner({
    required String fullName,
    required String companyName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      return await _remote.signUpOwner(
        fullName: fullName,
        companyName: companyName,
        email: email,
        phone: phone,
        password: password,
      );
    } on FieldValidationException catch (e) {
      throw ValidationFailure(e.fieldErrors);
    } on NetworkException {
      throw const NetworkFailure();
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } catch (_) {
      throw const ServerFailure();
    }
  }
}