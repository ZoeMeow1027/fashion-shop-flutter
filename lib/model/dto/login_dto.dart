class LoginDTO {
  String? username;
  String? password;

  LoginDTO();

  LoginDTO.from({
    required this.username,
    required this.password,
  });

  bool isValidate() {
    if (username == null) return false;
    if (password == null) return false;
    return true;
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
