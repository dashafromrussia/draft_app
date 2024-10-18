import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/users/data/dto/geo.dart';
part 'address.g.dart';

@JsonSerializable()
class Address extends Equatable{
  final String street,suite,city;
  final Geo geo;

  Address({required this.city,required this.street,required this.suite,
    required this.geo});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>[street,suite,city,geo];

  Address copyWith({
    String? city,
    String? street,
    String? suite,
    Geo? geo
  }) {
    return
   Address(city:city??this.city, street:street??this.street,
       suite:suite??this.suite, geo:geo??this.geo);
  }

}

/* "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }
    }*/