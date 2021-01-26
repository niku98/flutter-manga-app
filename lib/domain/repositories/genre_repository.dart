import 'package:manga_app/domain/base/api_client.dart';
import 'package:manga_app/domain/models/genre.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/models/responses/get_all_manga_response.dart';
import 'package:manga_app/domain/models/responses/get_genre_list_response.dart';
import 'package:manga_app/domain/models/responses/get_recommended_manga_response.dart';

class GenreRepository {
  static GenreRepository _instance;
  GenreRepository._();

  factory GenreRepository() {
    if (_instance == null) {
      _instance = GenreRepository._();
    }

    return _instance;
  }

  Future<List<Genre>> getAll() async {
    final response = await ApiClient().get('genres');
    print(response);
    return GetGenreListResponse.fromJson(response).listGenre;
  }

  Future<List<Manga>> getListManga(String endpoint,
      {int pageNumber = 1}) async {
    final response = await ApiClient().get('genres/$endpoint/$pageNumber');
    print(response);
    return GetRecommendedMangaResponse.fromJson(response).mangaList;
  }
}
