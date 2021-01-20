import 'package:manga_app/domain/base/api_client.dart';
import 'package:manga_app/domain/models/chapter.dart';
import 'package:manga_app/domain/models/manga.dart';
import 'package:manga_app/domain/models/responses/get_all_manga_response.dart';
import 'package:manga_app/domain/models/responses/get_recommended_manga_response.dart';

class MangaRepository {
  static MangaRepository _instance;
  MangaRepository._();

  factory MangaRepository() {
    if (_instance == null) {
      _instance = MangaRepository._();
    }

    return _instance;
  }

  Future<List<Manga>> getAll({int page = 1}) async {
    final response = await ApiClient().get('manga/page/' + page.toString());
    return GetAllMangaResponse.fromJson(response).mangaList;
  }

  Future<List<Manga>> getRecommened() async {
    final response = await ApiClient().get('recommended');
    return GetRecommendedMangaResponse.fromJson(response).mangaList;
  }

  Future<List<Manga>> getManhua() async {
    final response = await ApiClient().get('manhua/1');
    return GetRecommendedMangaResponse.fromJson(response).mangaList;
  }

  Future<List<Manga>> getManhwa() async {
    final response = await ApiClient().get('manhwa/1');
    return GetRecommendedMangaResponse.fromJson(response).mangaList;
  }

  Future<MangaDetail> getDetail(String endpoint) async {
    final response = await ApiClient().get('manga/detail/' + endpoint);

    return MangaDetail.fromJson(response);
  }

  Future<ChapterDetail> getChapter(String endpoint) async {
    final response = await ApiClient().get('chapter/' + endpoint);

    return ChapterDetail.fromJson(response);
  }
}
