import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class CacheImageWithSkeleton extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;

  CacheImageWithSkeleton(this.imageUrl,
      {this.height, this.width, this.fit, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(Sizes.dimen_10.w),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit ?? BoxFit.cover,
        width: width,
        height: height,
        placeholder: (context, url) {
          return SkeletonBox(
              width: width ?? MediaQuery.of(context).size.width,
              height: height ?? MediaQuery.of(context).size.width);
        },
      ),
    );
  }
}
