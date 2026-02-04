import 'package:dartz/dartz.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/splash_onboarding/domain/repositories/onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final OnboardingRepository _repo;
  const CompleteOnboardingUseCase(this._repo);
  Future<Either<Failures, Unit>> call() {
    return _repo.completeOnboarding();
  }
}
