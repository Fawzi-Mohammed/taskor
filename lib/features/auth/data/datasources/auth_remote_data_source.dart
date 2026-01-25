abstract class AuthRemoteDataSource {
  Future<bool> login({required String email, required String password});
  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required double hourlyRate,
  });

  Future<bool> requestPasswordReset({required String email});
  Future<bool> verifyResetCode({required String email, required String code});
  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });
}
class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  String _lastEmail = '';
  String _code = '4036';

  @override
  Future<bool> requestPasswordReset({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _lastEmail = email;
    return email.contains('@'); // mock
  }

  @override
  Future<bool> verifyResetCode({required String email, required String code}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return email == _lastEmail && code == _code;
  }

  @override
  Future<bool> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return (email == _lastEmail && code == _code && newPassword.length >= 6);
  }

  // existing...
  @override
  Future<bool> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return password == '123456';
  }

  @override
  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required double hourlyRate,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
