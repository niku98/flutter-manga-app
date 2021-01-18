import 'package:manga_app/domain/models/genre.dart';

class GetGenreListResponse {
  bool status;
  String message;
  List<Genre> listGenre;

  GetGenreListResponse({this.status, this.message, this.listGenre});

  GetGenreListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['list_genre'] != null) {
      listGenre = new List<Genre>();
      json['list_genre'].forEach((v) {
        listGenre.add(new Genre.fromJson(v));
      });
    }
  }
}
