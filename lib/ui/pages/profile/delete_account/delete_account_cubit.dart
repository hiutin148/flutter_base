import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/profile/delete_account/delete_account_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({
    required this.navigator,
  }) : super(const DeleteAccountState());
  final DeleteAccountNavigator navigator;

  Future<void> loadInitialData() async {
    emit(state.copyWith(deleteAccountStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(deleteAccountStatus: LoadStatus.success));
    } catch (e) {
      //Todo: should print exception here
      emit(state.copyWith(deleteAccountStatus: LoadStatus.failure));
    }
  }
}
