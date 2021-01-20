part of 'manhwa_manga_bloc.dart';

abstract class ManhwaMangaEvent extends Equatable {
  const ManhwaMangaEvent();

  @override
  List<Object> get props => [];
}

class GetManhwaManga extends ManhwaMangaEvent {}
