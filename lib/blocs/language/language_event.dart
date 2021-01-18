part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends LanguageEvent {
  final Language language;

  const ChangeLanguage(this.language);

  @override
  List<Object> get props => [language.code];
}
