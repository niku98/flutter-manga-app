part of 'recommended_manga_bloc.dart';

abstract class RecommendedMangaState extends Equatable {
  const RecommendedMangaState();

  @override
  List<Object> get props => [];
}

class RecommendedMangaInitial extends RecommendedMangaState {}

class LoadingRecommendedManga extends RecommendedMangaState {}

class GotRecommendedManga extends RecommendedMangaState {
  final List<Manga> mangas;

  const GotRecommendedManga(this.mangas);

  @override
  List<Object> get props => [mangas];
}
