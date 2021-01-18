import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:manga_app/domain/models/genre.dart';
import 'package:manga_app/domain/repositories/genre_repository.dart';

part 'genre_list_event.dart';
part 'genre_list_state.dart';

class GenreListBloc extends Bloc<GenreListEvent, GenreListState> {
  GenreListBloc() : super(GenreListInitial());

  @override
  Stream<GenreListState> mapEventToState(
    GenreListEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is GetGenreList) {
      final genres = await GenreRepository().getAll();
      print(genres);
      yield GotGenreList(genres);
    }
  }
}
