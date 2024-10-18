import 'dart:async';
import 'package:bloc/bloc.dart';
import 'dart:convert';



abstract class DataEvent{
  const DataEvent();
  @override
  List<Object> get props => [];
}

class ChangeDataEvent extends DataEvent{
final String text;
  const ChangeDataEvent({required this.text});
  @override
  List<Object> get props => [];
}




abstract class DataState{
  const DataState();

}

class ChangeDataState extends DataState{
final String data;
  const ChangeDataState({required this.data});

}

class StartDataState extends DataState{

  const StartDataState();
  @override
  List<Object> get props => [];
}






class DataBloc extends Bloc<DataEvent,DataState>{

  DataBloc() : super(const StartDataState()){
    on<DataEvent>((event,emit)async{
      if(event is ChangeDataEvent){
        print("CHANGE DATAAAAA");
        emit(const StartDataState());
        emit(ChangeDataState(data: event.text));
      }
    });

  }

}