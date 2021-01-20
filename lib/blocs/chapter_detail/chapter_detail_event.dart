part of 'chapter_detail_bloc.dart';

abstract class ChapterDetailEvent extends Equatable {
  const ChapterDetailEvent();

  @override
  List<Object> get props => [];
}

class GetChapterDetail extends ChapterDetailEvent {
  final String endpoint;

  const GetChapterDetail(this.endpoint);

  @override
  List<Object> get props => [endpoint];
}
