
part of 'post_bloc.dart';

sealed class PostState extends Equatable{
  const PostState();
@override
  List<Object> get props =>[];
}

final class StartPostDataState extends PostState{
  const StartPostDataState();



}

final class LoadingPostDataState extends PostState{

  const LoadingPostDataState();


}
final class LoadedPostDataState extends PostState{
  final List<PostData> posts;
  const LoadedPostDataState({required this.posts});
  @override
  List<Object> get props =>[posts];
}

final class LoadedOnePostDataState extends PostState{
  final PostData post;
  const LoadedOnePostDataState({required this.post});
  @override
  List<Object> get props =>[post];
}

final class PostErrorDataState extends PostState{
  const PostErrorDataState();
}