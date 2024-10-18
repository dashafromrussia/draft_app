import 'package:equatable/equatable.dart';
import 'package:untitled/users/data/dto/address.dart';

class PostData
   extends Equatable
{
  final int id;
  final String title;
  final String url;

  const PostData({required this.title,required this.url,required this.id});

  PostData copyWith({
    int? id,
    String? title,
    String? url
  }) {
    return
      PostData(
          title: title ?? this.title, url: url ?? this.url, id: id ?? this.id);
  }

  @override
  // TODO: implement props
 List<Object?> get props => [title,url,id];
}