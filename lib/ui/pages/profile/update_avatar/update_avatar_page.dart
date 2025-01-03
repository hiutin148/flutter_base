import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/profile/update_avatar/update_avatar_cubit.dart';
import 'package:flutter_base/ui/pages/profile/update_avatar/update_avatar_navigator.dart';
import 'package:flutter_base/ui/widgets/images/app_circle_avatar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateAvatarPage extends StatelessWidget {
  const UpdateAvatarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return UpdateAvatarCubit(
          navigator: UpdateAvatarNavigator(context: context),
        );
      },
      child: const UpdateAvatarChildPage(),
    );
  }
}

class UpdateAvatarChildPage extends StatefulWidget {
  const UpdateAvatarChildPage({super.key});

  @override
  State<UpdateAvatarChildPage> createState() => _UpdateAvatarChildPageState();
}

class _UpdateAvatarChildPageState extends State<UpdateAvatarChildPage> {
  late final UpdateAvatarCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar'),
        actions: [
          BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
            builder: (context, state) {
              return _cubit.state.image == null
                  ? TextButton(
                      onPressed: () async {
                        unawaited(
                          showOption(
                            chooseImageCollection: () {},
                            chooseImageCamera: () {},
                          ),
                        );
                      },
                      child: const Text('thay đổi'),
                    )
                  : TextButton(
                      onPressed: () async {},
                      child: const Text('cập nhật'),
                    );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: _buildBodyWidget(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    return Center(
      child: BlocBuilder<UpdateAvatarCubit, UpdateAvatarState>(
        builder: (context, state) {
          return state.image == null
              ? const AppCircleAvatar(size: Size(400, 400))
              : ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.file(
                    state.image ?? File(''),
                    width: 400,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                );
        },
      ),
    );
  }

  Future<void> showOption({
    required void Function() chooseImageCollection,
    required void Function() chooseImageCamera,
  }) async {
    // AppBottomSheet.show(Container(
    //   height: 200,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20),
    //     color: Colors.white,
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       InkWell(
    //         onTap: () {
    //           chooseImageCollection();
    //         },
    //         child: const Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Icon(
    //               Icons.collections,
    //               size: 60,
    //               color: Colors.grey,
    //             ),
    //             Text(
    //               "choose from the collection",
    //             ),
    //           ],
    //         ),
    //       ),
    //       const InkWell(
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Icon(
    //               Icons.photo_camera,
    //               size: 60,
    //               color: Colors.grey,
    //             ),
    //             Text(
    //               'take a photo',
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
