import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/users/domain/models/user_data.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_bloc.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_event.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_state.dart';
//https://jsonplaceholder.typicode.com/posts

class IndividWrapperScreen extends StatelessWidget {
  final int id;
  const IndividWrapperScreen({super.key,required this.id});

  @override
  Widget build(BuildContext context) {
   context.read<IndividBloc>().add(GetDataIndividEvent(id: id??1));
    return const IndividScreen();
  }
}



class IndividScreen extends StatefulWidget {
  const IndividScreen();

  @override
  State<IndividScreen> createState() => _IndividScreenState();
}

class _IndividScreenState extends State<IndividScreen> {
  final TextEditingController _nameController =  TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final bloc = context.watch<IndividBloc>();
    if(bloc.state is LoadedIndividDataState){
      _nameController.text = (bloc.state as LoadedIndividDataState).user.name;
      _surnameController.text = (bloc.state as LoadedIndividDataState).user.surname;
    }
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Center(child:BlocBuilder<IndividBloc, IndividState>(
          builder: (context, state) =>
          switch(state){
            StartIndividDataState()=> const Text("start"),
            LoadingIndividDataState()=> const Text("loading"),
            LoadedIndividDataState(user: UserData user)=>
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height/2,
                    decoration:BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
                      borderRadius: BorderRadius.only(
                        topLeft:Radius.circular(60),bottomRight:Radius.circular(60),
                      ),
                    ),child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("About user:${user.name}"),
                const SizedBox(height: 10,),
                TextField(
                    onChanged:(String text){
                      context.read<IndividBloc>().add(UpdateIndividNameEvent(name: text));
                    },
                  controller:_nameController,
                decoration: InputDecoration(
                border: OutlineInputBorder(),
                  hintText: 'Enter name',
                )),
                    const SizedBox(height: 10,),
                    TextField(
                      onChanged:(String text){
                        context.read<IndividBloc>().add(UpdateIndividSurnameEvent(surname: text));
                      },
                        controller:_surnameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter name',
                        )),
                    const SizedBox(height: 10,),
                    Text("${
                        user.address.address}"),
                    const SizedBox(height: 10,),
                    ElevatedButton(onPressed:(){
                      context.push('/individ/maps',extra: {"id":user.id,"address":user.address.address
                        });
                    }, child:Text("update address"))
                  ],
                )),
            IndividErrorDataState()=>Text('error')
          }
              /*state.when(
            init: () => const SizedBox.shrink(),
            loading: () =>const Center(child:CircularProgressIndicator(color: Colors.black,)),
            success: (user) => Center(
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height/2,
                  decoration:BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    border: Border.all(color: Theme.of(context).colorScheme.inversePrimary),
                    borderRadius: BorderRadius.only(
                      topLeft:Radius.circular(60),bottomRight:Radius.circular(60),
                    ),
                  ),child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("About user ${
                      user.names}"),
                  const SizedBox(height: 10,),
                  Text("${
                      user.username}"),
                  const SizedBox(height: 10,),
                  Text("${
                      user.company.name}"),
                  const SizedBox(height: 10,),
                  Text("${
                      user.company.phase}"),
                ],
              )),
            ),
            error: () =>const SizedBox.shrink(),
          ),*/
        ))
    );
  }
}
