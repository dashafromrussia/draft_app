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
import 'package:untitled/posts/data/repository/post_repository_impl.dart';
import 'package:untitled/posts/domain/models/post_data.dart';
import 'package:untitled/posts/domain/repository/post_repository.dart';


class MockPostProvider extends Mock implements PostProvider{}


void main(){
  late PostProvider provider;
  late PostRepository repository;

  setUpAll(() {
    GetIt.instance.init(environment: 'post');
  });

  setUp((){
    provider = MockPostProvider();
    repository = PostRepositoryImpl(provider);
  });

  tearDownAll(() {
    GetIt.instance.reset();
  });

  /*{
    "albumId": 1,
  "id": 1,
  "title": "accusamus beatae ad facilis cum similique qui sunt",
  "url": "https://via.placeholder.com/600/92c952",
  "thumbnailUrl": "https://via.placeholder.com/150/92c952"
}*/

  group('post data repository', () {
    test('get postdata: success', ()async{

      // Arrange
      when(() =>provider.getData()).thenAnswer((_) async=>
          [Post(id: 1, title: "title", url: "url", thumbnailUrl: "thumbnailUrl")]
     );
      final result = await repository.getData();
      // Assert
      expect(result, isA<List<PostData>>());
    });

   /* test('get data of user from back exception', ()async{
      when(() =>userProvider.getData()).thenThrow(Exception());
      final userData = userRepository.getData;
      expect(userData,
          throwsA(isA<Exception>()));
    });*/

    test('get postdata: failed', ()async{
      // Arrange
      when(() =>provider.getData()).thenThrow(Exception());
      final result = repository.getData;
      // Assert
      expect(result, throwsA(isA<Exception>()));
    });
  });

 group('get one post data repository', () {
    test('get one postdata: success', ()async{

      // Arrange
      when(() =>provider.getPost(1)).thenAnswer((_) async=>
      Post(id: 1, title: "title", url: "url", thumbnailUrl: "thumbnailUrl")
      );
      final result = await repository.getPost(1);
      // Assert
      expect(result, isA<PostData>());
    });
    test('get one postdata: failed', ()async{
      // Arrange
      when(() =>provider.getPost(1)).thenThrow(Exception());
      final result = repository.getPost;
      // Assert
      expect(result(1), throwsA(isA<Exception>()));
    });
    /* test('get data of user from back exception', ()async{
      when(() =>userProvider.getData()).thenThrow(Exception());
      final userData = userRepository.getData;
      expect(userData,
          throwsA(isA<Exception>()));
    });*/

    /*test('get postdata: failed', ()async{
      // Arrange
      when(() =>provider.getData()).thenThrow(Exception());
      final result = repository.getData;
      // Assert
      expect(result, throwsA(isA<Exception>()));
    });*/
  });
}