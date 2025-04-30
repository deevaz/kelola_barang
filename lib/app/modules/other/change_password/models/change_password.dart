class ChangePassword {
  final String currentPassword;
  final String newPassword;
  final String newPasswordConfirmation;

  ChangePassword({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  factory ChangePassword.fromJson(Map<String, dynamic> json) {
    return ChangePassword(
      currentPassword: json['current_password'],
      newPassword: json['new_password'],
      newPasswordConfirmation: json['new_password_confirmation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    };
  }
}
