part of 'player_controller_cubit.dart';

class PlayerControllerState extends Equatable {
  const PlayerControllerState({
    this.duration = Duration.zero,
    this.positionStream,
    this.playing = false,
  });

  final Duration duration;
  final Stream<Duration>? positionStream;
  final bool playing;

  @override
  List<Object?> get props => [
        duration,
        positionStream,
        playing,
      ];

  PlayerControllerState copyWith({
    Duration? duration,
    Stream<Duration>? positionStream,
    bool? playing,
  }) {
    return PlayerControllerState(
      duration: duration ?? this.duration,
      positionStream: positionStream ?? this.positionStream,
      playing: playing ?? this.playing,
    );
  }
}
