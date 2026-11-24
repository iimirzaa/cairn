import 'package:cairn/core/error/exceptions.dart';
import 'package:cairn/features/authentication/data/models/owner_user_model.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<OwnerUserModel> signUpOwner({
    required String fullName,
    required String companyName,
    required String email,
    required String phone,
    required String password,
  });
}

class ApiAuthRemoteDataSource implements AuthRemoteDataSource {
  const ApiAuthRemoteDataSource(this._dio);
  final Dio _dio;

  @override
  Future<OwnerUserModel> signUpOwner({
    required String fullName,
    required String companyName,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final res = await _dio.post<Map<String, dynamic>>(
        '/auth/owner/signup',
        data: {
          'fullName': fullName,
          'companyName': companyName,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );

      // res.data?['token'] is the JWT. Store it when you build login/session.
      final user = res.data?['user'] as Map<String, dynamic>?;
      if (user == null) throw const ServerException();
      return OwnerUserModel.fromMap(user);
    } on DioException catch (e) {
      throw _mapError(e);
    }
  }

  Exception _mapError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();
      default:
        break;
    }

    final status = e.response?.statusCode;
    final data = e.response?.data;
    final body = data is Map<String, dynamic> ? data : <String, dynamic>{};

    if (status == 409 || status == 422) {
      final errors = (body['errors'] as Map?)?.map(
            (k, v) => MapEntry(k.toString(), v.toString()),
          ) ??
          <String, String>{};
      return FieldValidationException(errors);
    }

    return ServerException(
      body['message'] as String? ?? 'Server error. Please try again.',
    );
  }
}