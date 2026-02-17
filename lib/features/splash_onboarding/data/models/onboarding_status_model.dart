import 'package:taskor/features/splash_onboarding/domain/entities/onboarding_status_entity.dart';

class OnboardingStatusModel extends OnboardingStatusEntity {
  const OnboardingStatusModel({required super.isOnboardingCompleted});

  factory OnboardingStatusModel.fromBool(bool value) {
    return OnboardingStatusModel(isOnboardingCompleted: value);
  }
}
