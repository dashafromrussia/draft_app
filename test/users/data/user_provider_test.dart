import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/api_data/api_data.dart';
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

class MockApiData extends Mock implements ApiData {}
class MockApiServer extends Mock implements ApiServer{}

void main() {
  late ApiServer apiServer;
  late UserProvider userProvider;
  late ApiData apiData;
  setUpAll(() {
   getIt.init(environment: 'user');
   apiServer = MockApiServer();
   apiData =MockApiData();
   userProvider = UserProviderImpl(apiServer,apiData);
  });

  tearDownAll(() {
    getIt.reset();
  });

  group('get user data from provider', () {
    test('get user data from provider success', () async {
      // Arrange

      // Stubbing

      when(() => apiData.baseUrl).thenReturn('user');
      when(() => apiServer.getResponse(any()))
          .thenAnswer((_)async => Response(
        requestOptions: RequestOptions(path: 'users'),
        data:[{
          "id": 1,
          "name": "Leanne Graham",
          "username": "Bret",
          "email": "Sincere@april.biz",
          "address": {
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": {
              "lat": "-37.3159",
              "lng": "81.1496"
            }
          },
          "phone": "1-770-736-8031 x56442",
          "website": "hildegard.org",
          "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
          }
        }],
      ),
      );
      // Act
      final result =  await userProvider.getData();

      // Assert
     expect(result,isA<List<User>>()
     );
    });

    test('get invalid user data from provider exception', () async {
      // Arrange

      // Stubbing

      when(() => apiData.baseUrl).thenReturn('users');
      when(() => apiServer.getResponse("users"))
          .thenAnswer((_)async => Response(
        requestOptions: RequestOptions(path: 'users'),
        data:[{
          "idd": 1,
          "name": "Leanne Graham",
          "username": "Bret",
          "email": "Sincere@april.biz",
          "address": {
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": {
              "lat": "-37.3159",
              "lng": "81.1496"
            }
          },
          "phone": "1-770-736-8031 x56442",
          "website": "hildegard.org",
          "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
          }
        }],
      ),
      );
      // Act
      final result =  userProvider.getData;

      // Assert
      expect(result,throwsA(isA<Exception>())
      );
    });

    test('get user data with invalid url from provider exception', () async {
      // Arrange

      // Stubbing

      when(() => apiData.baseUrl).thenReturn('users');
      when(() => apiServer.getResponse("users")).thenThrow(Exception());

          /*.thenAnswer((_)async => Response(
        requestOptions: RequestOptions(path: 'users'),
        data:[{
          "idd": 1,
          "name": "Leanne Graham",
          "username": "Bret",
          "email": "Sincere@april.biz",
          "address": {
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": {
              "lat": "-37.3159",
              "lng": "81.1496"
            }
          },
          "phone": "1-770-736-8031 x56442",
          "website": "hildegard.org",
          "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
          }
        }],
      ),
      );*/
      // Act
      final result =  userProvider.getData;

      // Assert
      expect(result,throwsA(isA<Exception>())
      );
    });
   
  });

 group('delete user from provider', () {
    test('delete user data from provider success', () async {
      // Arrange
  int id = 4;
      // Stubbing

      when(() => apiData.baseUrl).thenReturn('users');
      when(() => apiServer.deleteResponse('users/$id'))
          .thenAnswer((_)async => Response(
        requestOptions: RequestOptions(path: 'users'),
        data:{},
      ),
      );
      // Act
      final result =  await userProvider.deleteUser(id);
      // Assert
      expect(result,true
      );
    });
   test('delete user data from provider with invalid url throw exception', () async {
      // Arrange
      int id = 2;
      // Stubbing
      when(() => apiData.baseUrl).thenReturn('user');
      when(() => apiServer.deleteResponse('users/$id'))
          .thenThrow(Exception());
      // Act
      final result = userProvider.deleteUser;
      // Assert
      expect(result(id),throwsA(isA<Exception>())
      );
    });

  });
  group('select individ from provider', () {
    test('select individ data from provider success', () async {
      // Arrange
      int id = 1;
      // Stubbing

      when(() => apiData.baseUrl).thenReturn('users');
      when(() => apiServer.getResponse('users/$id'))
          .thenAnswer((_)async => Response(
        requestOptions: RequestOptions(path: 'users'),
        data:{
          "id": 1,
          "name": "Leanne Graham",
          "username": "Bret",
          "email": "Sincere@april.biz",
          "address": {
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": {
              "lat": "-37.3159",
              "lng": "81.1496"
            }
          },
          "phone": "1-770-736-8031 x56442",
          "website": "hildegard.org",
          "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
          }
        },
      ),
      );
      // Act
      final result = await userProvider.getUser(id);
      // Assert
      expect(result,isA<User>()
      );
    });
    test('select user data from provider with invalid url throw exception', () async {
      // Arrange
      int id = 2;
      // Stubbing
      when(() => apiData.baseUrl).thenReturn('user');
      when(() => apiServer.deleteResponse('users/$id'))
          .thenThrow(Exception());
      // Act
      final result = userProvider.getUser;
      // Assert
      expect(result(id),throwsA(isA<Exception>())
      );
    });
    test('select user data from provider with invalid data throw exception', () async {
      // Arrange
      // Stubbing
      int id = 2;
      when(() => apiData.baseUrl).thenReturn('users');
      when(() => apiServer.getResponse('users/$id'))
          .thenAnswer((_)async => Response(
        requestOptions: RequestOptions(path: 'users'),
        data:{
          "idd": 1,
          "name": "Leanne Graham",
          "username": "Bret",
          "email": "Sincere@april.biz",
          "address": {
            "street": "Kulas Light",
            "suite": "Apt. 556",
            "city": "Gwenborough",
            "zipcode": "92998-3874",
            "geo": {
              "lat": "-37.3159",
              "lng": "81.1496"
            }
          },
          "phone": "1-770-736-8031 x56442",
          "website": "hildegard.org",
          "company": {
            "name": "Romaguera-Crona",
            "catchPhrase": "Multi-layered client-server neural-net",
            "bs": "harness real-time e-markets"
          }
        },
      ),
      );
      // Act
      final result =  userProvider.getUser;

      // Assert
      expect(result(id),throwsA(isA<Exception>())
      );
    });

  });
  /*test('logout should throw an exception when the clear method returns false', () async {
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
    });*/
}