import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class RequestPasswordResetUseCase {
  const RequestPasswordResetUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failures, Unit>> call({required String email}) {
    return _repo.requestPasswordReset(email: email);
  }
}
