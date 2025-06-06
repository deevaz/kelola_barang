class ResetPasswordModel {
  String email;
  String password;
  String confirmPassword;
  String token;

  ResetPasswordModel({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.token,
  });

  ResetPasswordModel.fromJson(Map<String, dynamic> json)
    : email = json['email'],
      password = json['password'],
      confirmPassword = json['password_confirmation'],
      token = json['token'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = confirmPassword;
    data['token'] = token;
    return data;
  }
}
