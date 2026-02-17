import 'package:dartz/dartz.dart';
import 'package:taskor/features/auth/domain/value_objects/signup_data.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class SignupUseCase {
  const SignupUseCase(this._repo);
  final AuthRepository _repo;

  Future<Either<Failures, Unit>> call({required SignupData data}) {
    return _repo.signup(data: data);
  }
}
