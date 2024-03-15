import 'package:dartz/dartz.dart';
import 'package:ks_mail/core/error/failures.dart';
import 'package:ks_mail/src/data/datasources/local/user_local_datasource.dart';
import 'package:ks_mail/src/domain/entities/user.dart';
import 'package:ks_mail/src/domain/entities/user_details.dart';
import 'package:ks_mail/src/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource userLocalDataSource;
  UserRepositoryImpl(this.userLocalDataSource);

  @override
  Future<void> addUser(User user) async {
    userLocalDataSource.addUser(user);
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      final List<User> getUsers = await userLocalDataSource.getAllUsers();
      // List<User> res = getUsers.map((user) => user).toList();
      print("impl: $getUsers");
      return Right(getUsers);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<Either<Failure, UserDetails>> getUserById(int id) async {
    try {
      final user = await userLocalDataSource.getUserById(id);
      print("from user Impl: $user");
      return Right(user);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<UserDetails> getUserByMail(String mail) async {
    final User? getUser = await userLocalDataSource.getUserByMail(mail);
    // List<User> res = getUsers.map((user) => user).toList();
    print("impl: $getUser");
    return getUser != null
        ? mapToUserDetails(getUser)
        : UserDetails(
            username: '', mail: '', phoneNo: '', createdAt: '', id: 0);
  }

  @override
  Future<Either<Failure, String>> getUserPasswordById(int id) async {
    try {
      final password = await userLocalDataSource.getUserPasswordById(id);
      // print("from user Impl: $password");
      return Right(password ?? "");
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  Future<void> updateUser(User user) async {
    userLocalDataSource.updateUser(user);
  }

  @override
  Future<Either<Failure, bool>> validateUser(
      String mail, String password) async {
    try {
      final isValid = await userLocalDataSource.validateUser(mail, password);
      print("from user Impl: $isValid");
      return Right(isValid);
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
}
