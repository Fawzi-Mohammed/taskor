import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  const VerifyResetCodeUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failures, Unit>> call({
    required String email,
    required String code,
  }) {
    return _repo.verifyResetCode(email: email, code: code);
  }
}
