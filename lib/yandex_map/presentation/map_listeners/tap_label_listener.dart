import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/yandex_map/presentation/pages/info_placemark_screen.dart';
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:untitled/yandex_map/data/repository/yandex_coder_repository.dart';
import 'package:untitled/yandex_map/domain/models/map_point.dart';

final class MapObjectTapListenerImpl implements MapObjectTapListener {
  final BuildContext context;
  final MapWindow mapWindow;
  final String? data;
  MapObjectTapListenerImpl({required this.mapWindow,required this.context,this.data});


  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    // print("${event.geoObject.metadataContainer.get(GeoObjectSelectionMetadata.factory)}");
   // YandexCoderRepository().getAddressInfo(point!.latitude,point.longitude,context);
    //WarningDialog.showDialog(context, title:(mapObject.userData as MapPoint).name, text: text);
   print((mapObject.userData as MapPoint).name);
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBodyView(
        point:[mapObject.userData as MapPoint],
      ),
    );
    return true;
  }
}
  final class MapObjectTapListenerCluster implements MapObjectTapListener {
  final BuildContext context;
  final MapWindow mapWindow;
  MapObjectTapListenerCluster({required this.mapWindow,required this.context});

  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    print("CLUSTER PLACEMARK TAP:");
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalBodyView(
        point:[mapObject.userData as MapPoint],
      ),
    );
    return true;
  }
}
final class MapObjectTapListenerMyPos implements MapObjectTapListener {
  final BuildContext context;
  final MapWindow mapWindow;
  MapObjectTapListenerMyPos({required this.mapWindow,required this.context});



  @override
  bool onMapObjectTap(MapObject mapObject, Point point) {
    print("//////////ontap placemark icon${mapObject.parent.toString()}");
    // print("${event.geoObject.metadataContainer.get(GeoObjectSelectionMetadata.factory)}");
    GetIt.I<YandexCoderRepository>().getAddressByMyGeo(point!.latitude,point.longitude,context);
    return true;
  }
}