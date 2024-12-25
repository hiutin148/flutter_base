import 'package:flutter/material.dart';
import 'package:flutter_base/models/enums/onboarding_step.dart';
import 'package:flutter_base/ui/pages/app_start/onboarding/onboarding_cubit.dart';
import 'package:flutter_base/ui/pages/app_start/onboarding/onboarding_navigator.dart';
import 'package:flutter_base/ui/pages/app_start/onboarding/widgets/onboarding_footer.dart';
import 'package:flutter_base/ui/pages/app_start/onboarding/widgets/onboarding_sub_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  static const router = 'onBoarding';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return OnboardingCubit(
          navigator: OnboardingNavigator(context: context),
        );
      },
      child: const OnboardingChildPage(),
    );
  }
}

class OnboardingChildPage extends StatefulWidget {
  const OnboardingChildPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OnboardingChildPageState();
  }
}

class _OnboardingChildPageState extends State<OnboardingChildPage> {
  late OnboardingCubit _cubit;
  final PageController _pageViewController = PageController();
  final OnboardingController _onboardingController = OnboardingController();

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<OnboardingCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<OnboardingCubit, OnboardingState>(
          listenWhen: (prev, current) {
            return prev.onboardingStep != current.onboardingStep;
          },
          listener: (context, state) {
            _onboardingController.jumpToStep(step: state.onboardingStep);
            _pageViewController.animateToPage(
              state.onboardingStep.index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageViewController,
                  itemCount: OnboardingStep.values.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return OnboardingSubPage(
                      onboardingStep: OnboardingStepExt.stepFromIndex(index) ??
                          OnboardingStep.step1,
                    );
                  },
                ),
              ),
              OnboardingFooter(
                totalStep: OnboardingStep.values.length,
                controller: _onboardingController,
                onNextTapped: () {
                  _cubit
                    ..jumpNextStep()
                    ..setOnboarded();
                },
                onSkipTapped: () {
                  _cubit.navigator.pop();
                  _cubit.setOnboarded();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _cubit.close();
    super.dispose();
  }
}
