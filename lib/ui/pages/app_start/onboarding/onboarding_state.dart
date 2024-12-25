part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.onboardingStep = OnboardingStep.step1,
  });
  final OnboardingStep onboardingStep;

  @override
  List<Object> get props => [
        onboardingStep,
      ];

  OnboardingState copyWith({
    OnboardingStep? onboardingStep,
  }) {
    return OnboardingState(
      onboardingStep: onboardingStep ?? this.onboardingStep,
    );
  }
}
