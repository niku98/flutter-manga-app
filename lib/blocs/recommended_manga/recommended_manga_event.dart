part of 'recommended_manga_bloc.dart';

abstract class RecommendedMangaEvent extends Equatable {
  const RecommendedMangaEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendedManga extends RecommendedMangaEvent {}
