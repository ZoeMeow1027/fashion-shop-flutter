class RegisterDTO {
  String? name;
  String? email;
  String? password;

  RegisterDTO();

  RegisterDTO.from({
    required this.name,
    required this.email,
    required this.password,
  });

  bool isValidate() {
    if (name == null) return false;
    if (email == null) return false;
    if (password == null) return false;
    return true;
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
      };
}
