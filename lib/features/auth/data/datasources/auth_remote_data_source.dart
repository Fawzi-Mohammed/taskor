abstract class AuthRemoteDataSource {
  Future<bool> login({required String email, required String password});
  Future<bool> signup({
    required String name,
    required String email,
    required String password,
    required double hourlyRate,
  });
}

class AuthRemoteDataSourceMock implements AuthRemoteDataSource {
  @override
  Future<bool> login({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    // ✅ مثال بسيط: لو password != 123456 اعتبره فشل
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
    return true; // mock success
  }
}
