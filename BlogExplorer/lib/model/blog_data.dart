class BlogData {
  List<Blogs>? blogs;

  BlogData({this.blogs});

  BlogData.fromJson(Map<String, dynamic> json) {
    if (json["blogs"] is List) {
      blogs = json["blogs"] == null
          ? null
          : (json["blogs"] as List).map((e) => Blogs.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (blogs != null) {
      _data["blogs"] = blogs?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Blogs {
  String? id;
  String? imageUrl;
  String? title;

  Blogs({this.id, this.imageUrl, this.title});

  Blogs.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["image_url"] is String) {
      imageUrl = json["image_url"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["image_url"] = imageUrl;
    _data["title"] = title;
    return _data;
  }
}
