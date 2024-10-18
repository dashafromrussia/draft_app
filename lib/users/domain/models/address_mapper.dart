import 'package:injectable/injectable.dart';
import 'package:untitled/users/data/dto/user.dart';
import 'package:untitled/users/domain/models/address_data.dart';
import 'package:untitled/users/domain/models/user_data.dart';

import '../../data/dto/address.dart';

@LazySingleton(env:['user'])
class AddressDataMapper{
  AddressData fromAddressModel(Address address)=>
      AddressData(address:address.city+" "+address.street+" "+address.suite);
}