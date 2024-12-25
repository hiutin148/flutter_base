import 'package:equatable/equatable.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/ui/pages/player/player_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_state.dart';

class PlayerCubit extends Cubit<PlayerState> {

  PlayerCubit({
    required this.navigator,
  }) : super(const PlayerState());
  final PlayerNavigator navigator;

  Future<void> loadInitialData() async {
    emit(state.copyWith(loadDataStatus: LoadStatus.initial));
    try {
      //Todo: add API calls
      emit(state.copyWith(loadDataStatus: LoadStatus.success));
    } catch (e, s) {
      //Todo: should print exception here
      emit(state.copyWith(loadDataStatus: LoadStatus.failure));
    }
  }
}
