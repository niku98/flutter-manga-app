import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/repositories/manga_repository.dart';

part 'manhua_manga_event.dart';
part 'manhua_manga_state.dart';

class ManhuaMangaBloc extends Bloc<ManhuaMangaEvent, ManhuaMangaState> {
  ManhuaMangaBloc() : super(ManhuaMangaInitial());

  @override
  Stream<ManhuaMangaState> mapEventToState(
    ManhuaMangaEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetManhuaManga) {
      yield LoadingManhuaManga();

      final mangas = await MangaRepository().getManhua();
      print(mangas);
      yield GotManhuaManga(mangas);
    }
  }
}
