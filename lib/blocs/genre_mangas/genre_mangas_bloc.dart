import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/repositories/genre_repository.dart';

part 'genre_mangas_event.dart';
part 'genre_mangas_state.dart';

class GenreMangasBloc extends Bloc<GenreMangasEvent, GenreMangasState> {
  GenreMangasBloc() : super(GenreMangasInitial());

  @override
  Stream<GenreMangasState> mapEventToState(
    GenreMangasEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetGenreMangas) {
      yield LoadingGenreMangas();

      final mangas = await GenreRepository()
          .getListManga(event.endpoint, pageNumber: event.pageNumber);
      print(mangas);
      yield GotGenreMangas(mangas);
    }
  }
}
