import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/events.dart';
import 'package:untitled/users/domain/models/user_data.dart';
import 'dart:convert';
import 'package:untitled/users/domain/repository/user_repository.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_event.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_state.dart';

@Singleton(env:['user'])
class IndividBloc extends Bloc<IndividEvent,IndividState> {
  final UserRepository _repository;
   UserData? _user;
  final EventsBus _eventsBus;
  IndividBloc(this._repository,this._eventsBus) : super(const StartIndividDataState()) {
    on<IndividEvent>((event, emit) async {
      if (event is GetDataIndividEvent) {
        print("GET USER DATAAAAA");
        try {
          if(_user!=null && _user!.id==event.id){

          }else{
            _user = await _repository.getUser(event.id);
          }
          emit(LoadedIndividDataState(user: _user!));
        } catch (e) {
          emit(const IndividErrorDataState());
        }
        print(_user);
      }
      else if(event is UpdateIndividNameEvent) {
         //GetIt.instance.get<EventsBus>().
             _eventsBus.fireEvent(DataBusUpdateEvent(data:{'id':_user!.id,'name':event.name}));
         _user = _user!.copyWith(name:event.name);
       print("INDIVID NAME ${_user?.name}");
       emit(LoadedIndividDataState(user: _user!));
      }else if(event is UpdateIndividSurnameEvent) {
       // GetIt.instance.get<EventsBus>()
            _eventsBus.fireEvent(DataBusUpdateEvent(data:{'id':_user!.id,'surname':event.surname}));
      _user = _user!.copyWith(surname:event.surname);
      emit(LoadedIndividDataState(user: _user!));
        print("INDIVID SURNAME ${_user?.name}");
      }else if(event is UpdateIndividAddressEvent){
        _user = _user!.copyWith(address: _user!.address.copyWith(address:event.address));
      }
    });
  }
}