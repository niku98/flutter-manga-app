part of 'search_manga_bloc.dart';

abstract class SearchMangaState extends Equatable {
  const SearchMangaState();

  @override
  List<Object> get props => [];
}

class SearchMangaInitial extends SearchMangaState {}

class SearchingManga extends SearchMangaState {}

class SearchMangaLoaded extends SearchMangaState {
  final List<MangaFromSearch> mangas;

  const SearchMangaLoaded(this.mangas);

  @override
  List<Object> get props => [mangas];
}
