part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.email,
    this.password,
  });
  final LoadStatus signInStatus;
  final String? email;
  final String? password;

  @override
  List<Object?> get props => [
        signInStatus,
        email,
        password,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? email,
    String? password,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
