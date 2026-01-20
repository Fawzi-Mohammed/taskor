import 'package:dartz/dartz.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failures, User>> login({
    required LoginCredentials loginCredentials,
  });

  Future<Either<Failures, User>> signup({required SignupData signUpData});
}
