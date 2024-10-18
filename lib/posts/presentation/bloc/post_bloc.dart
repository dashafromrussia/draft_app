import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/events.dart';
import 'package:untitled/posts/domain/models/post_data.dart';
import 'package:untitled/posts/domain/repository/post_repository.dart';
import 'package:equatable/equatable.dart';
part 'post_event.dart';
part 'post_state.dart';


@Singleton(env:['post'])
class PostBloc extends Bloc<PostEvent,PostState>{
  final PostRepository _repository;
  final EventsBus _eventsBus;
  PostBloc(this._repository,this._eventsBus) : super(const StartPostDataState()){
    on<PostEvent>((event,emit)async{
      if(event is GetDataPostEvent){
        print("GET PoST DATAAAAA");
        List<PostData> posts = [];
        try{
        _eventsBus.fireEvent(DataBusPostEvent(data:"get all posts"));
          posts =await _repository.getData();
          emit(LoadedPostDataState(posts: posts));
        }catch(e){
          emit(const PostErrorDataState());
        }
        print(posts.length);
      }else if (event is GetOneDataPostEvent) {
        print("GET one post DATAAAAA");
        try {
           final PostData post = await _repository.getPost(event.id);
          emit(LoadedOnePostDataState(post: post));
        } catch (e) {
          emit(const PostErrorDataState());
        }
      }
    });
  }

}