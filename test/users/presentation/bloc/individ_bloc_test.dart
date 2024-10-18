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
import 'package:untitled/users/presentation/bloc/individ/individ_bloc.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_event.dart' as invivid;
import 'package:untitled/users/presentation/bloc/individ/individ_state.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:untitled/users/domain/models/user_data.dart' as us;

class MockUserRepository extends Mock implements UserRepository {}
class MockEventsBus extends Mock implements EventsBus{}
class MockDataBusEvent extends Mock implements DataBusUpdateEvent{}

void main(){
  late UserRepository repository;
  late IndividBloc bloc;
  late EventsBus eventsBus;
  setUpAll(() {
    getIt.init(environment: 'user');
    repository =MockUserRepository();
    eventsBus = MockEventsBus();
    registerFallbackValue(MockDataBusEvent());
  });
  setUp(() {
    when(() => repository.getUser(any())).thenAnswer((_) => Future.value(us.UserData(id: 1,surname: "Vilio",
        name: "Avgustina",
        address: const AddressData(address: "Yoshkar_ola, Lenina 23"))));
    bloc = IndividBloc(repository,eventsBus);
  });

  tearDownAll(() {
    getIt.reset();
  });

  test('INDIVID BLOC should be initialized with StartIndividDataState', ()async{
    // act
    final state = bloc.state;
    // assert
    expect(state, isA<StartIndividDataState>());
  });
  blocTest(
      'get data of individ: success',
      build: (){
        when(() => repository.getUser(any())).thenAnswer((_) => Future.value(us.UserData(id: 1,surname: "Vilio",
            name: "Avgustina",
            address: const AddressData(address: "Yoshkar_ola, Lenina 23"))));
        return bloc;
      },
      act: (_bloc) => _bloc.add(const invivid.GetDataIndividEvent(id:1)),
      expect: () => [
        isA<LoadedIndividDataState>(),
      ],
      verify: (_){
        verify(() => repository.getUser(any())).called(1);
      }
  );
  blocTest(
      'get data of individ:error',
      build: (){
        when(() => repository.getUser(any())).thenThrow(Exception());
        return bloc;
      },
      act: (_bloc) => _bloc.add(const invivid.GetDataIndividEvent(id:1)),
      expect: () => [
        isA<IndividErrorDataState>(),
      ],
      verify: (_){
        verify(() => repository.getUser(any())).called(1);
      }
  );
  blocTest(
      'update name user',
      build: (){
        //eventsBus.eventBus.fire(DataBusUpdateEvent(data:{'id':_user!.id,'name':event.name}));

        when(() => repository.getUser(any())).thenAnswer((_) => Future.value(us.UserData(id: 1,surname: "Vilio",
            name: "Avgustina",
            address: const AddressData(address: "Yoshkar_ola, Lenina 23"))));
        return bloc;
      },
      act: (_bloc){
        _bloc.add(const invivid.GetDataIndividEvent(id:1));
        _bloc.add(const invivid.UpdateIndividNameEvent(name: "Masha"));},
      expect: () => [
        isA<LoadedIndividDataState>(),
        isA<LoadedIndividDataState>(),
      ],
      verify: (_){
        print("VERIFY COUnT::");
        verify(()=>eventsBus.fireEvent(any())).called(1);//
        verify(() => repository.getUser(any())).called(1);
      }
  );
  blocTest(
      'update surname user',
      build: (){
        when(() => repository.getUser(any())).thenAnswer((_) => Future.value(us.UserData(id: 1,surname: "Vilio",
            name: "Avgustina",
            address: const AddressData(address: "Yoshkar_ola, Lenina 23"))));
        return bloc;
      },
      act: (_bloc){
        _bloc.add(const invivid.GetDataIndividEvent(id:1));
        _bloc.add(const invivid.UpdateIndividSurnameEvent(surname: "IVankova"));},
      expect: () => [
        isA<LoadedIndividDataState>(),
        isA<LoadedIndividDataState>(),
      ],
      verify: (_){
        verify(()=>eventsBus.fireEvent(any())).called(1);
        verify(() => repository.getUser(any())).called(1);
      }
  );
  /*blocTest(
    'remove individ event success',
    build: (){
      /*when(() => repository.getData()).thenAnswer((_) => Future.value([us.UserData(id: 1,surname: "Vilio",
            name: "Avgustina",
            address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]));*/
      when(() => repository.removeIndivid(any(),any())).thenAnswer((_) => Future.value([]));
      return bloc;
    },
    seed:()=>LoadedUserDataState(users: [us.UserData(id: 1,surname: "Vilio",
        name: "Avgustina",
        address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]) as UserState,
    act: (_bloc){
      _bloc.add(const GetDataUserEvent());
      _bloc.add(const RemoveIndividEvent(id:1));
    },
    expect: () => [
      isA<LoadedUserDataState>(),
      isA<LoadedUserDataState>(),
    ],
  );*/

  /*blocTest(
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
    // seed:()=>LoadedUserDataState(users: [us.UserData(id: 1,surname: "Vilio",
    // name: "Avgustina",
    // address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]) as UserState,
    act: (_bloc){
      _bloc.add(const GetDataUserEvent());
      _bloc.add(const RemoveIndividEvent(id:1));
    },
    expect: () => [
      isA<LoadedUserDataState>(),
      isA<LoadedUserDataState>(),
    ],
  );

  blocTest(
    'update userdata',
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
    seed:()=>LoadedUserDataState(users: [us.UserData(id: 1,surname: "Vilio",
        name: "Avgustina",
        address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]) as UserState,
    act: (_bloc){
      _bloc.add(const GetDataUserEvent());
      _bloc.add(const UpdateUserListEvent(data: {'name':"Avgusti","id":1}));
    },
    expect: () => [
      isA<LoadedUserDataState>(),
      isA<LoadedUserDataState>(),
    ],
  );*/
}