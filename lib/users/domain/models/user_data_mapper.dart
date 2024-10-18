import 'package:injectable/injectable.dart';
import 'package:untitled/users/data/dto/user.dart';
import 'package:untitled/users/domain/models/address_mapper.dart';
import 'package:untitled/users/domain/models/user_data.dart';

@LazySingleton(env:['user'])
class UserDataMapper{
UserData fromUserModel(User user)=>
    UserData(surname: user.surname, name: user.name,
        address:AddressDataMapper().fromAddressModel(user.address),id: user.id);
}