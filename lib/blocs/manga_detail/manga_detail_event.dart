part of 'manga_detail_bloc.dart';

abstract class MangaDetailEvent extends Equatable {
  const MangaDetailEvent();

  @override
  List<Object> get props => [];
}

class GetMangaDetail extends MangaDetailEvent {
  final String endpoint;

  const GetMangaDetail(this.endpoint);

  @override
  List<Object> get props => [endpoint];
}
