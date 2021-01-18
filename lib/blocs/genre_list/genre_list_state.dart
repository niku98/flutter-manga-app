part of 'genre_list_bloc.dart';

abstract class GenreListState extends Equatable {
  const GenreListState();

  @override
  List<Object> get props => [];
}

class GenreListInitial extends GenreListState {}

class GotGenreList extends GenreListState {
  final List<Genre> genres;

  const GotGenreList(this.genres);

  @override
  List<Object> get props => [genres];
}
