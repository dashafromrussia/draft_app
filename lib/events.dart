import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

abstract class DataBusEvent{
}


class DataBusPostEvent extends DataBusEvent{
  final dynamic data;
 DataBusPostEvent({required this.data});
}

class DataBusUpdateEvent extends DataBusEvent{
  final Map<String,dynamic> data;
  DataBusUpdateEvent({required this.data});
}


@LazySingleton()
class EventsBus{
  //@preResolve
  EventBus get eventBus => _getEventBus();
   EventBus? _eventBus;

 EventBus _getEventBus(){
   return _eventBus ??= EventBus();
  }

  Stream<DataBusEvent> getStream(){
   print("create stream");
   return eventBus.on<DataBusEvent>();
  }


  void fireEvent(DataBusEvent event){
   eventBus.fire(event);
  }
}