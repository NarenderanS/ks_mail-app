import 'user.dart';

class UserDetails {
  final int id;
  final String username;
  final String mail;
  final String phoneNo;
  final String createdAt;
  UserDetails(
      {required this.id,
      required this.username,
      required this.mail,
      required this.phoneNo,
      required this.createdAt});
  @override
  String toString() {
    return "UserDetails: {id:$id,mail:$mail,phoneNo:$phoneNo,createdAt:$createdAt}\n";
  }
}

UserDetails mapToUserDetails(User user) {
  return UserDetails(
      id: user.id!,
      username: user.username,
      mail: user.mail,
      phoneNo: user.phoneNo,
      createdAt: user.createdAt);
}

List<UserDetails> mapToUserDetailsList(List<User> usersList) {
  List<UserDetails> users = [];
  for (User user in usersList) {
    users.add(mapToUserDetails(user));
  }
  return users;
}
