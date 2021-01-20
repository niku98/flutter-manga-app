part of 'manga_detail_bloc.dart';

abstract class MangaDetailState extends Equatable {
  const MangaDetailState();

  @override
  List<Object> get props => [];
}

class MangaDetailInitial extends MangaDetailState {}

class LoadingMangaDetail extends MangaDetailState {}

class GotMangaDetail extends MangaDetailState {
  final MangaDetail manga;

  const GotMangaDetail(this.manga);

  @override
  List<Object> get props => [manga];
}
