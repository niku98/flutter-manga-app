import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/repositories/manga_repository.dart';

part 'manga_detail_event.dart';
part 'manga_detail_state.dart';

class MangaDetailBloc extends Bloc<MangaDetailEvent, MangaDetailState> {
  MangaDetailBloc() : super(MangaDetailInitial());

  @override
  Stream<MangaDetailState> mapEventToState(
    MangaDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetMangaDetail) {
      yield LoadingMangaDetail();

      final manga = await MangaRepository().getDetail(event.endpoint);
      yield GotMangaDetail(manga);
    }
  }
}
