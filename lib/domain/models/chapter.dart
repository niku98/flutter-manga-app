class ChapterShorted {
  String chapterTitle;
  String chapterEndpoint;

  ChapterShorted({this.chapterTitle, this.chapterEndpoint});

  ChapterShorted.fromJson(Map<String, dynamic> json) {
    chapterTitle = json['chapter_title'];
    chapterEndpoint = json['chapter_endpoint'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_title'] = this.chapterTitle;
    data['chapter_endpoint'] = this.chapterEndpoint;
    return data;
  }
}
