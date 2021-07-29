class NewsModel {

  late String newsUrl;
  String? imageUrl;
  String? title;
  String? text;
  String? sourceName;
  late String date;
  int type = 0;


  NewsModel(this.newsUrl,this.imageUrl,this.title,this.text,
      this.sourceName, this.date,);

  NewsModel.fromJson(Map<String, dynamic> json) {

    newsUrl = json['news_url'];

    imageUrl = json['image_url'];
    title = json['title'];
    text = json['text'];
    sourceName = json["source_name"].toString();
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['newsUrl'] = this.newsUrl;
    data['imageUrl'] = this.imageUrl;
    data['title'] = this.title;
    data['text'] = this.text;
    data['sourceName'] = this.sourceName;
    data['date'] = this.date;
    return data;
  }
}
