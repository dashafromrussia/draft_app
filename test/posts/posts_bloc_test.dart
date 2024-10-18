import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:untitled/api_data/api_data.dart';
import 'package:untitled/api_server.dart';
import 'package:untitled/events.dart';
import 'package:untitled/injection.config.dart';
import 'package:untitled/posts/data/api/post_provider.dart';
import 'package:untitled/posts/data/api/post_provider_impl.dart';
import 'package:dio/dio.dart';
import 'package:untitled/posts/data/dto/post.dart';
import 'package:untitled/posts/data/repository/post_repository_impl.dart';
import 'package:untitled/posts/domain/models/post_data.dart';
import 'package:untitled/posts/domain/repository/post_repository.dart';
import 'package:untitled/posts/presentation/bloc/post_bloc.dart';


class MockRepository extends Mock implements PostRepository{}
class MockEventBus extends Mock implements EventsBus{}
class MockDataBusEvent extends Mock implements DataBusPostEvent{}

void main(){
  late PostRepository repository;
  late EventsBus eventsBus;
  late PostBloc bloc;
  setUpAll(() {
    GetIt.instance.init(environment: 'post');
  });

  setUp((){
    repository = MockRepository();
    eventsBus = MockEventBus();
    bloc = PostBloc(repository, eventsBus);
    registerFallbackValue(MockDataBusEvent());
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

  test('PostBloc initialstate', () {
    // act
    final state = bloc.state;
    // assert
    expect(state, isA<StartPostDataState>());
  });

  blocTest(
    'post bloc getData:success',
    build: (){
      when(() =>repository.getData()).thenAnswer((_) async=>
      [const PostData(title: "title", url: "url", id: 1)]
      );
      return bloc;
    },
    act: (_bloc) => _bloc.add(const GetDataPostEvent()),
    expect: () => [
      isA<LoadedPostDataState>(),
    ],
    verify: (_) {
      verify(() => eventsBus.fireEvent(any())).called(1);
    }
  );
  blocTest(
      'post bloc getData:failed',
      build: (){
        when(() =>repository.getData()).thenThrow(Exception());
        return bloc;
      },
      act: (_bloc) => _bloc.add(const GetDataPostEvent()),
      expect: () => [
        isA<PostErrorDataState>(),
      ],
      verify: (_) {
        verify(() => eventsBus.fireEvent(any())).called(1);
      }
  );
  blocTest(
      'one post bloc getData:success',
      build: (){
        when(() =>repository.getPost(any())).thenAnswer((_) async=>
        const PostData(title: "title", url: "url", id: 1)
        );
        return bloc;
      },
      act: (_bloc) => _bloc.add(const GetOneDataPostEvent(id: 1)),
      expect: () => [
        isA<LoadedOnePostDataState>(),
      ],
  );
  blocTest(
    'one post bloc getData:failed',
    build: (){
      when(() =>repository.getPost(1)).thenThrow(Exception());
      return bloc;
    },
    act: (_bloc) => _bloc.add(const GetOneDataPostEvent(id: 1)),
    expect: () => [
      isA<PostErrorDataState>(),
    ],
  );
}