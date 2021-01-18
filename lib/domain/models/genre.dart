class Genre {
  String genreName;
  String endpoint;

  Genre({this.genreName, this.endpoint});

  Genre.fromJson(Map<String, dynamic> json) {
    genreName = json['genre_name'];
    endpoint = json['endpoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_name'] = this.genreName;
    data['endpoint'] = this.endpoint;
    return data;
  }
}

class GenreShorted {
  String genreName;

  GenreShorted({this.genreName});

  GenreShorted.fromJson(Map<String, dynamic> json) {
    genreName = json['genre_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['genre_name'] = this.genreName;
    return data;
  }
}
