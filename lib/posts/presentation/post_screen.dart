import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/posts/presentation/bloc/post_bloc.dart';

import '../domain/models/post_data.dart';


class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}
/*final class StartPostDataState extends PostState{
  const StartPostDataState();

}

final class LoadingPostDataState extends PostState{

  const LoadingPostDataState();

}
final class LoadedPostDataState extends PostState{
  final List<PostData> posts;
  const LoadedPostDataState({required this.posts});

}
final class PostErrorDataState extends PostState{
  const PostErrorDataState();
}*/

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              return
              switch(state){
              StartPostDataState()=> const Text("start"),
              LoadingPostDataState()=> const Text("loading"),
              LoadedPostDataState(posts: List<PostData> posts)=>
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                    child:Column(
                  children: [
                   ...posts.map((post) =>
                   Container(
                     margin:const EdgeInsets.symmetric(vertical: 5),
                     padding: const EdgeInsets.symmetric(vertical: 5),
                     decoration:BoxDecoration(
                       color: Colors.yellow,
                       borderRadius: BorderRadius.circular(10),
                     ),
                       child:
                   Column(children: [
                     Text(post.title),
                     const SizedBox(height: 10,)
                   ],)))
                  ],
                )),
              ),
              PostErrorDataState()=>Text('error'),
              LoadedOnePostDataState()=>Text('select one post')
              };
                SingleChildScrollView(
                child: Column(
                  children: [

                  ],
                ),
              );
              // return widget here based on BlocA's state
            }
        )
        /*SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        )*/
        /*GestureDetector(child:Text("Post"),onTap:(){
          context.read<PostBloc>().add(const GetDataPostEvent());
        },),*/
      ),
    );
  }
}
