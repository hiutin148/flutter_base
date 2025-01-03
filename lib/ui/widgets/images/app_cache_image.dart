import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';

class AppCacheImage extends StatelessWidget {
  const AppCacheImage({
    super.key,
    this.url = '',
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
  });
  final String url;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final isValidUrl = Uri.tryParse(url)?.isAbsolute ?? false;
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
      ),
      child: isValidUrl
          ? ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius ?? 0),
              child: CachedNetworkImage(
                imageUrl: url,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        backgroundColor: Colors.white,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.secondary,
                        ),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.network(
                    url,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildPlaceHolderImage(),
                    fit: fit,
                  );
                },
                fit: fit,
              ),
            )
          : _buildPlaceHolderImage(),
    );
  }

  Widget _buildPlaceHolderImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: Container(
        color: const Color(0xFFe6e6e6),
      ),
    );
  }
}
