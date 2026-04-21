import 'package:taskor/core/config/constants/request_constants.dart';
import 'package:taskor/core/error/exceptions.dart';
import 'package:taskor/core/services/remote/dio_handler.dart';
import 'package:taskor/features/auth/data/models/forgot_password_response_model.dart';
import 'package:taskor/features/auth/data/models/login_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });

  Future<void> signup({
    required String name,
    required String username,
    required String email,
    required String password,
    required double hourlyRate,
  });

  Future<ForgotPasswordResponseModel> forgotPassword({required String email});

  Future<void> verifyResetCode({required String email, required String code});

  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dioHandler);

  final DioHandler _dioHandler;

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _postWithFallback(
      paths: [RequestConstants.loginPath],
      body: <String, dynamic>{'email': email, 'password': password},
    );

    return LoginResponseModel.fromJson(response);
  }

  @override
  Future<void> signup({
    required String name,
    required String username,
    required String email,
    required String password,
    required double hourlyRate,
  }) async {
    await _postWithFallback(
      paths: [RequestConstants.signupPath],
      body: <String, dynamic>{
        'name': name,
        'username': username,
        'email': email,
        'password': password,
        'WatchCost': hourlyRate % 1 == 0 ? hourlyRate.toInt() : hourlyRate,
      },
    );
  }

  @override
  Future<ForgotPasswordResponseModel> forgotPassword({
    required String email,
  }) async {
    final response = await _postWithFallback(
      paths: [RequestConstants.forgotPasswordPath],
      body: <String, dynamic>{'email': email},
    );

    return ForgotPasswordResponseModel.fromJson(response);
  }

  @override
  Future<void> verifyResetCode({
    required String email,
    required String code,
  }) async {
    final parsedCode = int.tryParse(code.trim());
    await _postWithFallback(
      paths: [RequestConstants.verifyResetCodePath],
      body: <String, dynamic>{'code': parsedCode ?? code.trim()},
    );
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    await _postWithFallback(
      paths: [RequestConstants.resetPasswordPath],
      body: <String, dynamic>{'email': email, 'newPassword': newPassword},
    );
  }

  Future<Map<String, dynamic>> _postWithFallback({
    required List<String> paths,
    required Map<String, dynamic> body,
  }) async {
    AuthException? lastAuthException;

    for (var index = 0; index < paths.length; index++) {
      final isLastPath = index == paths.length - 1;
      final path = paths[index];

      try {
        final response = await _dioHandler.post(path, body: body);
        return response.data ?? <String, dynamic>{};
      } on AuthException catch (error) {
        lastAuthException = error;
        if (error.statusCode == 404 && !isLastPath) {
          continue;
        }
        rethrow;
      }
    }

    throw lastAuthException ?? AuthException('Request failed');
  }
}
