import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ks_mail/core/error/failures.dart';
import 'package:ks_mail/src/data/datasources/local/user_local_datasource.dart';
import 'package:ks_mail/src/data/repositories/user_repository_impl.dart';
import 'package:ks_mail/src/domain/entities/user.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/domain/repositories/user_repository.dart';

import '../../utils/constants/variables.dart';
import '../../utils/date_time.dart';

final userLocalDataSourceProvider = Provider<UserLocalDataSource>((ref) {
  return UserLocalDataSource();
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final userLocalDataSource = ref.read(userLocalDataSourceProvider);
  return UserRepositoryImpl(userLocalDataSource);
});

final userListNotifierProvider =
    StateNotifierProvider<UserListNotifier, List<User>>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return UserListNotifier(userRepository);
});

class UserListNotifier extends StateNotifier<List<User>> {
  UserRepository userRepository;
  UserListNotifier(this.userRepository) : super([]);

  Future<bool> validateUser(
      {required String mail, required String password}) async {
    Either<Failure, bool> isValid =
        await userRepository.validateUser(mail, password);
    print("from provider: $isValid");
    return isValid.fold((error) => false, (value) => value);
    // return false;
  }

  Future<List<User>> getAllUsers() async {
    final usersOrFailure = await userRepository.getAllUsers();
    print("after await in provider :$usersOrFailure");
    return usersOrFailure.fold((error) => state = [], (users) => state = users);
  }

  UserDetails getUserById(int id) {
    return mapToUserDetails(state.where((user) => user.id == id).toList()[0]);
  }

  UserDetails getUserByMail(String mail) {
    User user = state.firstWhere((user) => user.mail == mail,
        orElse: () => User(
            id: 0,
            username: "",
            mail: '',
            phoneNo: '',
            password: '',
            createdAt: ""));
    return mapToUserDetails(user);
  }

  List<String> getAllUsersMails() {
    List<String> allMailId = [];
    for (var user in mapToUserDetailsList(state)) {
      allMailId.add(user.mail);
    }
    return allMailId;
  }

  // Future<void> getUserPassordById(int id) async {
  //   await _getUserPasswordById(id);
  // }
  String getUserPasswordById(int id) {
    return state.where((user) => user.id == id).toList()[0].password;
  }

  Future<void> addUser(
      {required String username,
      required String mail,
      required String phoneNo,
      required String password}) async {
    User newUser = User(
        username: username,
        mail: mail,
        phoneNo: phoneNo,
        password: password,
        createdAt: DateTimeFormat().getDateTime());
    await userRepository.addUser(newUser);
  }

  Future<void> updateUser(
      {String? username,
      String? mail,
      String? phoneNo,
      String? password}) async {
    print('$username,$phoneNo');
    User updateUser = User(
        id: currentUser!.id,
        username: username ?? currentUser!.username,
        mail: currentUser!.mail,
        phoneNo: phoneNo ?? currentUser!.phoneNo,
        password: password ?? currentUser!.password,
        createdAt: currentUser!.createdAt);
    print('Provder: $updateUser');
    await userRepository.updateUser(updateUser);
  }
}
