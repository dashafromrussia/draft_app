import 'package:get_it/get_it.dart';
import 'package:untitled/bloc_observer.dart';
import 'package:untitled/injection.dart';
import 'package:untitled/navigation/route_interface.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_bloc.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_event.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_bloc.dart';
import 'package:untitled/yandex_map/presentation/bloc/data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:flutter_bloc/flutter_bloc.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = ErrorObserver();
   configureDependencies('user');
  await init.initMapkit(apiKey: 'f13a0812-5e38-4ac6-b591-071e97915f75');

  runApp(MaterialApp(home: BlocProvider(
      create: (BuildContext context) =>DataBloc(),
      child:MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => GetIt.I.get<UserBloc>()..add(const GetDataUserEvent()),
        ),
        BlocProvider(
          create: (BuildContext context) => GetIt.I.get<IndividBloc>(),)

      ],
      child:MaterialApp.router(
          routerConfig:GetIt.I.get<RouteInterface>().goRouter()
      ),
    );
  }
}

