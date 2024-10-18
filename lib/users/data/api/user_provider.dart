import 'package:untitled/users/data/dto/user.dart';

abstract class UserProvider{
  Future<List<User>>getData();
  Future<User>getUser(int id);
  Future<bool>deleteUser(int id);
}