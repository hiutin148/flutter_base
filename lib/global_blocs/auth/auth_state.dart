part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.signOutStatus = LoadStatus.initial,
  });
  final LoadStatus signOutStatus;

  @override
  List<Object?> get props => [
        signOutStatus,
      ];

  AuthState copyWith({
    LoadStatus? signOutStatus,
  }) {
    return AuthState(
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }
}
