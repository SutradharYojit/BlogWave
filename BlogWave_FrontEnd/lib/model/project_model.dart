class ProjectModel {
  String? id;
  String? title;
  String? description;
  List<String>? technologies;
  String? projectUrl;
  String? createdAt;
  String? updatedAt;
  String? userId;

  ProjectModel(
      {this.id,
      this.title,
      this.description,
      this.technologies,
      this.projectUrl,
      this.createdAt,
      this.updatedAt,
      this.userId});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    technologies = json['technologies'].cast<String>();
    projectUrl = json['projectUrl'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['technologies'] = this.technologies;
    data['projectUrl'] = this.projectUrl;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}

class ProjectDetailsModel {
  ProjectDetailsModel({
    required this.currentUserId,
    required this.projectData,
  });

  final String currentUserId;
  final ProjectModel projectData;
}

class EditProject {
  EditProject({
    required this.projectDetailsScreen,
    this.projectData,
  });

  final bool projectDetailsScreen;
  final ProjectModel? projectData;
}
