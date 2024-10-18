import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/api_data/api_data.dart';
import 'package:untitled/api_server.dart';
import 'package:untitled/users/data/api/user_provider.dart';
import 'package:untitled/users/data/dto/user.dart';

@Singleton(as:UserProvider,env:['user'])
class UserProviderImpl implements UserProvider
{
  final ApiServer _apiServer;
  final ApiData _apiData;
  UserProviderImpl(this._apiServer,this._apiData);

  @override
  Future<List<User>>getData()async{
    try{
      //GetIt.I.get<ApiData>().baseUrl
     /* final Response<List> response = await _apiServer.dioAuth()
          .get('/${_apiData.baseUrl}');*/
      print("api data");
      print(_apiData.baseUrl);
      final response = await _apiServer.getResponse(_apiData.baseUrl);
      print("REsponse:");
      print(response.data);
      return (response.data as List).map((e) =>User.fromJson(e)).toList();
    }catch(e){
      print(e.toString());
      throw Exception();
      print(e.toString());
    }
    // return [{"env":"dev"}];
  }

  @override
  Future<User> getUser(int id)async{
    try{
     /* final response = await _apiServer.dioAuth()
          .get('/${GetIt.I.get<ApiData>().baseUrl}/$id');*/
      final response = await _apiServer.getResponse("${_apiData.baseUrl}/$id");
      print(response.data);
      return User.fromJson(response.data);
    }catch(e){
      print(e.toString());
      throw Exception();
      print(e.toString());
    }
  }

  @override
  Future<bool> deleteUser(int id)async{
    try{
      final response = await _apiServer.deleteResponse("${_apiData.baseUrl}/$id");
      /*final response = await _apiServer.dioAuth()
          .delete('/${GetIt.I.get<ApiData>().baseUrl}/$id');*/
      print("delete response data ${response.data}");
      return true;
    }catch(e){
      print(e.toString());
    throw Exception();
    }
  }

}

