
part of 'post_bloc.dart';

sealed class PostEvent{
  const PostEvent();

}

final class GetDataPostEvent extends PostEvent{

  const GetDataPostEvent();

}

final class GetOneDataPostEvent extends PostEvent{
final int id;
  const GetOneDataPostEvent({required this.id});

}