import 'package:ks_mail/src/data/datasources/local/database/db_helper.dart';
import 'package:ks_mail/src/utils/constants/variables.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_details.dart';

late List<User> allUsers;

class UserLocalDataSource {
  UserLocalDataSource();

  Future<List<User>> getAllUsers() async {
    print("user ds");
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> usersFrmDb =
        await database.query(Table.user);
    return usersFrmDb.map((user) => userFromMap(user)).toList();
  }

  Future<UserDetails> getUserById(int userId) async {
    final Database database = await getDatabase();
    List<Map<String, dynamic>> results =
        await database.query(Table.user, where: 'id = ?', whereArgs: [userId]);
    Map<String, dynamic> data = results.first;
    return mapToUserDetails(userFromMap(data));
  }

  Future<bool> validateUser(String mail, String password) async {
    print("valdation from ds");
    final Database database = await getDatabase();
    List<Map<String, dynamic>> user = await database.query(
      Table.user,
      where: 'mail = ? AND password = ?',
      whereArgs: [mail, password],
    );
    if (user.isNotEmpty) {
      currentUser = userFromMap(user.first);
      return true;
    }
    return false;
  }

  Future<User?> getUserByMail(String mail) async {
    final Database database = await getDatabase();
    final List<Map<String, dynamic>> users = await database.query(
      Table.user,
      where: 'mail = ?',
      whereArgs: [mail],
      limit: 1,
    );

    if (users.isNotEmpty) {
      return userFromMap(users.first);
    } else {
      return null;
    }
  }

  Future<String?> getUserPasswordById(int id) async {
    final Database database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      Table.user,
      columns: ['password'],
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return result.first['password'] as String?;
    }
    return null;
  }

  void addUser(User user) async {
    final Database database = await getDatabase();
    print("LocalDS- ${user.toMap()}");
    var id = await database.insert(Table.user, user.toMap());
    print("add user : $id");
  }

  void updateUser(User user) async {
    final Database database = await getDatabase();
    int a = await database.update(
      Table.user,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
    if (a == 1) {
      currentUser = user;
    }
  }
}
