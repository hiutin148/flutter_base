import 'package:flutter_base/ui/pages/main/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  ///Switch tab
  void switchTap(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
