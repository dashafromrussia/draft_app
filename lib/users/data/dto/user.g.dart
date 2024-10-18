// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      birth: json['birth'] as String?,
      phone: json['phone'] as String,
      email: json['email'] as String,
      surname: json['username'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'birth': instance.birth,
      'username': instance.surname,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address.toJson(),
    };
