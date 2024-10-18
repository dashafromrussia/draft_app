import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/api_data/api_data.dart';
import 'package:untitled/api_data/users/user_api_data.dart';
import 'package:untitled/api_server.dart';
import 'package:mocktail/mocktail.dart';
import 'package:untitled/events.dart';
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


void main() {
late EventsBus eventBus;
  setUpAll(() {

  });

  tearDownAll(() {

  });

setUp(() {
eventBus = EventsBus();
});

  group('///////EVENT BUS GROUP////////', () {
    test('@@@@@@@@@@get stream data', () async {

final elemOfStream =  DataBusUpdateEvent(data: {"data":"data"});
final elemOfStream1 =  DataBusUpdateEvent(data: {"data":"data1"});

expectLater(
    eventBus.getStream(),
    emitsInOrder([
      elemOfStream,elemOfStream1
    ]));

eventBus.fireEvent(elemOfStream);
eventBus.fireEvent(elemOfStream1);
eventBus.eventBus.destroy();
    });

  });


}