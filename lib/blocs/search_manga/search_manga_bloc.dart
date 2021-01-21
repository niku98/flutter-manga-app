import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/repositories/manga_repository.dart';

part 'search_manga_event.dart';
part 'search_manga_state.dart';

class SearchMangaBloc extends Bloc<SearchMangaEvent, SearchMangaState> {
  SearchMangaBloc() : super(SearchMangaInitial());

  @override
  Stream<SearchMangaState> mapEventToState(
    SearchMangaEvent event,
  ) async* {
    if (event is SearchManga) {
      yield SearchingManga();
      final mangas = await MangaRepository().search(event.query);
      yield SearchMangaLoaded(mangas);
    }
  }
}
