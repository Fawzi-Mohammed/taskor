import 'package:dartz/dartz.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  const ForgotPasswordUseCase(this._repo);

  final AuthRepository _repo;

  Future<Either<Failures, String>> call({required String email}) {
    return _repo.forgotPassword(email: email);
  }
}
