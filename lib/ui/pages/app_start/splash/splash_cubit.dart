import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/ui/pages/app_start/splash/splash_navigator.dart';
import 'package:flutter_base/ui/pages/app_start/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.navigator,
    required this.authRepo,
  }) : super(const SplashState());
  final SplashNavigator navigator;
  final AuthRepository authRepo;

  Future<void> fetchInitialData() async {
    final isLoggedIn = await _isLoggedIn();
    if (isLoggedIn) {
      // Handle user logged in
    }
  }

  Future<void> checkLogin() async {
    final isLoggedIn = await _isLoggedIn();
    if (isLoggedIn) {
      await navigator.openHomePage();
    } else {
      await navigator.openSignIn();
    }
  }

  Future<bool> _isLoggedIn() async {
    final token = await authRepo.getToken();
    final isLoggedIn = token != null;
    return true;
  }

  Future<bool> isLoggedIn() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final token = await authRepo.getToken();
    final isLoggedIn = token != null;
    return isLoggedIn;
  }
}
