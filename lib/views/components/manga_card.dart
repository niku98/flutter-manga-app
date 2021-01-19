import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';

class MangaCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  MangaCard({@required this.imageUrl, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.dimen_140.w,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: Sizes.dimen_140.w,
              height: Sizes.dimen_100.w * 2,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.dimen_6.w, vertical: Sizes.dimen_4.w),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
