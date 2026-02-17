import 'package:dartz/dartz.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failures, User>> login({required LoginCredentials credentials});

  Future<Either<Failures, Unit>> signup({required SignupData data});

  Future<Either<Failures, Unit>> logout();

  Future<Either<Failures, String>> forgotPassword({required String email});

  Future<Either<Failures, Unit>> verifyResetCode({
    required String email,
    required String code,
  });

  Future<Either<Failures, Unit>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
    required String confirmPassword,
  });
}
