import 'package:untitled/users/domain/models/user_data.dart';

 abstract interface class UserRepository{
  Future<List<UserData>>getData();
  Future<UserData>getUser(int id);
  Future<List<UserData>>updateUserData(Map<String,dynamic> data,List<UserData> list);
  Future<List<UserData>>removeIndivid(int id,List<UserData> list);
}