part of 'splash_onboarding_bloc.dart';

sealed class SplashOnboardingState extends Equatable {
  const SplashOnboardingState();
  @override
  List<Object?> get props => [];
}

class SplashInitial extends SplashOnboardingState {
  const SplashInitial();
}

class SplashLoading extends SplashOnboardingState {
  const SplashLoading();
}

class ShowOnboarding extends SplashOnboardingState {
  const ShowOnboarding();
}

class NavigateToHome extends SplashOnboardingState {
  const NavigateToHome();
}

class SplashError extends SplashOnboardingState {
  const SplashError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}