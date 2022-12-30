class UserModel {
  final String username;
  final String emailid;
  final String password;
  final String role;

  UserModel({
    required this.username,
    required this.emailid,
    required this.password,
    this.role = "user",
  });
}
