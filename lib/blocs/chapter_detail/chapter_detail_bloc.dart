import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/domain/models/chapter.dart';
import 'package:manga_app/domain/repositories/manga_repository.dart';

part 'chapter_detail_event.dart';
part 'chapter_detail_state.dart';

class ChapterDetailBloc extends Bloc<ChapterDetailEvent, ChapterDetailState> {
  ChapterDetailBloc() : super(ChapterDetailInitial());

  @override
  Stream<ChapterDetailState> mapEventToState(
    ChapterDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetChapterDetail) {
      yield LoadingChapterDetail();

      final manga = await MangaRepository().getChapter(event.endpoint);
      yield GotChapterDetail(manga);
    }
  }
}
