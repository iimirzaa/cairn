import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable implements Exception {
  const Failure(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Something went wrong. Please try again.']);
}

class NetworkFailure extends Failure {
  const NetworkFailure()
      : super('Cannot reach the server. Check your connection.');
}

/// One message per field, so the UI can show each under its input.
class ValidationFailure extends Failure {
  const ValidationFailure(this.fieldErrors)
      : super('Please fix the highlighted fields.');

  final Map<String, String> fieldErrors;

  @override
  List<Object?> get props => [message, fieldErrors];
}