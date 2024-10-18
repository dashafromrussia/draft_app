import 'package:equatable/equatable.dart';
import 'package:untitled/users/data/dto/address.dart';
import 'package:untitled/users/domain/models/address_data.dart';

class UserData extends Equatable{
  final int id;
  final String name;
  final String surname;
  final AddressData address;
  UserData({required this.id,required this.surname,required this.name,required this.address});

  UserData copyWith({
    int? id,
    String? name,
    String? surname,
    AddressData? address
  }) {
    return
      UserData(id: id??this.id, surname:surname??this.surname,
          name:name??this.name, address: address?? this.address);
  }


  @override
  // TODO: implement props
  List<Object?> get props =>[name,surname,address];
}