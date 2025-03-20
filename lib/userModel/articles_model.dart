
import 'package:surveyist/userModel/source_model.dart';

class Articles {
   Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  Articles(
      {this.author,
      this.title,
      this.description,
      this.url,
      this.urlToImage,
      this.publishedAt,
      this.content,
      this.source});

  factory Articles.fromJson(Map<String, dynamic> doc) {
    return Articles(
      author: doc["author"] ?? " ",
      title: doc["title"] ?? " ",
      description: doc["description"] ?? " ",
      url: doc["url"] ?? " ",
      urlToImage: doc["utlToImage"] ?? " ",
      publishedAt: doc["publishedAt"] ?? " ",
      content: doc["content"],
       source: doc['source'] != null ? Source.fromjson(doc['source']) : null,
      
    );
  }
}
