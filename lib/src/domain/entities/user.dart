class User {
  int? id;
  String username;
  String mail;
  String phoneNo;
  String password;
  final String createdAt;
  String? image;

  User(
      {this.id,
      required this.username,
      required this.mail,
      required this.phoneNo,
      required this.password,
      required this.createdAt});
  User updateUser(
      {int? idValue,
      String? usernameContent,
      String? phoneNoContent,
      String? passwordContent}) {
    return User(
        id: idValue ?? id,
        username: usernameContent ?? username,
        mail: mail,
        phoneNo: phoneNoContent ?? phoneNo,
        password: passwordContent ?? password,
        createdAt: createdAt);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'mail': mail,
      'phoneNo': phoneNo,
      'password': password,
      'createdAt': createdAt
    };
  }
}

User userFromMap(Map<String, dynamic> user) {
  return User(
    id: user["id"],
    username: user["username"],
    mail: user["mail"],
    phoneNo: user["phoneNo"].toString(),
    password: user["password"],
    createdAt: user["createdAt"],
  );
}
