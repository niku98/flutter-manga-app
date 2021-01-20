part of 'manhua_manga_bloc.dart';

abstract class ManhuaMangaState extends Equatable {
  const ManhuaMangaState();

  @override
  List<Object> get props => [];
}

class ManhuaMangaInitial extends ManhuaMangaState {}

class LoadingManhuaManga extends ManhuaMangaState {}

class GotManhuaManga extends ManhuaMangaState {
  final List<Manga> mangas;

  const GotManhuaManga(this.mangas);

  @override
  List<Object> get props => [mangas];
}
