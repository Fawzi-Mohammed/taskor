import 'package:dartz/dartz.dart';
import 'package:taskor/core/error/failures.dart';
import 'package:taskor/features/splash_onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:taskor/features/splash_onboarding/data/models/onboarding_status_model.dart';
import 'package:taskor/features/splash_onboarding/domain/entities/onboarding_status_model.dart';
import 'package:taskor/features/splash_onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  const OnboardingRepositoryImpl(this._local);
  final OnboardingLocalDataSource _local;
  @override
  Future<Either<Failures, Unit>> completeOnboarding() async {
    try {
      await _local.setOnboardingCompleted();
      return const Right(unit);
    } catch (_) {
      return Left(EmptyCacheFailure());
    }
  }

  @override
  Future<Either<Failures, OnboardingStatusEntity>> getStatus() async {
    try {
      final value = await _local.getOnboardingCompleted();
      return Right(OnboardingStatusModel.fromBool(value));
    } catch (_) {
      return Left(EmptyCacheFailure());
    }
  }

  // Implementation details would go here
}
