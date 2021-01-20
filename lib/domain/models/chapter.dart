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

class ChapterDetail {
  String chapterEndpoint;
  int chapterPages;
  List<ChapterImage> chapterImage;

  ChapterDetail({this.chapterEndpoint, this.chapterPages, this.chapterImage});

  ChapterDetail.fromJson(Map<String, dynamic> json) {
    chapterEndpoint = json['chapter_endpoint'];
    chapterPages = json['chapter_pages'];
    if (json['chapter_image'] != null) {
      chapterImage = new List<ChapterImage>();
      json['chapter_image'].forEach((v) {
        chapterImage.add(new ChapterImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_endpoint'] = this.chapterEndpoint;
    data['chapter_pages'] = this.chapterPages;
    if (this.chapterImage != null) {
      data['chapter_image'] = this.chapterImage.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChapterImage {
  String chapterImageLink;
  int imageNumber;

  ChapterImage({this.chapterImageLink, this.imageNumber});

  ChapterImage.fromJson(Map<String, dynamic> json) {
    chapterImageLink = json['chapter_image_link'];
    imageNumber = json['image_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapter_image_link'] = this.chapterImageLink;
    data['image_number'] = this.imageNumber;
    return data;
  }
}
