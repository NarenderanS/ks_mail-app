import '../entities/user.dart';

abstract class UserReository{
  Future<void> addUser(User user);
}