class UserDataModel {
  bool? success;
  UserData? userData;

  UserDataModel({this.success, this.userData});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? userName;
  String? email;
  String? profileUrl;
  String? bio;

  UserData(
      {this.id,
        this.userName,
        this.email,
        this.profileUrl,
        this.bio,
        });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    profileUrl = json['profileUrl']??"ok";
    bio = json['bio']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['email'] = this.email;
    data['profileUrl'] = this.profileUrl;
    data['bio'] = this.bio;
    return data;
  }
}
