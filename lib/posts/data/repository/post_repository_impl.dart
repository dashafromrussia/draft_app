import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/posts/data/dto/post.dart';
import 'package:untitled/posts/domain/models/post_data.dart';
import 'package:untitled/posts/domain/models/post_data_mapper.dart';
import 'package:untitled/posts/domain/repository/post_repository.dart';
import '../api/post_provider.dart';

@Singleton(as:PostRepository,env:['post'])
class PostRepositoryImpl implements PostRepository{
  final PostProvider _providerImpl;
  PostRepositoryImpl(this._providerImpl);

  @override
  Future<List<PostData>> getData()async{
   try{
     print("get data");
     List<Post> users = await _providerImpl.getData();
     return [...users.map((e) => GetIt.I.get<PostDataMapper>().fromPostModel(e))];
   }catch(e){
     print(e);
     throw Exception();
   }
  }

  @override
  Future<PostData> getPost(int id)async{
    try{
      Post post = await _providerImpl.getPost(id);
      return GetIt.I.get<PostDataMapper>().fromPostModel(post);
    }catch(e){
      throw Exception();
    }
    throw UnimplementedError();
  }

}