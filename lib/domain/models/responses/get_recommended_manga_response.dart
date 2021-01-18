import 'package:manga_app/domain/models/manga.dart';

class GetRecommendedMangaResponse {
  bool status;
  String message;
  List<Manga> mangaList;

  GetRecommendedMangaResponse({this.status, this.message, this.mangaList});

  GetRecommendedMangaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['manga_list'] != null) {
      mangaList = new List<Manga>();
      json['manga_list'].forEach((v) {
        mangaList.add(new Manga.fromJson(v));
      });
    }
  }
}
