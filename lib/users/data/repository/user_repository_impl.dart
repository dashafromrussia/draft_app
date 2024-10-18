import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/users/data/dto/user.dart';
import 'package:untitled/users/domain/models/user_data.dart';
import 'package:untitled/users/domain/models/user_data_mapper.dart';
import 'package:untitled/users/domain/repository/user_repository.dart';
import '../api/user_provider.dart';

@Singleton(as:UserRepository,env:['user'])
class UserRepositoryImpl implements UserRepository{
  final UserProvider _providerImpl;

  UserRepositoryImpl(this._providerImpl);

  @override
  Future<List<UserData>> getData()async{
   try{
    /* print("get data");
     for(int x=0;x<5;x++){
       print(x);
       await Future.delayed(const Duration(seconds: 1)).then((_){
         print(x);
       });
     }*/
     List<User> users = await _providerImpl.getData();
     return [...users.map((e) => GetIt.I.get<UserDataMapper>().fromUserModel(e))];
   }catch(e){
     print(e);
     throw Exception();
   }
  }

  @override
  Future<UserData> getUser(int id)async{
    try{
      User user = await _providerImpl.getUser(id);
      return GetIt.I.get<UserDataMapper>().fromUserModel(user);
    }catch(e){
      throw Exception();
    }
  }

  @override
  Future<List<UserData>> updateUserData(Map<String,dynamic> data,List<UserData> users)async{
    print("update repo000");
    return users.map((e){
      if(e.id==data['id']) {
        if (data.containsKey('name')) {
          e = e.copyWith(name: data['name']);
        } else if (data.containsKey('surname')) {
          e = e.copyWith(surname:data['surname']);
        }
      }
      return e;
    }).toList();
  }

  @override
  Future<List<UserData>> removeIndivid(int id,List<UserData> list)async{
    try{
      await _providerImpl.deleteUser(id);
     return list.where((element) => element.id!=id).toList();
    }catch(e){
      return list;
    }
  }

}