import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/screens/manga_detail_screen.dart';
import 'package:manga_app/views/widgets/cache_image_with_skeleton.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class MangaHorizontalCard extends StatelessWidget {
  final MangaFromSearch manga;

  MangaHorizontalCard(this.manga);

  @override
  Widget build(BuildContext context) {
    final Manga innerManga =
        Manga(title: manga.title, thumb: manga.thumb, endpoint: manga.endpoint);

    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MangaDetailScreen(manga: innerManga)));
        },
        child: Stack(
          overflow: Overflow.clip,
          alignment: AlignmentDirectional.centerStart,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
                  boxShadow: [
                    BoxShadow(color: Colors.black12, blurRadius: 3),
                  ]),
              padding: EdgeInsets.only(
                left: Sizes.dimen_24.w,
                top: Sizes.dimen_14.w,
                bottom: Sizes.dimen_14.w,
                right: Sizes.dimen_14.w,
              ),
              alignment: Alignment.topLeft,
              width: double.infinity,
              height:
                  MediaQuery.of(context).size.width / 3 - Sizes.dimen_10.w * 2,
              margin: EdgeInsets.only(
                  left:
                      MediaQuery.of(context).size.width / 3 - Sizes.dimen_14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    manga.title,
                    overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    manga.type,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey),
                  ),
                  Text(
                    manga.updatedOn,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
              ),
              child: Hero(
                  tag: innerManga,
                  child: CacheImageWithSkeleton(
                    manga.thumb,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 3,
                  )),
            )
          ],
        ));
  }
}

class MangaHorizontalCardLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.clip,
      alignment: AlignmentDirectional.centerStart,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Sizes.dimen_10.w),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 3),
              ]),
          padding: EdgeInsets.only(
            left: Sizes.dimen_24.w,
            top: Sizes.dimen_14.w,
            bottom: Sizes.dimen_14.w,
            right: Sizes.dimen_14.w,
          ),
          alignment: Alignment.topLeft,
          width: double.infinity,
          height: MediaQuery.of(context).size.width / 3 - Sizes.dimen_10.w * 2,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 3 - Sizes.dimen_14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SkeletonBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: Sizes.dimen_14.w),
              SizedBox(
                height: Sizes.dimen_10.w,
              ),
              SkeletonBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: Sizes.dimen_10.w),
              SizedBox(
                height: Sizes.dimen_10.w,
              ),
              SkeletonBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: Sizes.dimen_8.w),
            ],
          ),
        ),
        SkeletonBox(
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 3,
          borderRadius: Sizes.dimen_10.w,
        )
      ],
    );
  }
}
