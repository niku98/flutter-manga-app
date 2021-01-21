part of 'search_manga_bloc.dart';

abstract class SearchMangaEvent extends Equatable {
  const SearchMangaEvent();

  @override
  List<Object> get props => [];
}

class SearchManga extends SearchMangaEvent {
  final String query;
  const SearchManga(this.query);

  @override
  List<Object> get props => [query];
}
