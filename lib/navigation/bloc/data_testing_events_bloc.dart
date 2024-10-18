import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/events.dart';

abstract class DataEvent{

  const DataEvent();
}

class DataAddEvent extends DataEvent{
  const DataAddEvent();
}

abstract class DataEventState{
  const DataEventState();
}
class DataAddEventState extends DataEventState{
  const DataAddEventState();
}
class DataStartEventState extends DataEventState{
  const DataStartEventState();
}


@Singleton()
class DataBloc extends Bloc<DataEvent,DataEventState>{
  //late StreamSubscription sub;
  DataBloc() : super(const DataStartEventState()){
    on<DataEvent>((event,emit)async{
      if(event is DataAddEvent){
        print("data event");
        /*GetIt.I.get<EventsBus>().eventBus.on<DataBusEvent>().listen((event) {
          print("Event Bus from postbloc $event");
          // add(const DataAddEvent());
        });*/
      emit(const DataAddEventState());
      }
    });
add(const DataAddEvent());
  }

@override
  Future<void> close() {
    //sub.cancel();
    return super.close();
  }

}