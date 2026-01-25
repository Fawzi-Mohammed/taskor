class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);
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
  AuthException([this.message = 'Auth error']);
}
