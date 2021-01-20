part of 'manhwa_manga_bloc.dart';

abstract class ManhwaMangaState extends Equatable {
  const ManhwaMangaState();

  @override
  List<Object> get props => [];
}

class ManhwaMangaInitial extends ManhwaMangaState {}

class LoadingManhwaManga extends ManhwaMangaState {}

class GotManhwaManga extends ManhwaMangaState {
  final List<Manga> mangas;

  const GotManhwaManga(this.mangas);

  @override
  List<Object> get props => [mangas];
}
