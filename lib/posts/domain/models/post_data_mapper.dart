import 'package:injectable/injectable.dart';
import 'package:untitled/posts/data/dto/post.dart';
import 'package:untitled/posts/domain/models/post_data.dart';

@LazySingleton(env:['post'])
class PostDataMapper{
PostData fromPostModel(Post post)=>
    PostData(title: post.title, url: post.thumbnailUrl, id: post.id);
}