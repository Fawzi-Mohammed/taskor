import 'package:dartz/dartz.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  const LogoutUseCase(this._repo);

  final AuthRepository _repo;

  Future<Either<Failures, Unit>> call() {
    return _repo.logout();
  }
}
