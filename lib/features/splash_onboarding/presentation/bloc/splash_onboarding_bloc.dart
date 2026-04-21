import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskor/core/config/constants/app_strings.dart';
import 'package:taskor/features/splash_onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:taskor/features/splash_onboarding/domain/usecases/complete_onboarding_usecase.dart';

part 'splash_onboarding_event.dart';
part 'splash_onboarding_state.dart';

class SplashOnboardingBloc
    extends Bloc<SplashOnboardingEvent, SplashOnboardingState> {
  SplashOnboardingBloc({
    required CheckOnboardingStatusUseCase checkStatus,
    required CompleteOnboardingUseCase completeOnboarding,
  }) : _checkStatus = checkStatus,
       _completeOnboarding = completeOnboarding,
       super(const SplashInitial()) {
    on<AppStartedEvent>(_onAppStarted);
    on<OnboardingCompletedEvent>(_onCompleted);
  }
  final CheckOnboardingStatusUseCase _checkStatus;
  final CompleteOnboardingUseCase _completeOnboarding;
  Future<void> _onAppStarted(
    AppStartedEvent event,
    Emitter<SplashOnboardingState> emit,
  ) async {
    emit(const SplashLoading());
    final result = await _checkStatus();
    result.fold(
      (_) => emit(const ShowOnboarding()),
      (status) => status.isOnboardingCompleted
          ? emit(const NavigateToHome())
          : emit(const ShowOnboarding()),
    );
  }

  Future<void> _onCompleted(
    OnboardingCompletedEvent event,
    Emitter<SplashOnboardingState> emit,
  ) async {
    emit(const SplashLoading());
    final result = await _completeOnboarding();
    result.fold(
      (_) => emit(const SplashError(AppStrings.errorToSavestatusOfOnboarding)),
      (_) => emit(const NavigateToHome()),
    );
  }
}
