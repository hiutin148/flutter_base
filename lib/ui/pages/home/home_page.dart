import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/common/app_dimens.dart';
import 'package:flutter_base/configs/app_configs.dart';
import 'package:flutter_base/global_blocs/player_controller/player_controller_cubit.dart';
import 'package:flutter_base/global_blocs/user/user_cubit.dart';
import 'package:flutter_base/models/entities/track/track_entity.dart';
import 'package:flutter_base/models/entities/user/user_entity.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/track_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/home/home_cubit.dart';
import 'package:flutter_base/ui/pages/home/home_navigator.dart';
import 'package:flutter_base/ui/pages/home/home_state.dart';
import 'package:flutter_base/ui/widgets/list/list_empty_widget.dart';
import 'package:flutter_base/ui/widgets/list/list_error_widget.dart';
import 'package:flutter_base/ui/widgets/list/list_loading_widget.dart';
import 'package:flutter_base/utils/extensions/text_style_extension.dart';
import 'package:flutter_base/utils/extensions/theme_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return HomeCubit(
          navigator: HomeNavigator(context: context),
          trackRepo: context.read<TrackRepository>(),
        );
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  final _scrollController = ScrollController();
  late HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<HomeCubit>();
    _cubit.fetchInitialMovies();
    context.read<UserCubit>().updateUser(UserEntity.mockData());
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.alice.showInspector();
        },
      ),
    );
  }

  Widget _buildBodyWidget() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.loadMovieStatus == LoadStatus.initial) {
          return Container();
        } else if (state.loadMovieStatus == LoadStatus.loading) {
          return const ListLoadingWidget();
        } else if (state.loadMovieStatus == LoadStatus.failure) {
          return const ListErrorWidget();
        } else {
          if (state.featuredTracks.isEmpty) {
            return ListEmptyWidget(onRefresh: _onRefreshData);
          } else {
            return _buildSuccessList(state.featuredTracks);
          }
        }
      },
    );
  }

  Widget _buildSuccessList(List<TrackEntity> items) {
    return RefreshIndicator(
      onRefresh: _onRefreshData,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'Recommended for you today. 🥰',
                style: context.textTheme.headlineMedium?.w600,
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: AppDimens.paddingNormal),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(AppDimens.paddingNormal),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: AppColors.gray1,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: AppDimens.paddingNormal),
                    Text(
                      'Discover new movies',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList.separated(
              itemBuilder: (context, index) {
                final item = items[index];
                return InkWell(
                  onTap: () async {
                    if (context.mounted) {
                      unawaited(
                        context.pushNamed(
                          AppRouter.player,
                          extra: item,
                        ),
                      );
                    }
                    context.loaderOverlay.show();
                    unawaited(BlocProvider.of<PlayerControllerCubit>(context)
                        .play(
                      item.audio,
                    )
                        .then(
                      (value) {
                        context.loaderOverlay.hide();
                      },
                    ));
                  },
                  child: ListTile(
                    title: Text(item.name),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: AppDimens.paddingNormal);
              },
              itemCount: items.length,
            ),
          ],
        ),
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= AppConfigs.scrollThreshold) {
      _cubit.fetchNextMovies();
    }
  }

  Future<void> _onRefreshData() async {
    unawaited(_cubit.fetchInitialMovies());
  }
}
