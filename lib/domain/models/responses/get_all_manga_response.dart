import 'package:manga_app/domain/models/manga.dart';

class GetAllMangaResponse {
  bool status;
  String message;
  List<Manga> mangaList;

  GetAllMangaResponse({this.status, this.message, this.mangaList});

  GetAllMangaResponse.fromJson(Map<String, dynamic> json) {
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
