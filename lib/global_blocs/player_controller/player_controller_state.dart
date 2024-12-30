part of 'player_controller_cubit.dart';

class PlayerControllerState extends Equatable {
  const PlayerControllerState({
    this.playingSong,
  });

  final MediaItem? playingSong;

  @override
  List<Object?> get props => [
        playingSong,
      ];

  PlayerControllerState copyWith({
    bool? playing,
    MediaItem? playingSong,
  }) {
    return PlayerControllerState(
      playingSong: playingSong ?? this.playingSong,
    );
  }
}
