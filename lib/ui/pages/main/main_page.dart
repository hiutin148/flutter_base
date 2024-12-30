import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/locator.dart';
import 'package:flutter_base/ui/pages/main/main_cubit.dart';
import 'package:flutter_base/ui/pages/main/main_state.dart';
import 'package:flutter_base/ui/pages/main/main_tab.dart';
import 'package:flutter_base/ui/pages/player/player_page.dart';
import 'package:flutter_base/ui/widgets/images/app_cache_image.dart';
import 'package:flutter_base/utils/my_audio_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return _MainPage(
      navigationShell: navigationShell,
    );
  }
}

class _MainPage extends StatefulWidget {
  const _MainPage({required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  final tabs = [
    MainTab.home,
    MainTab.notification,
    MainTab.profile,
  ];

  late MainCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocConsumer<MainCubit, MainState>(
      bloc: _cubit,
      listenWhen: (prev, current) {
        return prev.selectedIndex != current.selectedIndex;
      },
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: showBottomSheet,
              child: Container(
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: StreamBuilder(
                  stream: sl<MyAudioHandler>().mediaItem.stream,
                  builder: (context, snapshot) {
                    final playingSong = snapshot.data;
                    if (playingSong == null) return const SizedBox.shrink();
                    return Column(
                      children: [
                        Row(
                          children: [
                            AppCacheImage(
                              borderRadius: 8,
                              width: 56,
                              height: 56,
                              url: playingSong.artUri.toString(),
                            ),
                            const SizedBox(
                              width: AppDimens.paddingSmall,
                            ),
                            Expanded(
                              child: Text(
                                playingSong.title,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            StreamBuilder(
                              stream: sl<MyAudioHandler>().playbackState.stream,
                              builder: (context, snapshot) {
                                return IconButton(
                                  onPressed: () {
                                    if (snapshot.data != null &&
                                        snapshot.data!.playing) {
                                      sl<MyAudioHandler>().pause();
                                    } else {
                                      sl<MyAudioHandler>().play();
                                    }
                                  },
                                  icon: snapshot.data != null &&
                                          snapshot.data!.playing
                                      ? const Icon(Icons.pause)
                                      : const Icon(Icons.play_arrow),
                                );
                              },
                            ),
                          ],
                        ),
                        StreamBuilder(
                          stream:
                              sl<MyAudioHandler>().audioPlayer.positionStream,
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return const SizedBox.shrink();
                            }
                            return LinearProgressIndicator(
                              value: snapshot.data!.inSeconds /
                                  playingSong.duration!.inSeconds,
                              color: Colors.orange,
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            AnimatedContainer(
              height: state.showBottomNav ? kBottomNavigationBarHeight + 2 : 0,
              duration: const Duration(milliseconds: 300),
              child: state.showBottomNav
                  ? Wrap(
                      children: [
                        BottomNavigationBar(
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          elevation: 0,
                          type: BottomNavigationBarType.fixed,
                          currentIndex: state.selectedIndex,
                          unselectedItemColor: Colors.grey,
                          selectedItemColor: AppColors.primary,
                          items: tabs.map((e) => e.tab).toList(),
                          onTap: (index) {
                            widget.navigationShell.goBranch(
                              index,
                              initialLocation:
                                  index == widget.navigationShell.currentIndex,
                            );
                            _cubit.switchTap(index);
                          },
                          backgroundColor: const Color(0X00FFFFFF),
                        ),
                      ],
                    )
                  : Container(
                      width: MediaQuery.sizeOf(context).width,
                      color: Colors.white,
                    ),
            ),
          ],
        );
      },
    );
  }

  void showBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      useSafeArea: true,
      enableDrag: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return const PlayerPage();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
