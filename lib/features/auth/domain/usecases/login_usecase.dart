import 'package:dartz/dartz.dart';
import 'package:taskor/features/auth/domain/value_objects/login_credentials.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  const LoginUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failures, User>> call({required LoginCredentials credentials}) {
    return _repo.login(loginCredentials: credentials);
  }
}
