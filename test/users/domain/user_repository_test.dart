import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/api_data/users/user_api_data.dart';
import 'package:untitled/api_server.dart';
import 'package:mocktail/mocktail.dart';
import 'package:untitled/injection.config.dart';
import 'package:untitled/injection.dart';
import 'package:untitled/users/data/api/user_provider.dart';
import 'package:untitled/users/data/api/user_provider_impl.dart';
import 'package:untitled/users/data/dto/address.dart';
import 'package:untitled/users/data/dto/geo.dart';
import 'package:untitled/users/data/dto/user.dart';
import 'package:untitled/users/data/repository/user_repository_impl.dart';
import 'package:untitled/users/domain/models/address_data.dart';
import 'package:untitled/users/domain/models/user_data.dart' as us;
import 'package:untitled/users/domain/models/user_data_mapper.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';
/*Для тела теста обычно используется паттерн ААА:
сначала, подготавливаем все необходимое (Arrange),
потом выполняем нужное действие (Act)
 и проверяем его результат (Assert).
 Arrange — шаг, где создаем переменные и входные данные перед вызовом функции, которую хотим протестировать.

Например, если нужно проверить функцию validateEmail когда email не пустой, то нужно создать переменную String validEmail = ‘test@example.com’.
Act — вызов функции, которую нужно протестировать с уже подготовленными на прошлом шаге входными данными: Validator.validateEmail(validEmail).
Assert — шаг, где проверяем соответствует ли результат ожиданиям, используя функцию expect.

Например: expect(result, true), expect(result, 1000), expect(result, “Minh”), …

 example:
 test('validateEmail should return true when the email is not empty', () {
// Arrange
String validEmail = 'test@example.com';

// Act
bool result = Validator.validateEmail(validEmail);

// Assert
expect(result, true);
});
 */

class MockUserProvider extends Mock implements UserProvider {}

void main() {
  late MockUserProvider userProvider;
  late UserRepositoryImpl userRepository;
  setUpAll(() {
    getIt.init(environment: 'user');
     userProvider = MockUserProvider();
     userRepository = UserRepositoryImpl(userProvider);
  });

  tearDownAll(() {
    getIt.reset();
  });
  group('get user data', () {
    test('get data of user from back success', ()async{
      // Arrange
      // Stubbing
    // when(() => mockApiServer.dioAuth()).thenReturn(any(that:isA<Dio>()));
      when(() =>userProvider.getData()).thenAnswer((_) => Future.value([User(id: 2, name:"Mana", address: Address(city: "city", street: "street", suite: "suite",
          geo:Geo(lat: "lat", lng: "lng")), phone: "phone", email: "email", surname: "surname")]));

    final userData = await userRepository.getData();
    //any(that:isA<List<User>>())
      // Act
      //final result = loginViewModel.login(email, password);
//[User(id: 2, name:"Mana", address: Address(city: "city", street: "street", suite: "suite",
//           geo:Geo(lat: "lat", lng: "lng")), phone: "phone", email: "email", surname: "surname")]
      // Assert
      expect(userData,isA<List<us.UserData>>());
    });
    // [us.UserData(id:2,surname:"surname",name:"Mana",address: const AddressData(address:"city street suite"))]
    test('get data of user from back exception', ()async{
      when(() =>userProvider.getData()).thenThrow(Exception());
      final userData = userRepository.getData;
      expect(userData,
          throwsA(isA<Exception>()));
    });
    /*test('login should return true when the password are correct', () {
      // Arrange
      final mockSharedPreferences = MockSharedPreferences();
      final loginViewModel = LoginViewModel(sharedPreferences: mockSharedPreferences);
      String email = 'ntminh@gmail.com';
      String password = '123456';

      // Stubbing
      when(() => mockSharedPreferences.getString(email)).thenReturn('123456');

      // Act
      final result = loginViewModel.login(email, password);

      // Assert
      expect(result, true);
    });*/
  });


  group('get one user data', () {
    test('get data of one user from back success', ()async{
      // Arrange
     int id  = 1;
      // Stubbing
      // when(() => mockApiServer.dioAuth()).thenReturn(any(that:isA<Dio>()));
      when(() =>userProvider.getUser(id)).thenAnswer((_) => Future.value(User(id: 1, name:"Mana", address: Address(city: "city", street: "street", suite: "suite",
          geo:Geo(lat: "lat", lng: "lng")), phone: "phone", email: "email", surname: "surname")));

      final userData = await userRepository.getUser(id);

      expect(userData,isA<us.UserData>());
    });
    test('get data of one user from back exception', ()async{
      // Arrange
      int id  = 1;
      when(() =>userProvider.getUser(id)).thenThrow(Exception());

      final userData =  userRepository.getUser;
      expect(userData(id),throwsA(isA<Exception>()));
    });

  });
 group('delete one user data', () {
    test('delete data of one user from back success', ()async{
      // Arrange
      int id  = 1;
      final dataUsers = [us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))];
      // Stubbing
      // when(() => mockApiServer.dioAuth()).thenReturn(any(that:isA<Dio>()));
      when(() =>userProvider.deleteUser(id)).thenAnswer((_) => Future.value(true));

      final userData = await userRepository.removeIndivid(id,dataUsers);

      expect(userData,[]);
    });
    test('delete data of one user from back exception', ()async{
      // Arrange
      final dataUsers = [us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))];
      int id  = 1;
      when(() =>userProvider.deleteUser(id)).thenThrow(Exception());
      final deleteData = await userRepository.removeIndivid(id,dataUsers);
      expect(deleteData,dataUsers);
    });
    test('update', ()async{
      // Arrange
      final dataUsers = [us.UserData(id: 1,surname: "Vilio",
          name: "Avgustina",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))];
      final udpateData = await userRepository.updateUserData({"id":1,"name":"Avgusti"}, dataUsers);
      expect(udpateData,[us.UserData(id: 1,surname: "Vilio",
          name: "Avgusti",
          address: const AddressData(address: "Yoshkar_ola, Lenina 23"))]);
    });
  });
  /*group('logout', () {
    test('logout should return true when the clear method returns true', () async {
      // Arrange
      final mockSharedPreferences = MockSharedPreferences();
      final loginViewModel = LoginViewModel(sharedPreferences: mockSharedPreferences);

      // Stubbing
      when(() => mockSharedPreferences.clear()).thenAnswer((_) => Future.value(true));

      // Act
      final result = await loginViewModel.logout();

      // Assert
      expect(result, true);
    });

    test('logout should throw an exception when the clear method returns false', () async {
      // Arrange
      final mockSharedPreferences = MockSharedPreferences();
      final loginViewModel = LoginViewModel(sharedPreferences: mockSharedPreferences);

      // Stubbing
      when(() => mockSharedPreferences.clear()).thenAnswer((_) => Future.value(false));

      // Act
      final Future<bool> Function() call = loginViewModel.logout;

      // Assert
      expect(call, throwsFlutterError);
    });

    test('logout should throw an exception when the clear method throws an exception', () async {
      // Arrange
      final mockSharedPreferences = MockSharedPreferences();
      final loginViewModel = LoginViewModel(sharedPreferences: mockSharedPreferences);

      // Stubbing
      when(() => mockSharedPreferences.clear()).thenThrow(Exception('Logout failed'));

      // Act
      final call = loginViewModel.logout;

      // Assert
      expect(
        call,
        throwsA(isA<FlutterError>().having((e) => e.message, 'error message', 'Logout failed')),
      );
    });
  });*/
}