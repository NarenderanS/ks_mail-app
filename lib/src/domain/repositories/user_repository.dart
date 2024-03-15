import 'package:dartz/dartz.dart';
import 'package:ks_mail/core/error/failures.dart';

import '../entities/user.dart';
import '../entities/user_details.dart';

abstract class UserRepository {
  Future<Either<Failure, UserDetails>> getUserById(int id);
  Future<Either<Failure, List<User>>> getAllUsers();
  Future<UserDetails> getUserByMail(String mail);
  Future<Either<Failure, bool>> validateUser(String mail, String password);
  Future<Either<Failure, String>> getUserPasswordById(int id);
  Future<void> addUser(User user);
  Future<void> updateUser(User user);
}
