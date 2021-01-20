import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/repositories/manga_repository.dart';

part 'recommended_manga_event.dart';
part 'recommended_manga_state.dart';

class RecommendedMangaBloc
    extends Bloc<RecommendedMangaEvent, RecommendedMangaState> {
  RecommendedMangaBloc() : super(RecommendedMangaInitial());

  @override
  Stream<RecommendedMangaState> mapEventToState(
    RecommendedMangaEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetRecommendedManga) {
      yield LoadingRecommendedManga();
      final mangas = await MangaRepository().getRecommened();
      print(mangas);
      yield GotRecommendedManga(mangas);
    }
  }
}
