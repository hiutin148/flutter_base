part of 'player_cubit.dart';

class PlayerState extends Equatable {
  const PlayerState({
    this.loadDataStatus = LoadStatus.initial,
  });

  final LoadStatus loadDataStatus;

  @override
  List<Object?> get props => [
        loadDataStatus,
      ];

  PlayerState copyWith({
    LoadStatus? loadDataStatus,
  }) {
    return PlayerState(
      loadDataStatus: loadDataStatus ?? this.loadDataStatus,
    );
  }
}
