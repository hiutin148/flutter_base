import 'package:equatable/equatable.dart';
import 'package:flutter_base/database/share_preferences_helper.dart';
import 'package:flutter_base/models/enums/onboarding_step.dart';
import 'package:flutter_base/ui/pages/app_start/onboarding/onboarding_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({
    required this.navigator,
  }) : super(const OnboardingState());
  OnboardingNavigator navigator;

  void jumpNextStep() {
    final currentStep = state.onboardingStep;
    if (currentStep == OnboardingStep.lastStep) {
      navigator.openSignIn();
      return;
    }
    emit(state.copyWith(onboardingStep: currentStep.nextStep));
  }

  void setOnboarded() {
    SharedPreferencesHelper.setOnboarded();
  }
}
