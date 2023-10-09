class BlogModel {
  late final String id;
  late final String image_url;
  late final String title;

  BlogModel({
    required this.id,
    required this.image_url,
    required this.title,
  });

  BlogModel.fromJson(Map<dynamic,dynamic> jsonData) {
    id = jsonData['id'];
    image_url = jsonData['image_url'];
    title = jsonData['title'];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'image_url': image_url,
      'title': title,
    };
  }

  Map<dynamic,dynamic> toJson() {
    final jsonData = <dynamic,dynamic>{};
    jsonData['id'] = id;
    jsonData['image_url'] = image_url;
    jsonData['title'] = title;

    return jsonData;
  }

}
