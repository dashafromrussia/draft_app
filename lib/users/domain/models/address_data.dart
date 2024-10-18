import 'package:equatable/equatable.dart';
import 'package:untitled/users/data/dto/address.dart';

class AddressData extends Equatable{
  final String address;
  const AddressData({required this.address});

  AddressData copyWith({
    String? address
  }) {
    return
      AddressData(address: address?? this.address);
  }


  @override
  // TODO: implement props
  List<Object?> get props =>[address];
}