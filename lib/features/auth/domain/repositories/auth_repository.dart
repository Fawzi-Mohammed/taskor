import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failures, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> signup({
    required String name,
    required String email,
    required String password,
    required String hourlyRate,
  });
}
