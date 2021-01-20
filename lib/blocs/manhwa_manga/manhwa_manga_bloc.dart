import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/repositories/manga_repository.dart';

part 'manhwa_manga_event.dart';
part 'manhwa_manga_state.dart';

class ManhwaMangaBloc extends Bloc<ManhwaMangaEvent, ManhwaMangaState> {
  ManhwaMangaBloc() : super(ManhwaMangaInitial());

  @override
  Stream<ManhwaMangaState> mapEventToState(
    ManhwaMangaEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetManhwaManga) {
      yield LoadingManhwaManga();
      final mangas = await MangaRepository().getManhwa();
      print(mangas);
      yield GotManhwaManga(mangas);
    }
  }
}
