import 'package:dartz/dartz.dart';
import 'package:taskor/core/error/exceptions.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:taskor/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskor/features/auth/data/models/user_model.dart';
import 'package:taskor/features/auth/domain/entities/user.dart';
import 'package:taskor/features/auth/domain/repositories/auth_repository.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote, this._local);

  final AuthRemoteDataSource _remote;
  final AuthLocalDataSource _local;

  @override
  Future<Either<Failures, User>> login({
    required LoginCredentials credentials,
  }) async {
    try {
      final response = await _remote.login(
        email: credentials.email,
        password: credentials.password,
      );

      await _local.cacheRememberMe(credentials.rememberMe);
      await _local.cacheHasSignedUp(true);

      if (credentials.rememberMe) {
        await _local.cacheToken(response.token);
        final watchCost = response.watchCost;
        if (watchCost != null) {
          await _local.cacheWatchCost(watchCost);
        }
      } else {
        await _local.clearToken();
        await _local.clearWatchCost();
      }

      final userModel = UserModel.fromJson(
        response.responseBody,
        fallbackIdentifier: credentials.email,
      );

      return Right(userModel.toEntity());
    } catch (error) {
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failures, Unit>> signup({required SignupData data}) async {
    try {
      await _remote.signup(
        name: data.name,
        username: data.safeUsername,
        email: data.email,
        password: data.password,
        hourlyRate: data.hourlyRate,
      );
      await _local.cacheHasSignedUp(true);

      return const Right(unit);
    } catch (error) {
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failures, Unit>> logout() async {
    try {
      await _local.clearToken();
      await _local.clearWatchCost();
      await _local.cacheRememberMe(false);
      return const Right(unit);
    } catch (error) {
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failures, String>> forgotPassword({
    required String email,
  }) async {
    try {
      final response = await _remote.forgotPassword(email: email);
      return Right(response.verificationCode);
    } catch (error) {
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failures, Unit>> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      await _remote.verifyResetCode(email: email, code: code);
      return const Right(unit);
    } catch (error) {
      return Left(_mapFailure(error));
    }
  }

  @override
  Future<Either<Failures, Unit>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      await _remote.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );

      return const Right(unit);
    } catch (error) {
      return Left(_mapFailure(error));
    }
  }

  Failures _mapFailure(Object error) {
    if (error is OfflineException) {
      return OfflineFailure(error.message);
    }

    if (error is ServerException) {
      return ServerFailure(error.message);
    }

    if (error is AuthException) {
      return AuthFailure(error.message);
    }

    if (error is FormatException) {
      return AuthFailure(error.message);
    }

    return const UnexpectedFailure('Unexpected auth error');
  }
}
