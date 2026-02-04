import 'package:dartz/dartz.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/splash_onboarding/domain/entities/onboarding_status_entity.dart';
import 'package:taskor/features/splash_onboarding/domain/repositories/onboarding_repository.dart';

class CheckOnboardingStatusUseCase {
  const CheckOnboardingStatusUseCase(this._repo);
  final OnboardingRepository _repo;
  Future<Either<Failures, OnboardingStatusEntity>> call() {
    return _repo.getStatus();
  }
}
