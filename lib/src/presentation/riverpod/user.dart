import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/utils/constants/users.dart';
import 'package:ks_mail/src/utils/date_time.dart';

import '../../domain/entities/user.dart';

class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier(super.state);
  UserDetails getUser(int id) {
    return mapToUserDetails(state.where((user) => user.id == id).toList()[0]);
  }

  String getUserPassword(int id) {
    return state.where((user) => user.id == id).toList()[0].password;
  }

  UserDetails getUserByMail(String mail) {
    User user = state.firstWhere((user) => user.mail == mail,
        orElse: () => User(
            id: 0,
            username: "",
            mail: '',
            phoneNo: '',
            password: '',
            knownMails: [],
            createdAt: ""));
    // var userFormatToSend=User(username: user.username, mail: user.mail, phoneNo: user.phoneNo, password: '', knownMails: [],);
    return mapToUserDetails(user);
  }

  void addUser(
      {required String username,
      required String mail,
      required String phoneNo,
      required String password}) {
    // int lastId = state.length;
    User newUser = User(
        id: state.length + 1,
        username: username,
        mail: mail,
        phoneNo: phoneNo,
        password: password,
        knownMails: [],
        createdAt: DateTimeFormat().getDateTime().toString());
    print(
        "id:${newUser.id},name: ${newUser.username},mail: ${newUser.mail},phoneNo:${newUser.phoneNo},createdAt:${newUser.createdAt}");
    state = [...state, newUser];
  }

  updateUser(
      {required int id,
      String? username,
      String? mail,
      String? phoneNo,
      String? password}) {
    List<User> updatedUserList = List.from(state);

    updatedUserList[id - 1] = User(
        id: id,
        username: username ?? currentUser!.username,
        mail: currentUser!.mail,
        phoneNo: phoneNo ?? currentUser!.phoneNo,
        password: password ?? getUserPassword(id),
        knownMails: currentUser!.knownMails,
        createdAt: currentUser!.createdAt);
    state = updatedUserList;
  }

  bool validateUser(String mail, String password) {
    if (state.any((user) => user.mail == mail && user.password == password)) {
      // Set currentUser
      currentUser =
          mapToUserDetails(state.firstWhere((user) => user.mail == mail));

      return true;
    }
    return false;
  }
}

// late UserDetails? currentUser;
UserDetails currentUser = mapToUserDetails(users[0]);

final userProvider = StateNotifierProvider((ref) => UserNotifier(users));
