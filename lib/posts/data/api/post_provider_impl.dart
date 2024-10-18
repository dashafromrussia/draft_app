import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/api_data/api_data.dart';
import 'package:untitled/api_server.dart';
import 'package:untitled/posts/data/api/post_provider.dart';
import 'package:untitled/posts/data/dto/post.dart';

@Singleton(as:PostProvider,env:['post'])
class PostProviderImpl implements PostProvider
{
  final ApiServer _apiServer;
  final ApiData _apiData;
  PostProviderImpl(this._apiServer,this._apiData);

  @override
  Future<List<Post>>getData()async{
    try{
      /*final response = await _apiServer.dioAuth()
          .get('/${GetIt.I.get<ApiData>().baseUrl}');*/
      final response = await _apiServer.getResponse(_apiData.baseUrl);
      print(response.data);
      return (response.data as List).map((e) =>Post.fromJson(e)).toList();
    }catch(e){
      print(e.toString());
      throw Exception();
      print(e.toString());
    }
    // return [{"env":"dev"}];
  }

  @override
  Future<Post> getPost(int id)async{
    try{
      /* final response = await _apiServer.dioAuth()
          .get('/${GetIt.I.get<ApiData>().baseUrl}/$id');*/
      final response = await _apiServer.getResponse("${_apiData.baseUrl}/$id");
      print(response.data);
      return Post.fromJson(response.data);
    }catch(e){
      print(e.toString());
      throw Exception();
      print(e.toString());
    }
  }

}

