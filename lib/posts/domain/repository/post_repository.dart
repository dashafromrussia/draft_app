import 'package:untitled/posts/domain/models/post_data.dart';

 abstract interface class PostRepository{
  Future<List<PostData>>getData();
  Future<PostData>getPost(int id);
}