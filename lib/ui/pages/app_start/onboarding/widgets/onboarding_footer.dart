import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/generated/l10n.dart';
import 'package:flutter_base/models/enums/onboarding_step.dart';
import 'package:flutter_base/ui/pages/app_start/onboarding/widgets/onboarding_indicator.dart';
import 'package:flutter_base/ui/widgets/buttons/app_text_button.dart';

class OnboardingController extends ValueNotifier<OnboardingStep> {
  OnboardingController({
    OnboardingStep step = OnboardingStep.step1,
  }) : super(step);

  Future<void> jumpToStep({required OnboardingStep step}) async {
    value = step;
  }
}

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({
    required this.totalStep,
    required this.controller,
    required this.onSkipTapped,
    required this.onNextTapped,
    super.key,
  });
  final int totalStep;
  final OnboardingController controller;
  final VoidCallback onSkipTapped;
  final VoidCallback onNextTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimens.buttonHeight,
      margin: const EdgeInsets.all(AppDimens.paddingNormal),
      child: ValueListenableBuilder(
        valueListenable: controller,
        builder: (context, step, widget) {
          return Stack(
            children: [
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextButton(
                      title: S.of(context).button_skip,
                      onPressed: onSkipTapped,
                    ),
                    Visibility(
                      visible: step != OnboardingStep.lastStep,
                      child: AppTextButton(
                        title: S.of(context).button_next,
                        onPressed: onNextTapped,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: OnboardingIndicator(
                  totalDots: totalStep,
                  currentIndex: step.index,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
