import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  const ResetPasswordUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failures, Unit>> call({
    required String email,
    required String code,
    required String newPassword,
  }) {
    return _repo.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
  }
}
