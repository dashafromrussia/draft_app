import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:untitled/navigation/route_interface.dart';
import 'package:untitled/users/data/dto/address.dart';
import 'package:untitled/users/presentation/bloc/all_users/users_bloc.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_bloc.dart';
import 'package:untitled/users/presentation/individ_screen.dart';
import 'package:untitled/users/presentation/users_screen.dart';
import 'package:untitled/yandex_map/presentation/pages/map_screen.dart';
import 'package:untitled/yandex_map/presentation/pages/order_page.dart';

@Singleton(as:RouteInterface,env:['user'])
class RouteData implements RouteInterface{
@override
 GoRouter goRouter()=>
    GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return const UserScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: 'individ',
              builder: (BuildContext context, GoRouterState state) {
                return IndividWrapperScreen(id:(state.extra as Map<String,dynamic>)['id']);
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
              routes: [
                GoRoute(
                  path: 'maps',
                  builder: (BuildContext context, GoRouterState state) {
                    return
                    MapScreen(id:(state.extra as Map<String,dynamic>)['id'],
                        address:(state.extra as Map<String,dynamic>)['address']);
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
                  routes: [
                    GoRoute(
                        path: 'order',
                        builder: (BuildContext context, GoRouterState state) {
                          return  BlocProvider(
                              create: (BuildContext context) => GetIt.I.get<IndividBloc>(),
                              child:OrderPage(text: (state.extra as Map<String,dynamic>)['text'] as String));
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
                        routes: [

                        ]
                    ),
                  ]
                ),
              ]
            ),
          ],
        ),
      ],
    );
}