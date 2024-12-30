import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/global_blocs/player_controller/player_controller_cubit.dart';
import 'package:flutter_base/locator.dart';
import 'package:flutter_base/ui/pages/main/main_cubit.dart';
import 'package:flutter_base/ui/pages/player/player_cubit.dart';
import 'package:flutter_base/ui/pages/player/player_navigator.dart';
import 'package:flutter_base/utils/extensions/text_style_extension.dart';
import 'package:flutter_base/utils/extensions/theme_extension.dart';
import 'package:flutter_base/utils/my_audio_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PlayerCubit(
          navigator: PlayerNavigator(context: context),
        );
      },
      child: const PlayerChildPage(),
    );
  }
}

class PlayerChildPage extends StatefulWidget {
  const PlayerChildPage({
    super.key,
  });

  @override
  State<PlayerChildPage> createState() => _PlayerChildPageState();
}

class _PlayerChildPageState extends State<PlayerChildPage> {
  late final PlayerCubit _cubit;
  late final PlayerControllerCubit _controllerCubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
    _controllerCubit = BlocProvider.of(context);
    _cubit.loadInitialData();
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      imageProvider,
    );
    print(paletteGenerator);

    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        BlocProvider.of<MainCubit>(context).toggleBottomNavVisibility(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.accent.withOpacity(0.8),
        body: SafeArea(
          child: _buildBodyWidget(),
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return StreamBuilder<MediaItem?>(
      stream: sl<MyAudioHandler>().mediaItem.stream,
      builder: (context, snapshot) {
        final playingSong = snapshot.data;
        if (playingSong == null) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      context.pop();
                      // final color = await getImagePalette(NetworkImage(widget.track.image));
                      // print(color);
                    },
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              buildArtImage(playingSong.artUri.toString()),
              const SizedBox(
                height: 16,
              ),
              Text(
                playingSong.title,
                style: context.textTheme.headlineSmall?.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    playingSong.artist ?? '',
                    style: context.textTheme.titleMedium?.white67,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      size: 28,
                    ),
                  ),
                ],
              ),
              buildProgress(snapshot.data!),
              buildController(),
            ],
          ),
        );
      },
    );
  }

  Widget buildArtImage(String url) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: CachedNetworkImage(
            imageUrl: url,
            width: double.infinity,
            height: 386,
            fit: BoxFit.cover,
            errorWidget: (context, url, error) {
              return Container(
                color: Colors.grey,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildProgress(MediaItem mediaItem) {
    final duration = mediaItem.duration?.inSeconds.toDouble() ?? 0;
    return StreamBuilder<Duration>(
      stream: AudioService.position,
      builder: (context, snapshot) {
        final currentPosition = snapshot.data?.inSeconds.toDouble() ??
            sl<MyAudioHandler>().audioPlayer.position.inSeconds.toDouble();
        return Column(
          children: [
            Slider(
              max: duration,
              value: currentPosition,
              onChanged: (position) {
                _controllerCubit.seek(position);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(Duration(seconds: currentPosition.toInt())),
                  style: context.textTheme.bodySmall?.white67,
                ),
                Text(
                  formatDuration(Duration(seconds: duration.toInt())),
                  style: context.textTheme.bodySmall?.white67,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget buildController() {
    return StreamBuilder(
      stream: sl<MyAudioHandler>().playbackState.stream,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                _controllerCubit.previous();
              },
              icon: const Icon(
                Icons.skip_previous,
                size: 56,
              ),
            ),
            IconButton(
              onPressed: () {
                _controllerCubit.togglePauseResume();
              },
              icon: Icon(
                snapshot.data?.playing == true ? Icons.pause : Icons.play_arrow,
                size: 56,
              ),
            ),
            IconButton(
              onPressed: () {
                _controllerCubit.next();
              },
              icon: const Icon(
                Icons.skip_next,
                size: 56,
              ),
            ),
          ],
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
