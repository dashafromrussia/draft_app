import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'geo.g.dart';

@JsonSerializable()
class Geo extends Equatable{
  final String lat,lng;
  Geo({required this.lat,required this.lng});
  factory Geo.fromJson(Map<String, dynamic> json) => _$GeoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GeoToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>[lat,lng];

  Geo copyWith({
    String? lat,
    String? lng,
  }) {
    return
      Geo(lat:lat??this.lat,lng: lng??this.lng);
}

/* "address": {
      "street": "Kulas Light",
      "suite": "Apt. 556",
      "city": "Gwenborough",
      "zipcode": "92998-3874",
      "geo": {
        "lat": "-37.3159",
        "lng": "81.1496"
      }*/
    }