import 'package:dartz/dartz.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._remote);
  final AuthRemoteDataSource _remote;

  @override
  Future<Either<Failures, User>> login({
    required LoginCredentials loginCredentials,
  }) async {
    try {
      final ok = await _remote.login(
        email: loginCredentials.email,
        password: loginCredentials.password,
      );
      if (!ok) return Left(AuthFailure('Email or password is incorrect'));
      return Right(User(email: loginCredentials.email, hourlyRate: 55));
    } catch (_) {
      return Left(AuthFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failures, User>> signup({
    required SignupData signUpData,
  }) async {
    try {
      final ok = await _remote.signup(
        name: signUpData.name,
        email: signUpData.email,
        password: signUpData.password,
        hourlyRate: signUpData.hourlyRate,
      );
      if (!ok) return Left(AuthFailure('Signup failed'));
      return Right(
        User(email: signUpData.email, hourlyRate: signUpData.hourlyRate),
      );
    } catch (_) {
      return Left(AuthFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failures, Unit>> requestPasswordReset({
    required String email,
  }) async {
    try {
      final ok = await _remote.requestPasswordReset(email: email);
      if (!ok) return Left(AuthFailure('Email not found'));
      return const Right(unit);
    } catch (_) {
      return Left(AuthFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failures, Unit>> verifyResetCode({
    required String email,
    required String code,
  }) async {
    try {
      final ok = await _remote.verifyResetCode(email: email, code: code);
      if (!ok) return Left(AuthFailure('Invalid code'));
      return const Right(unit);
    } catch (_) {
      return Left(AuthFailure('Something went wrong'));
    }
  }

  @override
  Future<Either<Failures, Unit>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      final ok = await _remote.resetPassword(
        email: email,
        code: code,
        newPassword: newPassword,
      );
      if (!ok) return Left(AuthFailure('Reset failed'));
      return const Right(unit);
    } catch (_) {
      return Left(AuthFailure('Something went wrong'));
    }
  }
}
