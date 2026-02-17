import 'package:equatable/equatable.dart';

class OnboardingStatusEntity extends Equatable {
  final bool isOnboardingCompleted;

  const OnboardingStatusEntity({required this.isOnboardingCompleted});

  @override
  List<Object?> get props => [isOnboardingCompleted];
}
