import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_base/locator.dart';
import 'package:flutter_base/utils/my_audio_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'player_controller_state.dart';

class PlayerControllerCubit extends Cubit<PlayerControllerState> {
  PlayerControllerCubit() : super(const PlayerControllerState());

  final MyAudioHandler myAudioHandler = sl<MyAudioHandler>();

  Future<void> play(int index) async {
    if (myAudioHandler.mediaItem.value != null &&
        myAudioHandler.queue.value.indexOf(
              myAudioHandler.mediaItem.value!,
            ) ==
            index) {
      return;
    }
    if (myAudioHandler.playbackState.value.playing == true) {
      await myAudioHandler.stop();
    }
    await myAudioHandler.skipToQueueItem(index);
    unawaited(myAudioHandler.play());
    emit(
      state.copyWith(
        playingSong: myAudioHandler.mediaItem.value,
      ),
    );
  }

  void togglePauseResume() {
    if (myAudioHandler.playbackState.value.playing) {
      myAudioHandler.pause();
    } else {
      myAudioHandler.play();
    }
  }

  void next() {
    myAudioHandler.skipToNext();
    if (!myAudioHandler.playbackState.value.playing) {
      myAudioHandler.play();
    }
  }

  void previous() {
    myAudioHandler.skipToPrevious();
    if (!myAudioHandler.playbackState.value.playing) {
      myAudioHandler.play();
    }
  }

  Future<void> seek(double position) async {
    await myAudioHandler.seek(Duration(seconds: position.toInt()));
  }
}
