import 'package:dartz/dartz.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/splash_onboarding/domain/entities/onboarding_status_entity.dart';

abstract class OnboardingRepository {
  Future<Either<Failures, OnboardingStatusEntity>> getStatus();
  Future<Either<Failures, Unit>> completeOnboarding();
}
