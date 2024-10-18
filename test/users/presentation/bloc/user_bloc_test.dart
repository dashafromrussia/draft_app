import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:untitled/events.dart';
import 'package:untitled/injection.config.dart';
import 'package:untitled/injection.dart';
import 'package:untitled/users/data/api/user_provider.dart';
import 'package:untitled/users/domain/models/address_data.dart';
import 'package:untitled/users/domain/repository/user_repository.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_bloc.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_event.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_state.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:untitled/users/domain/models/user_data.dart' as us;
//написать отдельно тесты на класс EventBus
//цикл при тестировании делает всего один оборот,если не указать задержку
//тест падает из-за задержки  await Future.delayed(const Duration(seconds: 1)).Это характерно только для тестирования bloc поэтому необходимо ставить задержку в blocTest в поле wait
class MockUserRepository extends Mock implements UserRepository {}
class MockEventsBus extends Mock implements EventsBus{}

void main(){
  late UserRepository repository;
  late UserBloc bloc;
  late MockEventsBus eventsBus;
  setUpAll(() {
    getIt.init(environment: 'user');
    repository =MockUserRepository();
    eventsBus = MockEventsBus();
  });
  setUp(() {
    /*when(() => repository.getData()).thenAnswer((_) => Future.value([us.UserData(id: 1,surname: "Vilio",
        name: "Avgustina",
        address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]));*/
    bloc = UserBloc(repository,eventsBus);
  });
tearDown(() => bloc.close());
  tearDownAll(() {
    getIt.reset();
  });

  test('UserBloc should be initialized with StartUserDataState', ()async{
    // act
    final state = bloc.state;
    // assert
    expect(state, isA<StartUserDataState>());
  });


  blocTest(
    'get data of users: success',
    build: (){
      Stream<DataBusUpdateEvent> streamEvent = const Stream.empty();
      when(() => eventsBus.getStream()).thenAnswer((_)=>streamEvent);
      when(() => repository.getUser(any())).thenAnswer((_) => Future.value(us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
         address: const AddressData(address: "Yoshkar_ola, Lenina 23"))));
      when(() => repository.getData()).thenAnswer((_) => Future.value([us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]));
      return bloc;
    },
    act: (_bloc) => _bloc.add(const GetDataUserEvent()),
      wait: const Duration(seconds: 6),
    expect: () => [
      isA<LoadedUserDataState>(),
    ],
      verify: (_){
        verify(() => repository.getData()).called(1);
        verify(()=>eventsBus.getStream()).called(1);
      }
  );

  late StreamController<DataBusUpdateEvent> _controller;
  late Stream<DataBusUpdateEvent> streamEvent;

  blocTest(
    'get data of users:error',
    setUp: (){
    _controller = StreamController();
      streamEvent = _controller.stream;
    },
      tearDown: (){
      _controller.close();
      },
    build: (){
      final users = [us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))];

      final dataRes = users.map((e){
        if(e.id==1) {
          e = e.copyWith(name:"Avgusti");
        }
        return e;
      }).toList();
      _controller.add(DataBusUpdateEvent(data: {"id":1,"name":"Avgusti"}));
      when(() => eventsBus.getStream()).thenAnswer((_)=>streamEvent);
      when(() => repository.getData()).thenThrow(Exception());
      when(() => repository.updateUserData(any(),any())).thenAnswer((_)async =>dataRes);
      return bloc;
    },
    act: (_bloc) => _bloc.add(const GetDataUserEvent()),
    expect: () => [
      isA<UserErrorDataState>(),
      isA<LoadedUserDataState>()
    ],
    verify: (_){
      verify(() => repository.getData()).called(1);
      verify(()=>eventsBus.getStream()).called(1);
    }
  );

 blocTest(
      'remove individ event success',
      build: (){
       /*when(() => repository.getData()).thenAnswer((_) => Future.value([us.UserData(id: 1,surname: "Vilio",
            name: "Avgustina",
            address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]));*/
        when(() => repository.removeIndivid(any(),any())).thenAnswer((_) => Future.value([]));
        return bloc;
      },
   //seed:()=>LoadedUserDataState(users: [us.UserData(id: 1,surname: "Vilio",
      //  name: "Avgustina",
       // address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]) as UserState,
     act: (_bloc){
    //   _bloc.add(const GetDataUserEvent());
       _bloc.add(const RemoveIndividEvent(id:1));
     },
     expect: () => [
       isA<LoadedUserDataState>(),
       //isA<LoadedUserDataState>(),
     ],
  );

  blocTest(
    'remove individ event failed',
    build: (){
      /*when(() => repository.getData()).thenAnswer((_) => Future.value([us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]));*/
      when(() => repository.removeIndivid(any(),any())).thenAnswer((_)async =>[us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]);
      return bloc;
    },
    //seed:()=>LoadedUserDataState(users: [us.UserData(id: 1,surname: "Vilio",
     //   name: "Avgustina",
     //   address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]) as UserState,
    act: (_bloc){
     // _bloc.add(const GetDataUserEvent());
      _bloc.add(const RemoveIndividEvent(id:1));
      },
    expect: () => [
   // isA<LoadedUserDataState>(),
    isA<LoadedUserDataState>(),
    ],
  );

  blocTest(
    'UPDATE userdata',
    build: (){
      final users = [us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))];

      final dataRes = users.map((e){
        if(e.id==1) {
            e = e.copyWith(name:"Avgusti");
          }
        return e;
      }).toList();
   /* when(() => repository.getData()).thenAnswer((_) => Future.value([us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]));*/
      when(() => repository.updateUserData(any(),any())).thenAnswer((_)async =>dataRes);
      return bloc;
    },
    // seed:()=>LoadedUserDataState(users: [us.UserData(id: 1,surname: "Vilio",
   //  name: "Avgustina",
 //   address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]) as UserState,
    act: (_bloc){
    //  _bloc.add(const GetDataUserEvent());
      _bloc.add(const UpdateUserListEvent(data: {'name':"Avgusti","id":1}));
    },
    expect: () => [
      //isA<LoadedUserDataState>(),
      isA<LoadedUserDataState>(),
    ],
  );
}