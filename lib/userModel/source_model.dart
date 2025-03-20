class Source {
  String? id;
  String? name;

  Source({this.id, this.name});
  factory Source.fromjson(Map<String, dynamic> doc) {
    return Source(
      id: doc["id"] ?? " ",
      name: doc["name"] ?? " ",
    );
  }
}
