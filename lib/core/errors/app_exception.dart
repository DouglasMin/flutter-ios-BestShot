/// Base class for all app-level exceptions.
sealed class AppException implements Exception {
  const AppException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when a network or API request fails.
final class NetworkException extends AppException {
  const NetworkException(super.message, {this.statusCode});
  final int? statusCode;
}

/// Thrown when local or remote data parsing fails.
final class DataException extends AppException {
  const DataException(super.message);
}

/// Thrown when an unauthenticated action is attempted.
final class UnauthorizedException extends AppException {
  const UnauthorizedException([super.message = 'Unauthorized']);
}

/// Thrown for any unexpected or unclassified error.
final class UnknownException extends AppException {
  const UnknownException([super.message = 'An unknown error occurred']);
}
