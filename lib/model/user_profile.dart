class UserProfile {
  int? id;
  String? username;
  String? email;
  String? name;

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    username = json['username'].toString();
    email = json['email'].toString();
    name = json['name'].toString();
  }
}
