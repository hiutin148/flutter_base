part of 'update_profile_cubit.dart';

class UpdateProfileState extends Equatable {
  const UpdateProfileState({
    this.updateUserStatus = LoadStatus.initial,
    this.user,
    this.birthday,
  });
  final LoadStatus updateUserStatus;
  final UserEntity? user;
  final DateTime? birthday;

  @override
  List<Object?> get props => [
        updateUserStatus,
        user,
        birthday,
      ];

  UpdateProfileState copyWith({
    LoadStatus? userStatus,
    UserEntity? user,
    DateTime? birthday,
    String? gender,
  }) {
    return UpdateProfileState(
      updateUserStatus: userStatus ?? updateUserStatus,
      user: user ?? this.user,
      birthday: birthday ?? this.birthday,
    );
  }
}
