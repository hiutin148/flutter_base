import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_base/utils/notification_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

part 'player_controller_state.dart';

class PlayerControllerCubit extends Cubit<PlayerControllerState> {
  PlayerControllerCubit() : super(const PlayerControllerState());
  late AudioPlayer audioPlayer;

  void initializeAudioPlayer() {
    audioPlayer = AudioPlayer();
  }

  Future<void> play(String url) async {
    unawaited(NotificationUtils.showNotification());
    if (state.playing == true) {
      await audioPlayer.stop();
      emit(
        state.copyWith(
          playing: false,
        ),
      );
    }
    final duration = await audioPlayer.setUrl(url);
    unawaited(audioPlayer.play());
    emit(
      state.copyWith(
        duration: duration,
        positionStream: audioPlayer.positionStream,
        playing: true,
      ),
    );
  }

  void togglePauseResume() {
    if (state.playing) {
      audioPlayer.pause();
      emit(
        state.copyWith(
          playing: false,
        ),
      );
    } else {
      audioPlayer.play();
      emit(
        state.copyWith(
          playing: true,
        ),
      );
    }
  }

  Future<void> seek(double position) async {
    await audioPlayer.seek(Duration(seconds: position.toInt()));
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
