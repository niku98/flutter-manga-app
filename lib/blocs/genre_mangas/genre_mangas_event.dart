part of 'genre_mangas_bloc.dart';

abstract class GenreMangasEvent extends Equatable {
  const GenreMangasEvent();

  @override
  List<Object> get props => [];
}

class GetGenreMangas extends GenreMangasEvent {
  final String endpoint;
  final int pageNumber;

  const GetGenreMangas(this.endpoint, {this.pageNumber});

  @override
  List<Object> get props => [endpoint, pageNumber];
}
