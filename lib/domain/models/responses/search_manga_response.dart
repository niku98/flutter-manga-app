import 'package:manga_app/domain/models/manga.dart';

class SearchMangaResponse {
  bool status;
  String message;
  List<MangaFromSearch> mangaList;

  SearchMangaResponse({this.status, this.message, this.mangaList});

  SearchMangaResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['manga_list'] != null) {
      mangaList = new List<MangaFromSearch>();
      json['manga_list'].forEach((v) {
        mangaList.add(new MangaFromSearch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.mangaList != null) {
      data['manga_list'] = this.mangaList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
