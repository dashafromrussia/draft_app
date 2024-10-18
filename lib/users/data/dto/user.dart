import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:untitled/users/data/dto/address.dart';
part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User extends Equatable{
 int id;
// @JsonKey(required: true)
final String? birth;
@JsonKey(name: "username")
final String surname;
final String name, email, phone;
final Address address;

User({required this.id,required this.name,required this.address,this.birth,
  required this.phone,required this.email,required this.surname});

factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

/// Connect the generated [_$PersonToJson] function to the `toJson` method.
Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [id,birth,surname,name,email,phone,address];

}

/* {
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
  }*/