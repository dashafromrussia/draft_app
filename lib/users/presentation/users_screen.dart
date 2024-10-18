import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/users/domain/models/user_data.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_bloc.dart';
import 'bloc/all_users/users_event.dart';
import 'bloc/all_users/users_state.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late String lates;

  void printData(){
    print(lates);}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return
                  switch(state){
                    StartUserDataState()=> const Text("start"),
                    LoadingUserDataState()=> const Text("loading"),
                    LoadedUserDataState(users: List<UserData> posts)=>
                        SingleChildScrollView(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child:Column(
                                children: [
                                  ...posts.map((post) =>
                                      GestureDetector(
                                        onTap:(){
                                          context.go('/individ',extra: {'id':post.id});
                                        },
                                          child:Container(
                                           // height: 400,
                                            width:MediaQuery.of(context).size.width*0.8,
                                          margin:const EdgeInsets.symmetric(vertical: 5),
                                          padding: const EdgeInsets.symmetric(vertical: 5),
                                          decoration:BoxDecoration(
                                            color: Colors.yellow,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child:
                                          Column(children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(post.name),
                                                GestureDetector(
                                                  child: const Icon(Icons.delete_forever_outlined,color: Colors.grey,),
                                                  onTap:(){
                                                    context.read<UserBloc>().add(RemoveIndividEvent(id: post.id));
                                                  },
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 10,)
                                          ],))))
                                ],
                              )),
                        ),
                    UserErrorDataState()=>Text('error')
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
