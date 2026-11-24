class ServerException implements Exception {
  const ServerException([this.message = 'Server error. Please try again.']);
  final String message;
}

class NetworkException implements Exception {
  const NetworkException();
}

/// Backend rejected specific fields, e.g. {'email': 'Email already in use'}.
class FieldValidationException implements Exception {
  const FieldValidationException(this.fieldErrors);
  final Map<String, String> fieldErrors;
}