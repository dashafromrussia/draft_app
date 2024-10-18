import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/events.dart';
import 'package:untitled/users/domain/models/user_data.dart';
import 'dart:convert';
import 'package:untitled/users/domain/repository/user_repository.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_event.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_state.dart';

@Singleton(env:['user'])
class UserBloc extends Bloc<UserEvent,UserState>{
  final UserRepository _repository;
  List<UserData> _users = [];
  final EventsBus _eventsBus;
   StreamSubscription? sub;
  //late UserData dataus;
  UserBloc(this._repository,this._eventsBus):super(const StartUserDataState()){

    print("CREATE USER BLoC");
    on<UserEvent>((event,emit)async{
      if(event is GetDataUserEvent){
        print("GET USER DATAAAAA");
        //await Future.delayed(const Duration(seconds: 1)).then((_) => print(1)); //тест падает из-за задержки
         for(int x=0;x<5;x++){
          print(x);
         await Future.delayed(const Duration(seconds: 1)).then((_) => print(x));
        }
        try {
           sub ??= _eventsBus.getStream()
          .listen((event) {
        // if(event is DataBusUpdateEvent){
             event as DataBusUpdateEvent;
        add(UpdateUserListEvent(data: event.data));
        print("UPdate data");
        //}
      });
          // dataus = await _repository.getUser(1);
         _users =await _repository.getData();
          emit(LoadedUserDataState(users: _users));

        }catch(e){
          emit(const UserErrorDataState());
        }
        print(state);
      }if(event is RemoveIndividEvent){
        print("USER STATE:::${_users.length}");
          _users = await _repository.removeIndivid(event.id,_users);
          print("USER STATE:::${_users.length}");
        emit(LoadedUserDataState(users: _users));
      }if(event is UpdateUserListEvent){
          _users = await _repository.updateUserData(event.data,_users);
       print("testi:${_users[0].name}");
        emit(LoadedUserDataState(users: _users));
      }
    });
//add(const GetDataUserEvent());
  }

  @override
  Future<void> close() {
    sub?.cancel();
    return super.close();
  }

}

