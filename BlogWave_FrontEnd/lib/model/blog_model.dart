class BlogDataModel {
  String? id;
  String? title;
  String? description;
  String? categories;
  List<String>? tags;
  String? blogImgUrl;
  String? createdAt;
  String? updatedAt;
  String? userId;

  BlogDataModel(
      {this.id,
        this.title,
        this.description,
        this.categories,
        this.tags,
        this.blogImgUrl,
        this.createdAt,
        this.updatedAt,
        this.userId});

  BlogDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    categories = json['categories'];
    tags = json['tags'].cast<String>();
    blogImgUrl = json['blogImgUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['categories'] = this.categories;
    data['tags'] = this.tags;
    data['blogImgUrl'] = this.blogImgUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}

class BlogPreferences {
  final bool blogChoice;
  final BlogDataModel? blogData;

  BlogPreferences({
    required this.blogChoice,
      this.blogData,
  });
}
