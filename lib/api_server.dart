import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:untitled/api_data/api_data.dart';
@LazySingleton()
class ApiServer{
  const ApiServer();
  Dio _dioAuth() {
    return Dio(
      BaseOptions(
        baseUrl:'https://jsonplaceholder.typicode.com',
        headers: {
          'Content-Type': 'application/json'
        },
        //connectTimeout: const Duration(seconds: 5),
        //receiveTimeout: const Duration(seconds: 3),
      ),
    );
  }

  Future<Response>getResponse(String url){
    print("URL URL$url");
    return _dioAuth()
        .get('/$url');
  }
  Future<Response>deleteResponse(String url){
    return _dioAuth()
        .delete('/$url');
  }
}