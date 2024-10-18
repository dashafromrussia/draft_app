import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:yandex_maps_mapkit/async.dart';
import 'package:yandex_maps_mapkit/image.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/model.dart';
import 'package:yandex_maps_mapkit/runtime.dart';
import 'package:yandex_maps_mapkit/ui_view.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';
import 'package:untitled/yandex_map/data/repository/yandex_coder_repository.dart';

class GeoObjectTapListenerImpl implements LayersGeoObjectTapListener {
  final BuildContext context;
  final MapWindow mapWindow;
  MapObject? searchMarkObg;
  MapObjectTapListener? listener;
  GeoObjectTapListenerImpl({required this.mapWindow,required this.context});

  @override
  bool onObjectTap(GeoObjectTapEvent event){
    if(searchMarkObg!=null){
      mapWindow.map.mapObjects.remove(searchMarkObg!);
    searchMarkObg!.removeTapListener(listener!);
    searchMarkObg = null;
    }
    print("on tap:");
    print(event.geoObject.metadataContainer.get(GeoObjectSelectionMetadata.factory)!);
    print("${event.geoObject.geometry[0].asPoint()}");
    mapWindow.map.selectGeoObject(event.geoObject.metadataContainer.get(GeoObjectSelectionMetadata.factory)!);
    final dataPoint = event.geoObject.geometry[0].asPoint();
   // print("${event.geoObject.metadataContainer.get(GeoObjectSelectionMetadata.factory)}");
     GetIt.I<YandexCoderRepository>().getAddressByMyGeo(dataPoint!.latitude, dataPoint.longitude,context);
    return true;
  }
}
