class User {
  final int id;
  final String username;
  final String mail;
  final String phoneNo;
  final String password;
  List<String> knownMails;
  final String createdAt;
  String? image;

  User(
      {required this.id,
      required this.username,
      required this.mail,
      required this.phoneNo,
      required this.password,
      required this.knownMails,
      required this.createdAt});
  User updateUser(
      {String? usernameContent,
      String? phoneNoContent,
      String? passwordContent}) {
    return User(
        id: id,
        username: usernameContent ?? username,
        mail: mail,
        phoneNo: phoneNoContent ?? phoneNo,
        password: passwordContent ?? password,
        knownMails: knownMails,
        createdAt: createdAt);
  }

  @override
  String toString() {
    return "User: {id:$id,mail:$mail,phoneNo:$phoneNo,password:$password,knowmails:$knownMails}";
  }
}
