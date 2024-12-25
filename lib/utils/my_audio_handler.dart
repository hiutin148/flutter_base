import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  AudioPlayer audioPlayer = AudioPlayer();

  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  void _listenForCurrentSongIndexChange() {
    audioPlayer.currentIndexStream.listen(
      (index) {
        final playlist = queue.value;
        if (index == null || playlist.isEmpty) return;
        mediaItem.add(playlist[index]);
      },
    );
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex,
      ),
    );
  }

  Future<void> initSongs({required List<MediaItem> songs}) async {
    audioPlayer.playbackEventStream.listen(_broadcastState);
    final audioSource = songs.map(_createAudioSource);
    await audioPlayer.setAudioSource(ConcatenatingAudioSource(children: audioSource.toList()));
    final newQueue = queue.value..addAll(songs);
    queue.add(newQueue);
    _listenForCurrentSongIndexChange();
    audioPlayer.processingStateStream.listen(
      (state) {
        if (state == ProcessingState.completed) skipToNext();
      },
    );
  }

  @override
  Future<void> play() async => audioPlayer.play();

  @override
  Future<void> pause() async => audioPlayer.pause();

  @override
  Future<void> seek(Duration position) async => audioPlayer.seek(position);

  @override
  Future<void> skipToQueueItem(int index) async => audioPlayer.seek(
        Duration.zero,
        index: index,
      );

  @override
  Future<void> skipToNext() async => audioPlayer.seekToNext();

  @override
  Future<void> skipToPrevious() async => audioPlayer.seekToPrevious();
}
