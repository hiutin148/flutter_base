import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/photo_view/photo_view_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewArguments {
  PhotoViewArguments({
    required this.images,
  });
  List<String> images;
}

class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({
    required this.arguments,
    super.key,
  });
  final PhotoViewArguments arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return PhotoViewCubit();
      },
      child: PhotoViewChildPage(
        images: arguments.images,
      ),
    );
  }
}

class PhotoViewChildPage extends StatefulWidget {
  const PhotoViewChildPage({
    required this.images,
    super.key,
  });
  final List<String> images;

  @override
  State<PhotoViewChildPage> createState() => _PhotoViewChildPageState();
}

class _PhotoViewChildPageState extends State<PhotoViewChildPage> {
  late final PhotoViewCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBodyWidget(),
    );
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(widget.images[index]),
            );
          },
          itemCount: widget.images.length,
        ),
        Positioned(
          top: 40,
          right: 20,
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
