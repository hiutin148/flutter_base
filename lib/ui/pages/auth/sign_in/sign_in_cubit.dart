import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/repositories/user_repository.dart';
import 'package:flutter_base/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit({
    required this.navigator,
    required this.authRepo,
    required this.userRepo,
    required this.userCubit,
  }) : super(const SignInState());
  final SignInNavigator navigator;
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final UserCubit userCubit;

  void changeEmail({required String email}) {
    emit(state.copyWith(email: email));
  }

  void changePassword({required String password}) {
    emit(state.copyWith(password: password));
  }

  Future<void> signIn() async {
    final email = state.email ?? '';
    final password = state.password ?? '';
    if (email.isEmpty) {
      navigator.showErrorFlushbar(message: 'Username is empty');
      return;
    }
    if (password.isEmpty) {
      navigator.showErrorFlushbar(message: 'Password is empty');
      return;
    }
    emit(state.copyWith(signInStatus: LoadStatus.loading));
    try {
      final result = await authRepo.signIn(email, password);
      if (result != null) {
        final myProfile = await userRepo.getProfile();
        userCubit.updateUser(myProfile);
        unawaited(authRepo.saveToken(result));
        emit(state.copyWith(signInStatus: LoadStatus.success));
        unawaited(navigator.openHomePage());
      } else {
        emit(state.copyWith(signInStatus: LoadStatus.failure));
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(signInStatus: LoadStatus.failure));
    }
  }
}
