import 'blogger_portfolio.dart';
import 'user_data_model.dart';

class CommentModel {
  String? id;
  String? comment;
  String? blogId;
  String? createdAt;
  String? userId;
  BloggerPortfolio? user;

  CommentModel({this.id, this.comment, this.blogId, this.createdAt, this.userId, this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['description'];
    blogId = json['blogId'];
    createdAt = json['createdAt'];
    userId = json['userId'];
    user = json['user'] != null ? new BloggerPortfolio.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.comment;
    data['blogId'] = this.blogId;
    data['createdAt'] = this.createdAt;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
