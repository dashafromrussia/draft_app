import 'package:untitled/posts/data/dto/post.dart';

abstract class PostProvider{
  Future<List<Post>>getData();
  Future<Post>getPost(int id);
}