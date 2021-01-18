import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:manga_app/blocs/language/language_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());
}
