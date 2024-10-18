import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post.g.dart';
// dart run build_runner build --delete-conflicting-outputs
@JsonSerializable(explicitToJson: true)
class Post
   // extends Equatable
{
  int id;
  final String title, url, thumbnailUrl;

  Post({required this.id,required this.title,required this.url,
    required this.thumbnailUrl});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PostToJson(this);

 // @override
  // TODO: implement props
  //List<Object?> get props =>[id,title,url,thumbnailUrl];

}
// dart run build_runner build --delete-conflicting-outputs
/*{
    "albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
  }*/