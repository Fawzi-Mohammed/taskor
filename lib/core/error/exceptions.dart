class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException([this.message = 'Server error', this.statusCode]);
}

class EmptyCacheException implements Exception {
  final String message;
  EmptyCacheException([this.message = 'Empty cache']);
}

class OfflineException implements Exception {
  final String message;
  OfflineException([this.message = 'Offline']);
}

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException([this.message = 'Auth error', this.statusCode]);
}
