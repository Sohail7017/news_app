class SourceModel{
  String? id;
  String? name;

  SourceModel({this.id,this.name});


  factory SourceModel.fromJson(Map<String,dynamic> json){
    return SourceModel(
      id: json['id'],
      name: json['name']
    );
  }
}

class ArticleModel{
  String? author;
  String? content;
  String? description;
  String? publishedAt;
  String? title;
  String? url;
  String?urlToImage;
  SourceModel? source;

  ArticleModel({this.author, this.content, this.description, this.publishedAt,
      this.title, this.url, this.urlToImage, this.source});

  factory ArticleModel.fromJson(Map<String,dynamic> json){
    

    return ArticleModel(
      author: json['author'],
        content: json['content'],
        description: json['description'],
        publishedAt: json['publishedAt'],
        source: SourceModel.fromJson(json['source']),
        title: json['title'],
        url: json['url'],
        urlToImage: json['urlToImage'],
    );
  }

}

class ArticleDataModel{
  List<ArticleModel>? articles;
  String? status;
  int? totalResults;
  ArticleDataModel({this.articles,this.status,this.totalResults});

  factory ArticleDataModel.fromJson(Map<String,dynamic> json){
    List<ArticleModel> mArticle = [];
    for(Map<String,dynamic> eachArticle in json['articles']){
      var articlesModel = ArticleModel.fromJson(eachArticle);
      mArticle.add(articlesModel);
    }

    return ArticleDataModel(
      articles: mArticle,
      status: json['status'],
      totalResults: json['totalResults']
    );
  }

}