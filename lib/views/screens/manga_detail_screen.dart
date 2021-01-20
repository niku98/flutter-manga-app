import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:manga_app/blocs/manga_detail/manga_detail_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/screens/manga_reader_screen.dart';
import 'package:manga_app/views/widgets/manga_genre_tag_list.dart';
import 'package:manga_app/views/widgets/paragraph_loader.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class MangaDetailScreen extends StatefulWidget {
  final Manga manga;

  MangaDetailScreen({@required this.manga});

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> {
  MangaDetailBloc _mangaDetailBloc;

  @override
  void initState() {
    super.initState();
    FlutterStatusbarManager.setColor(Colors.black12, animated: true);
    FlutterStatusbarManager.setStyle(StatusBarStyle.LIGHT_CONTENT);
    FlutterStatusbarManager.setTranslucent(true);

    _mangaDetailBloc = MangaDetailBloc();
    _mangaDetailBloc.add(GetMangaDetail(widget.manga.endpoint));
  }

  @override
  void dispose() {
    _mangaDetailBloc.close();
    FlutterStatusbarManager.setTranslucent(false);
    FlutterStatusbarManager.setStyle(StatusBarStyle.DARK_CONTENT);
    FlutterStatusbarManager.setColor(Colors.white, animated: true);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: _mangaDetailBloc,
        child: BlocBuilder<MangaDetailBloc, MangaDetailState>(
            builder: (context, state) {
          int chapterLength = 0;
          if (state is GotMangaDetail) {
            chapterLength = state.manga.chapter?.length ?? 0;
          }
          return ListView(children: [
            Hero(
                tag: widget.manga,
                flightShuttleBuilder: (BuildContext flightContext,
                        Animation<double> animation,
                        HeroFlightDirection flightDirection,
                        BuildContext fromHeroContext,
                        BuildContext toHeroContext) =>
                    Material(child: toHeroContext.widget),
                child: Container(
                  height: Sizes.dimen_76.h,
                  child: Stack(overflow: Overflow.clip, children: [
                    Stack(children: [
                      CachedNetworkImage(
                        height: Sizes.dimen_76.h,
                        fit: BoxFit.cover,
                        imageUrl: widget.manga.thumb,
                      ),
                      Container(
                        height: Sizes.dimen_76.h,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            bottom: Sizes.dimen_6.h,
                            left: Sizes.dimen_14.w,
                            right: Sizes.dimen_14.w),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.black54, Colors.transparent])),
                        alignment: Alignment.bottomLeft,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(bottom: Sizes.dimen_10.w),
                                child: Text(
                                  widget.manga.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: Colors.white),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  state is GotMangaDetail
                                      ? Flexible(
                                          child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Author: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                TextSpan(
                                                  text: state.manga.author != ""
                                                      ? state.manga.author
                                                      : "Updating",
                                                ),
                                              ])))
                                      : SkeletonBox(
                                          width: Sizes.dimen_100.w,
                                          height: Sizes.dimen_6.h),
                                  state is GotMangaDetail
                                      ? RichText(
                                          text: TextSpan(children: [
                                          TextSpan(
                                              text: "Status: ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          TextSpan(
                                            text: state.manga.status != ""
                                                ? state.manga.status
                                                : "Updating",
                                          ),
                                        ]))
                                      : SkeletonBox(
                                          width: Sizes.dimen_100.w,
                                          height: Sizes.dimen_6.h),
                                ],
                              )
                            ]),
                      )
                    ]),
                    Positioned(
                      child: BackButton(
                        color: Colors.white,
                      ),
                      bottom: Sizes.dimen_76.h / 2,
                    )
                  ]),
                )),
            Padding(
              padding: EdgeInsets.all(Sizes.dimen_14.w),
              child: state is GotMangaDetail
                  ? MangaGenreTagList(
                      state.manga.genreList.map((e) => e.genreName).toList())
                  : MangaGenreTagListLoader(),
            ),
            Padding(
                padding: EdgeInsets.all(Sizes.dimen_14.w),
                child: state is GotMangaDetail
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            state.manga.synopsis,
                            style: Theme.of(context).textTheme.bodyText2,
                          )
                        ],
                      )
                    : ParagraphLoader()),
            Padding(
              padding: EdgeInsets.all(Sizes.dimen_14.w),
              child: Text(
                "Chapters",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(Sizes.dimen_14.w),
              child: state is GotMangaDetail
                  ? Column(
                      children: [
                        for (var i = 0; i < chapterLength; i++)
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MangaReaderScreen(
                                            manga: state.manga,
                                            chapter: state.manga.chapter[i],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: i == 0
                                      ? null
                                      : Border(
                                          top: BorderSide(
                                              color: Colors.grey[100]))),
                              padding: EdgeInsets.symmetric(
                                  vertical: Sizes.dimen_6.h,
                                  horizontal: Sizes.dimen_14.w),
                              width: double.infinity,
                              child: Text(state.manga.chapter[i].chapterTitle),
                            ),
                          )
                      ],
                    )
                  : Column(
                      children: [
                        for (var i = 0; i < 10; i++)
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: Sizes.dimen_1.h),
                            child: SkeletonBox(
                              width: double.infinity,
                              height: Sizes.dimen_14.h,
                            ),
                          )
                      ],
                    ),
            ),
          ]);
        }),
      ),
    );
  }
}

// class TopImageClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.moveTo(0, 0);
//     path.lineTo(size.width, 0);
//     path.lineTo(size.width, size.height);

//     var controlPoint1 =
//         Offset(size.width - size.width / 3, size.height - size.height / 5);
//     var controlPoint2 = Offset(size.width / 2, size.height);
//     var endPoint = Offset(size.width / 3, size.height - 5);

//     path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
//         controlPoint2.dy, endPoint.dx, endPoint.dy);

//     controlPoint1 = Offset(size.width / 5, size.height - 10);
//     endPoint = Offset(size.width / 5, size.height - size.height / 3);
//     path.quadraticBezierTo(
//         controlPoint1.dx, controlPoint1.dy, endPoint.dx, endPoint.dy);

//     controlPoint1 = Offset(size.width / 5, size.height - 50);
//     controlPoint2 = Offset(size.width / 5, size.height / 4);
//     endPoint = Offset(0, size.height / 3);

//     path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
//         controlPoint2.dy, endPoint.dx, endPoint.dy);

//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     // TODO: implement shouldReclip
//     return false;
//   }
// }
