import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:manga_app/blocs/chapter_detail/chapter_detail_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/models/chapter.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

class MangaReaderScreen extends StatefulWidget {
  final ChapterShorted chapter;
  final MangaDetail manga;

  MangaReaderScreen({@required this.manga, @required this.chapter});

  @override
  _MangaReaderScreenState createState() => _MangaReaderScreenState();
}

class _MangaReaderScreenState extends State<MangaReaderScreen> {
  ChapterDetailBloc _chapterDetailBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterStatusbarManager.setHidden(true);

    _chapterDetailBloc = new ChapterDetailBloc();
    _chapterDetailBloc
        .add(new GetChapterDetail(widget.chapter.chapterEndpoint));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _chapterDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider<ChapterDetailBloc>.value(
            value: _chapterDetailBloc,
            child: Scaffold(
              body: BlocBuilder<ChapterDetailBloc, ChapterDetailState>(
                  builder: (context, state) {
                return NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder: (context, scrolled) {
                      return [
                        SliverAppBar(
                          floating: true,
                          backgroundColor: Colors.transparent,
                          expandedHeight: Sizes.dimen_20.h,
                          flexibleSpace: Opacity(
                            opacity: 0.1,
                            child: Container(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(widget.manga.title),
                        )
                      ];
                    },
                    body: state is GotChapterDetail
                        ? ListView.separated(
                            itemBuilder: (context, index) {
                              return InteractiveViewer(
                                child: CachedNetworkImage(
                                  imageUrl: state.chapter.chapterImage[index]
                                      .chapterImageLink,
                                  placeholder: (context, url) {
                                    return SkeletonBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width);
                                  },
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: Sizes.dimen_1.h,
                              );
                            },
                            itemCount: state.chapter.chapterPages)
                        : ListView.separated(
                            itemBuilder: (context, index) {
                              return SkeletonBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.width);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: Sizes.dimen_1.h,
                              );
                            },
                            itemCount: 3));
              }),
            )));
  }
}
