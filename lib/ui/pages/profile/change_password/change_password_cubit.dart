import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/auth_repository.dart';
import 'package:flutter_base/ui/pages/profile/change_password/change_password_navigator.dart';
import 'package:flutter_base/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.navigator,
    required this.authRepo,
  }) : super(const ChangePasswordState());
  final ChangePasswordNavigator navigator;
  final AuthRepository authRepo;

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(state.copyWith(changePasswordStatus: LoadStatus.loading));
    try {
      final result = await authRepo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      if (result) {
        navigator
          ..pop()
          ..showSuccessFlushbar(message: 'Change Password Successfully!');
      } else {
        emit(state.copyWith(changePasswordStatus: LoadStatus.failure));
        navigator.showErrorFlushbar(message: 'Change Password Failed!');
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(changePasswordStatus: LoadStatus.failure));
    }
  }
}
