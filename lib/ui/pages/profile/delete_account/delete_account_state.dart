part of 'delete_account_cubit.dart';

class DeleteAccountState extends Equatable {
  const DeleteAccountState({
    this.deleteAccountStatus = LoadStatus.initial,
  });
  final LoadStatus deleteAccountStatus;

  @override
  List<Object?> get props => [
        deleteAccountStatus,
      ];

  DeleteAccountState copyWith({
    LoadStatus? deleteAccountStatus,
  }) {
    return DeleteAccountState(
      deleteAccountStatus: deleteAccountStatus ?? this.deleteAccountStatus,
    );
  }
}
