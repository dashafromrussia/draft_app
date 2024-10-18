import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/yandex_map/presentation/pages/info_placemark_screen.dart';
import 'package:untitled/yandex_map/domain/models/map_point.dart';
import 'package:untitled/yandex_map/presentation/map_listeners/tap_label_listener.dart';
import 'package:untitled/yandex_map/data/repository/yandex_coder_repository.dart';
import 'package:yandex_maps_mapkit/async.dart';
import 'package:yandex_maps_mapkit/image.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/model.dart';
import 'package:yandex_maps_mapkit/runtime.dart';
import 'package:yandex_maps_mapkit/ui_view.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';

final class ClusterListenerImpl implements ClusterListener {
final BuildContext context;


ClusterListenerImpl({required this.context});

static ClusterTapListenerImpl? listener;

  @override
  void onClusterAdded(Cluster cluster) {
    listener ??= ClusterTapListenerImpl(context: context);
    cluster.addClusterTapListener(listener!);
    cluster.appearance.setView(
        ViewProvider(builder: () =>Container(width: 50,height: 50,
          decoration:BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color:Colors.amber,
          ),
          child:
        Center(child: Text("${cluster.placemarks.length}"),),), configurationFactory: (MediaQueryData mediaQuery) {
          return const ViewConfiguration(size: Size(50, 50));
        })
    );

  }
}

final class ClusterTapListenerImpl implements ClusterTapListener{
  final BuildContext context;
  ClusterTapListenerImpl ({required this.context});
  @override
  bool onClusterTap(Cluster cluster) {
    print('cluster tap ${cluster.placemarks.length}');
   final List<MapPoint> list = [];
    for(PlacemarkMapObject obg in cluster.placemarks){
      list.add(obg.userData as MapPoint);
    }
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBodyView(
        point:list,
      ),
    );
    //final point =Point(latitude: 59.937376, longitude: 30.33621);
   // YandexCoderRepository().getAddressInfo(point!.latitude,point.longitude,context);
    return true;
    //throw UnimplementedError();
  }

}