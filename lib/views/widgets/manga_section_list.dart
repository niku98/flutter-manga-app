import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/widgets/manga_card.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/views/widgets/section.dart';
import 'package:manga_app/views/widgets/section_title.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class MangaSectionList extends StatelessWidget {
  final String title;
  final List<Manga> mangas;

  MangaSectionList({@required this.title, @required this.mangas});

  @override
  Widget build(BuildContext context) {
    return Section(
      title: title,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return MangaCard(mangas[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: Sizes.dimen_14.w,
            );
          },
          itemCount: mangas.length),
      contentHeight: Sizes.dimen_140.w * 3 / 2 + 40,
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
    );
  }
}

class MangaSectionListLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_10.w, horizontal: Sizes.dimen_14.w),
          // child: Text(
          //   title,
          //   style: Theme.of(context)
          //       .textTheme
          //       .headline5
          //       .copyWith(fontWeight: FontWeight.bold),
          // ),
          child: SkeletonBox(
            width: Sizes.dimen_100.w,
            height: Sizes.dimen_20.w,
          ),
        ),
        Container(
          height: Sizes.dimen_86.h,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MangaCardLoader();
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: Sizes.dimen_14.w,
                );
              },
              itemCount: 3),
        ),
      ],
    ));
  }
}
