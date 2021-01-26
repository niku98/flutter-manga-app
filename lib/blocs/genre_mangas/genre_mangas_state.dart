part of 'genre_mangas_bloc.dart';

abstract class GenreMangasState extends Equatable {
  const GenreMangasState();

  @override
  List<Object> get props => [];
}

class GenreMangasInitial extends GenreMangasState {}

class LoadingGenreMangas extends GenreMangasState {}

class GotGenreMangas extends GenreMangasState {
  final List<Manga> mangas;

  const GotGenreMangas(this.mangas);

  @override
  List<Object> get props => [mangas];
}
