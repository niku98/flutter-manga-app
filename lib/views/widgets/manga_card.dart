import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/screens/manga_detail_screen.dart';
import 'package:manga_app/views/widgets/cache_image_with_skeleton.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class MangaCard extends StatelessWidget {
  final Manga manga;
  final double width;

  MangaCard(this.manga, {this.width});

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? Sizes.dimen_140.w;

    return Container(
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MangaDetailScreen(manga: manga)));
        },
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
                child: Hero(
                  tag: manga,
                  child: CacheImageWithSkeleton(
                    manga.thumb,
                    width: width,
                    height: width * 3 / 2,
                    fit: BoxFit.cover,
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Sizes.dimen_6.w, vertical: Sizes.dimen_4.w),
              child: Text(
                manga.title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: Sizes.dimen_16.sp, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MangaCardLoader extends StatelessWidget {
  final double width;
  MangaCardLoader({this.width});

  @override
  Widget build(BuildContext context) {
    final width = this.width ?? Sizes.dimen_140.w;
    return Container(
      width: width,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
            child: SkeletonBox(
              width: width,
              height: width * 3 / 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.dimen_6.w, vertical: Sizes.dimen_4.w),
            child: SkeletonBox(
              width: width - Sizes.dimen_14.w,
              height: Sizes.dimen_14.w,
            ),
          )
        ],
      ),
    );
  }
}
