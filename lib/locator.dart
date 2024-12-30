import 'package:audio_service/audio_service.dart';
import 'package:flutter_base/utils/my_audio_handler.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initGetIt() async {
  sl.registerSingletonAsync<MyAudioHandler>(
    () async {
      final handler = await AudioService.init<MyAudioHandler>(
        builder: MyAudioHandler.new,
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'vn.newwave.flutter_app',
          androidNotificationChannelName: 'Audio playback',
          androidNotificationOngoing: true,
        ),
      );
      return handler;
    },
  );
  await sl.allReady();
}
