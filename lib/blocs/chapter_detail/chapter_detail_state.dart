part of 'chapter_detail_bloc.dart';

abstract class ChapterDetailState extends Equatable {
  const ChapterDetailState();

  @override
  List<Object> get props => [];
}

class ChapterDetailInitial extends ChapterDetailState {}

class LoadingChapterDetail extends ChapterDetailState {}

class GotChapterDetail extends ChapterDetailState {
  final ChapterDetail chapter;

  const GotChapterDetail(this.chapter);

  @override
  List<Object> get props => [chapter];
}
