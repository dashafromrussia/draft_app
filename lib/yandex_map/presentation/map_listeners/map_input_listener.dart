import 'package:flutter/material.dart';
import 'package:yandex_maps_mapkit/async.dart';
import 'package:yandex_maps_mapkit/image.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/model.dart';
import 'package:yandex_maps_mapkit/runtime.dart';
import 'package:yandex_maps_mapkit/ui_view.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';

final class MapInputListenerImpl implements MapInputListener {

  @override
  void onMapTap(Map map, Point point) {
     print("///ONMAPTAPPP  ..........//////");
    // Handle single tap ...
  }

  @override
  void onMapLongTap(Map map, Point point) {
    // Handle long tap ...
  }
}

