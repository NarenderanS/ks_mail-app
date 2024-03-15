// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ks_mail/src/domain/entities/user_details.dart';
// import 'package:ks_mail/src/utils/constants/un_used/users.dart';

// import '../../domain/entities/user.dart';
// import '../../utils/constants/styles.dart';
// import '../../utils/constants/variables.dart';

// class UserNotifier extends StateNotifier<List<User>> {
//   UserNotifier(super.state);
//   UserDetails getUserById(int id) {
//     return mapToUserDetails(state.where((user) => user.id == id).toList()[0]);
//   }

//   String getUserPasswordById(int id) {
//     return state.where((user) => user.id == id).toList()[0].password;
//   }

//   List<String> getAllUsersMails() {
//     List<String> allMailId = [];
//     for (var user in mapToUserDetailsList(state)) {
//       allMailId.add(user.mail);
//     }
//     return allMailId;
//   }

//   UserDetails getUserByMail(String mail) {
//     User user = state.firstWhere((user) => user.mail == mail,
//         orElse: () => User(
//             id: 0,
//             username: "",
//             mail: '',
//             phoneNo: '',
//             password: '',
//             createdAt: ""));
//     return mapToUserDetails(user);
//   }

//   void addUser(
//       {required String username,
//       required String mail,
//       required String phoneNo,
//       required String password}) {
//     // int lastId = state.length;
//     User newUser = User(
//         id: state.length + 1,
//         username: username,
//         mail: mail,
//         phoneNo: phoneNo,
//         password: password,
//         createdAt: DateTimeFormat().getDateTime().toString());
//     print(
//         "id:${newUser.id},name: ${newUser.username},mail: ${newUser.mail},phoneNo:${newUser.phoneNo},createdAt:${newUser.createdAt}");
//     state = [...state, newUser];
//   }

//   void updateUser(
//       {required int id,
//       String? username,
//       String? mail,
//       String? phoneNo,
//       String? password}) {
//     List<User> updatedUserList = List.from(state);

//     updatedUserList[id - 1] = User(
//         id: id,
//         username: username ?? currentUser!.username,
//         mail: currentUser!.mail,
//         phoneNo: phoneNo ?? currentUser!.phoneNo,
//         password: password ?? getUserPasswordById(id),
//         createdAt: currentUser!.createdAt);
//     state = updatedUserList;
//   }

//   bool validateUser(String mail, String password) {
//     if (state.any((user) => user.mail == mail && user.password == password)) {
//       // Set currentUser
//       currentUser =
//           mapToUserDetails(state.firstWhere((user) => user.mail == mail));
//       return true;
//     }
//     return false;
//   }
// }

// late UserDetails? currentUser;
// // UserDetails currentUser = mapToUserDetails(user[0]);

// final userProvider = StateNotifierProvider((ref) => UserNotifier(users!));
