import 'package:manga_app/domain/models/chapter.dart';
import 'package:manga_app/domain/models/genre.dart';

class Manga {
  String title;
  String thumb;
  String type;
  String updatedOn;
  String endpoint;
  String chapter;

  Manga(
      {this.title,
      this.thumb,
      this.type,
      this.updatedOn,
      this.endpoint,
      this.chapter});

  Manga.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    thumb = json['thumb'];
    type = json['type'];
    updatedOn = json['updated_on'];
    endpoint = json['endpoint'];
    chapter = json['chapter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['thumb'] = this.thumb;
    data['type'] = this.type;
    data['updated_on'] = this.updatedOn;
    data['endpoint'] = this.endpoint;
    data['chapter'] = this.chapter;
    return data;
  }
}

class MangaDetail {
  String title;
  String type;
  String author;
  String status;
  String mangaEndpoint;
  String thumb;
  List<GenreShorted> genreList;
  String synopsis;
  List<ChapterShorted> chapter;

  MangaDetail(
      {this.title,
      this.type,
      this.author,
      this.status,
      this.mangaEndpoint,
      this.thumb,
      this.genreList,
      this.synopsis,
      this.chapter});

  MangaDetail.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    author = json['author'];
    status = json['status'];
    mangaEndpoint = json['manga_endpoint'];
    thumb = json['thumb'];
    if (json['genre_list'] != null) {
      genreList = new List<GenreShorted>();
      json['genre_list'].forEach((v) {
        genreList.add(new GenreShorted.fromJson(v));
      });
    }
    synopsis = json['synopsis'];
    if (json['chapter'] != null) {
      chapter = new List<ChapterShorted>();
      json['chapter'].forEach((v) {
        chapter.add(new ChapterShorted.fromJson(v));
      });
    }
  }
}
