import 'package:bloc/bloc.dart';

class ErrorObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("error bloc");
  }
  @override
  void onEvent(Bloc bloc,Object? event){
    super.onEvent(bloc, event);
    print("OBSERVER EvENT $event");
  }
}
