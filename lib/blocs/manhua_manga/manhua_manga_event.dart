part of 'manhua_manga_bloc.dart';

abstract class ManhuaMangaEvent extends Equatable {
  const ManhuaMangaEvent();

  @override
  List<Object> get props => [];
}

class GetManhuaManga extends ManhuaMangaEvent {}
