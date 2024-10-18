import 'dart:developer';

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


final class MapCameraListenerImpl implements MapCameraListener {
  @override
  void onCameraPositionChanged(Map map, CameraPosition cameraPosition, CameraUpdateReason cameraUpdateReason, bool finished) {
   //print("////////////////////camera pos chanccc ${map.cameraPosition.azimuth}");
  }
// ......
}