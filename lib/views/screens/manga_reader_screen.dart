import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
import 'package:manga_app/blocs/chapter_detail/chapter_detail_bloc.dart';
import 'package:manga_app/common/constants/size_constants.dart';
import 'package:manga_app/common/extensions/size_extension.dart';
import 'package:manga_app/domain/models/chapter.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/views/themes/app_color.dart';
import 'package:manga_app/views/widgets/cache_image_with_skeleton.dart';
import 'package:manga_app/views/widgets/skeleton_box.dart';

const toolbarDuration = Duration(milliseconds: 250);

class MangaReaderScreen extends StatefulWidget {
  final int chapterIndex;
  final MangaDetail manga;

  MangaReaderScreen({@required this.manga, @required this.chapterIndex});

  @override
  _MangaReaderScreenState createState() => _MangaReaderScreenState();
}

class _MangaReaderScreenState extends State<MangaReaderScreen>
    with SingleTickerProviderStateMixin {
  ChapterDetailBloc _chapterDetailBloc;
  int currentChapterIndex;
  Completer refreshCompleter;

  double topBarPosition = 0;
  double bottomBarPosition = 0;
  double toolBarOpacity = 1;
  bool showToolBar = false;
  final double toolbarHeight = Sizes.dimen_24.h;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterStatusbarManager.setHidden(true);

    refreshCompleter = Completer();
    _chapterDetailBloc = new ChapterDetailBloc();
    _chapterDetailBloc.listen((state) {
      if (state is GotChapterDetail) {
        refreshCompleter.complete();
        refreshCompleter = Completer();
      }
    });

    currentChapterIndex = widget.chapterIndex;
    loadChapter(widget.manga.chapter[currentChapterIndex].chapterEndpoint);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    FlutterStatusbarManager.setHidden(false);
    _chapterDetailBloc.close();
    super.dispose();
  }

  loadChapter(String endpoint) {
    _chapterDetailBloc.add(new GetChapterDetail(endpoint));
  }

  toggleToolBar() {
    setState(() {
      if (showToolBar) {
        showToolBar = false;
        print('oke');
        // _controller.forward();
        topBarPosition = -toolbarHeight;
        bottomBarPosition = -toolbarHeight;
        toolBarOpacity = 0;
      } else {
        showToolBar = true;
        topBarPosition = 0;
        bottomBarPosition = 0;
        // _controller.reverse();
        // topBarHeight = Sizes.dimen_24.h;
        toolBarOpacity = 1;
      }
    });
  }

  nextChapter() {
    setState(() {
      if (currentChapterIndex == 0) return;
      currentChapterIndex--;
      loadChapter(widget.manga.chapter[currentChapterIndex].chapterEndpoint);
    });
  }

  previousChapter() {
    setState(() {
      if (currentChapterIndex == widget.manga.chapter.length - 1) return;
      currentChapterIndex++;
      loadChapter(widget.manga.chapter[currentChapterIndex].chapterEndpoint);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: BlocProvider<ChapterDetailBloc>.value(
            value: _chapterDetailBloc,
            child: Scaffold(
              body: BlocBuilder<ChapterDetailBloc, ChapterDetailState>(
                  builder: (context, state) {
                return RefreshIndicator(
                    child: Stack(children: [
                      GestureDetector(
                        onTap: () {
                          toggleToolBar();
                        },
                        child: state is GotChapterDetail
                            ? ListView.separated(
                                itemBuilder: (context, index) {
                                  return InteractiveViewer(
                                    child: CacheImageWithSkeleton(state.chapter
                                        .chapterImage[index].chapterImageLink),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: Sizes.dimen_1.h,
                                  );
                                },
                                itemCount: state.chapter.chapterPages ?? 0)
                            : ListView.separated(
                                itemBuilder: (context, index) {
                                  return SkeletonBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.width);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: Sizes.dimen_1.h,
                                  );
                                },
                                itemCount: 3),
                      ),
                      AnimatedPositioned(
                        duration: toolbarDuration,
                        left: 0,
                        right: 0,
                        top: topBarPosition,
                        child: AnimatedOpacity(
                          duration: toolbarDuration,
                          opacity: toolBarOpacity,
                          child: Container(
                            height: toolbarHeight,
                            width: double.infinity,
                            color: Colors.white,
                            // duration: Duration(milliseconds: 300),
                            child: Row(
                              children: [
                                BackButton(color: AppColors.dark),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                70,
                                        child: Text(
                                          widget.manga.title,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                      ),
                                      DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          isDense: true,
                                          value: widget.manga
                                              .chapter[currentChapterIndex],
                                          selectedItemBuilder: (context) {
                                            return widget.manga.chapter
                                                .asMap()
                                                .entries
                                                .map((entry) => Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width -
                                                            90,
                                                    child: Text(
                                                      entry.value.chapterTitle,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )))
                                                .toList();
                                          },
                                          onChanged:
                                              (ChapterShorted newChapter) {
                                            setState(() {
                                              int newIndex = widget
                                                  .manga.chapter
                                                  .indexOf(newChapter);
                                              if (currentChapterIndex ==
                                                  newIndex) return;

                                              currentChapterIndex = newIndex;
                                              loadChapter(
                                                  newChapter.chapterEndpoint);
                                            });
                                          },
                                          items: widget.manga.chapter
                                              .asMap()
                                              .entries
                                              .map((entry) => DropdownMenuItem<
                                                      ChapterShorted>(
                                                  value: entry.value,
                                                  child: Text(
                                                    entry.value.chapterTitle,
                                                  )))
                                              .toList(),
                                        ),
                                      )
                                    ])
                              ],
                            ),
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: toolbarDuration,
                        left: 0,
                        right: 0,
                        bottom: bottomBarPosition,
                        child: AnimatedOpacity(
                          duration: toolbarDuration,
                          opacity: toolBarOpacity,
                          child: GestureDetector(
                            onHorizontalDragEnd: (detail) {
                              if (!showToolBar) return;
                              if (detail.primaryVelocity < 0) {
                                nextChapter();
                              } else {
                                previousChapter();
                              }
                            },
                            child: Container(
                              height: toolbarHeight,
                              width: double.infinity,
                              color: Colors.white,
                              // duration: Duration(milliseconds: 300),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.arrow_back_ios,
                                          color: Colors.black),
                                      onPressed: previousChapter),
                                  IconButton(
                                      icon: Icon(Icons.arrow_forward_ios,
                                          color: Colors.black),
                                      onPressed: nextChapter),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                    onRefresh: () {
                      loadChapter(widget
                          .manga.chapter[currentChapterIndex].chapterEndpoint);

                      return refreshCompleter.future;
                    });
              }),
            )));
  }
}
