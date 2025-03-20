import 'package:surveyist/userModel/articles_model.dart';

class News {
  String? status;
  String? totalResults;
  List<Articles>? articles;
  News({this.status, this.totalResults, this.articles});

  factory News.fromjson(Map<String, dynamic> doc) {
    return News(
        status: doc["status"] ?? " ",
        totalResults: doc["totalResults"] ?? " ",
        articles: doc['articles'] != null
            ? (doc["articles"] as List<dynamic>)
                .map((loc) => Articles.fromJson(loc as Map<String, dynamic>))
                .toList()
            : []);
  }
}
