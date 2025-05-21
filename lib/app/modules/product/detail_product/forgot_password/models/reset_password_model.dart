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
      confirmPassword = json['confirm_password'],
      token = json['token'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['confirm_password'] = confirmPassword;
    data['token'] = token;
    return data;
  }
}
