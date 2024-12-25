import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/global_blocs/player_controller/player_controller_cubit.dart';
import 'package:flutter_base/models/entities/track/track_entity.dart';
import 'package:flutter_base/ui/pages/player/player_cubit.dart';
import 'package:flutter_base/ui/pages/player/player_navigator.dart';
import 'package:flutter_base/utils/extensions/text_style_extension.dart';
import 'package:flutter_base/utils/extensions/theme_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayerPage extends StatelessWidget {
  const PlayerPage({
    required this.track,
    super.key,
  });

  final TrackEntity track;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PlayerCubit(
          navigator: PlayerNavigator(context: context),
        );
      },
      child: PlayerChildPage(
        track: track,
      ),
    );
  }
}

class PlayerChildPage extends StatefulWidget {
  const PlayerChildPage({
    required this.track,
    super.key,
  });

  final TrackEntity track;

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
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingSmall),
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
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
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
                  imageUrl: widget.track.image,
                  width: double.infinity,
                  height: 386,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            widget.track.name,
            style: context.textTheme.headlineSmall?.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.track.artistName,
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
          BlocBuilder<PlayerControllerCubit, PlayerControllerState>(
            buildWhen: (previous, current) {
              return previous.duration != current.duration;
            },
            builder: (context, state) {
              return StreamBuilder<Duration>(
                stream: state.positionStream,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Slider(
                        max: state.duration.inSeconds.toDouble(),
                        value: snapshot.data?.inSeconds.toDouble() ?? 0,
                        onChanged: (position) {
                          _controllerCubit.seek(position);
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDuration(snapshot.data ?? Duration.zero),
                          ),
                          Text(
                            formatDuration(state.duration),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
          buildController(),
        ],
      ),
    );
  }

  Widget buildController() {
    return BlocBuilder<PlayerControllerCubit, PlayerControllerState>(
      buildWhen: (previous, current) {
        return previous.playing != current.playing;
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
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
                state.playing ? Icons.pause : Icons.play_arrow,
                size: 56,
              ),
            ),
            IconButton(
              onPressed: () {},
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
