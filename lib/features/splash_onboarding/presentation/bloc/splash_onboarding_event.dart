part of 'splash_onboarding_bloc.dart';

sealed class SplashOnboardingEvent extends Equatable {
  const SplashOnboardingEvent();

  @override
  List<Object> get props => [];
}

class AppStartedEvent extends SplashOnboardingEvent {
  const AppStartedEvent();
}

class OnboardingCompletedEvent extends SplashOnboardingEvent {
  const OnboardingCompletedEvent();
}
