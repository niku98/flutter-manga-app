import 'package:flutter/material.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/components/manga_card.dart';
import 'package:manga_app/common/extensions/size_extension.dart';

class MangaSectionList extends StatelessWidget {
  final String title;
  final List<Manga> mangas;

  MangaSectionList({@required this.title, @required this.mangas});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: Sizes.dimen_10.w, horizontal: Sizes.dimen_14.w),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          height: Sizes.dimen_86.h,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_14.w),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return MangaCard(
                    imageUrl: mangas[index].thumb, title: mangas[index].title);
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: Sizes.dimen_14.w,
                );
              },
              itemCount: mangas.length),
        ),
      ],
    ));
  }
}
