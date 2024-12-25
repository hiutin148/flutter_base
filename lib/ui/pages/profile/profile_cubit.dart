import 'package:flutter_base/ui/pages/profile/profile_navigator.dart';
import 'package:flutter_base/ui/pages/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.navigator,
  }) : super(const ProfileState());
  final ProfileNavigator navigator;

  void setVersion(String version) {
    emit(state.copyWith(version: version));
  }
}
