// Data class to get the blogger portfolio details
class BloggerPortfolio {
  String? id;
  String? userName;
  String? email;
  String? profileUrl;
  String? bio;


  BloggerPortfolio(
      {this.id,
        this.userName,
        this.email,
        this.profileUrl,
        this.bio,
     });

  BloggerPortfolio.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    profileUrl = json['profileUrl']??"";
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
