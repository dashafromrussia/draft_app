import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:untitled/api_data/api_data.dart';
import 'package:untitled/api_server.dart';
import 'package:untitled/injection.config.dart';
import 'package:untitled/posts/data/api/post_provider.dart';
import 'package:untitled/posts/data/api/post_provider_impl.dart';
import 'package:dio/dio.dart';
import 'package:untitled/posts/data/dto/post.dart';


class MockApiServer extends Mock implements ApiServer{}
class MockApiData extends Mock implements ApiData{}
void main(){
late PostProvider provider;
late ApiServer apiServer;
late ApiData apiData;

  setUpAll(() {
   GetIt.instance.init(environment: 'post');
  });

  setUp((){
    apiServer = MockApiServer();
    apiData = MockApiData();
    provider = PostProviderImpl(apiServer,apiData);
  });

  tearDownAll(() {
    GetIt.instance.reset();
  });

  group('post data provider', () {
    test('get postdata: success', ()async{

      // Arrange
      when(() =>apiData.baseUrl).thenReturn('posts');
      when(() =>apiServer.getResponse('posts')).thenAnswer((_) async=>
          Response(requestOptions: RequestOptions(path: 'posts'),data:
          [ {
            "albumId": 1,
            "id": 1,
            "title": "accusamus beatae ad facilis cum similique qui sunt",
            "url": "https://via.placeholder.com/600/92c952",
            "thumbnailUrl": "https://via.placeholder.com/150/92c952"
          },]));
       final result = await provider.getData();
      // Assert
     expect(result, isA<List<Post>>());
    });
    test('get postdata: exception', ()async{
      // Arrange
      when(() =>apiData.baseUrl).thenReturn('posts');
      when(() =>apiServer.getResponse('posts')).thenAnswer((_) async=>
          Response(requestOptions: RequestOptions(path: 'posts'),data:
          [ {
            "urlll": "https://via.placeholder.com/600/92c952",
            "thumbnailUrlll": "https://via.placeholder.com/150/92c952"
          },]));

      final result = provider.getData;
      // Assert
      expect(result, throwsException);
    });
    test('get postdata: exception from inner function', ()async{
      // Arrange
      when(() =>apiData.baseUrl).thenReturn('post');
      when(() =>apiServer.getResponse('posts')).thenThrow(Exception());

      final result = provider.getData;
      // Assert
      expect(result, throwsException);
    });

  });
group('one post data provider', () {
  test('get one postdata: success', ()async{
final int id = 1;
final String url = "posts";
    // Arrange
    when(() =>apiData.baseUrl).thenReturn("posts");
    when(() =>apiServer.getResponse("posts/$id")).thenAnswer((_) async=>
        Response(requestOptions: RequestOptions(path:'posts'),data:
        {
          "albumId": 1,
          "id": 1,
          "title": "accusamus beatae ad facilis cum similique qui sunt",
          "url": "https://via.placeholder.com/600/92c952",
          "thumbnailUrl": "https://via.placeholder.com/150/92c952"
        },));
    final result = await provider.getPost(1);
    // Assert
    expect(result, isA<Post>());
  });
  test('get one postdata: exception', ()async{
    const int id = 1;
    when(() =>apiData.baseUrl).thenReturn('posts');
    when(() =>apiServer.getResponse('post/$id')).thenThrow(Exception());

    final result = provider.getPost;
    // Assert
    expect(result(id), throwsException);
  });
  test('get postdata: exception from inner function', ()async{
    // Arrange
    const int id = 1;
    when(() =>apiData.baseUrl).thenReturn('posts');
    when(() =>apiServer.getResponse('posts')).thenAnswer((_) async=>
        Response(requestOptions: RequestOptions(path: 'posts'),data:
         {
          "urlll": "https://via.placeholder.com/600/92c952",
          "thumbnailUrlll": "https://via.placeholder.com/150/92c952"
        },));
    final result = provider.getPost;
    // Assert
    expect(result(id), throwsException);
  });

});
}