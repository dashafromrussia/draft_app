import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/navigation/route_interface.dart';
import 'package:untitled/navigation/bloc/data_testing_events_bloc.dart';
import 'package:untitled/posts/presentation/bloc/post_bloc.dart';
import 'package:untitled/posts/presentation/post_screen.dart';
import 'package:untitled/users/data/dto/address.dart';
import 'package:untitled/users/presentation/users_screen.dart';
import 'package:untitled/yandex_map/presentation/pages/map_screen.dart';

@Singleton(as:RouteInterface,env:['post'])
class RouteData implements RouteInterface{
  @override
  GoRouter goRouter()=>
      GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
             return MultiBlocProvider(
               providers: [
                 BlocProvider(
                 create: (BuildContext context) => GetIt.I.get<PostBloc>()..add(const GetDataPostEvent()),
              ),
                 BlocProvider(
                   create: (BuildContext context) => GetIt.I.get<DataBloc>(),
                 ),
               ],
               child:const PostScreen(),
             );

            },
            routes: <RouteBase>[
              /*GoRoute(
                path: 'maps',
                builder: (BuildContext context, GoRouterState state) {
                  return MapScreen(address:(state.extra as Map<String,dynamic>)['address'] as Address);
                  /*BlocProvider(
                create: (BuildContext context) => GetIt.I.get<DataBloc>(),
                child:const MyHomePage(title: 'Flutter Demo Home Page',));*/
                },
                /*builder: (BuildContext context, GoRouterState state) {
                return BlocProvider(
                    create: (BuildContext context) => GetIt.I.get<UserBloc>()
                      ..add(UserGetEvent(id:(state.extra as Map<String,dynamic>)['id'] as int)),
                    child: UserPage(id:(state.extra as Map<String,dynamic>)['id'] as int));
              },*/
              ),*/
            ],
          ),
        ],
      );
}