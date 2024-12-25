part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    this.changePasswordStatus = LoadStatus.initial,
  });
  final LoadStatus changePasswordStatus;

  @override
  List<Object?> get props => [
        changePasswordStatus,
      ];

  ChangePasswordState copyWith({
    LoadStatus? changePasswordStatus,
  }) {
    return ChangePasswordState(
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
    );
  }
}
