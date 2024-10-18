import 'dart:collection';
import 'dart:developer';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/users/data/dto/address.dart';
import 'package:untitled/users/domain/repository/user_repository.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_bloc.dart';
import 'package:untitled/users/presentation/bloc/individ/individ_event.dart';
import 'package:untitled/yandex_map/presentation/bloc/data_bloc.dart';
import 'package:untitled/yandex_map/presentation/map_listeners/cluster_listener.dart';
import 'package:untitled/yandex_map/presentation/map_listeners/geobject_tap_listener.dart';
import 'package:untitled/yandex_map/presentation/map_listeners/map_input_listener.dart';
import 'package:untitled/yandex_map/presentation/map_listeners/tap_label_listener.dart';
import 'package:untitled/yandex_map/data/repository/yandex_coder_repository.dart';
import 'package:yandex_maps_mapkit/directions.dart';
import 'package:yandex_maps_mapkit/image.dart' as image;
import 'package:flutter/material.dart';
//import  'package:flutter/src/painting/image_provider.dart';
import 'package:untitled/yandex_map/presentation/map_listeners/map_camera_listener.dart';
import 'package:yandex_maps_mapkit/async.dart';
import 'package:yandex_maps_mapkit/image.dart';
import 'package:yandex_maps_mapkit/init.dart' as init;
import 'package:yandex_maps_mapkit/mapkit.dart';
import 'package:yandex_maps_mapkit/mapkit_factory.dart';
import 'package:yandex_maps_mapkit/model.dart';
import 'package:yandex_maps_mapkit/runtime.dart';
import 'package:yandex_maps_mapkit/search.dart';
import 'package:yandex_maps_mapkit/ui_view.dart';
import 'package:yandex_maps_mapkit/yandex_map.dart';
//import 'package:yandex_geocoder/yandex_geocoder.dart' hide Point;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/yandex_map/domain/models/map_point.dart';



class MapScreen extends StatefulWidget {
  final int id;
  final String address;
  const MapScreen({super.key,required this.id,required this.address});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapWindow? _mapWindow;

  ///////camera position
  final MapCameraListener _mapCameraListener = MapCameraListenerImpl();
  late List<PlacemarkMapObject> placemarks;

  void addListenerCameraPosition(MapWindow mapWindow) {
    mapWindow?.map.addCameraListener(_mapCameraListener);
  }

  List<MapPoint> _getMapPoints() {
    return const [
      MapPoint(
          name: 'Стокгольм',
          desc:
          "Cтолица и крупнейший город Швеции. Расположен на протоках, соединяющих озеро Меларен с Балтийским морем. В черте города — 14 островов.",
          latitude: 59.347360,
          longitude: 18.341573,
          img:
          'https://encrypted-tbn1.gstatic.com/licensed-image?q=tbn:ANd9GcS0LwZQLiqGHuRp9nw6klCZXhrz_-olb4KmAuDfDRZJfWj1QgyXr2pZ-CyAM8YhUib8JElH97zTtEpP0EULsANwme9Qq1Jlctn1SJdPTA'),
      MapPoint(
          name: 'Москва',
          img:
          "https://static-cse.canva.com/blob/846514/pexelsvierro3629813.jpg",
          desc:
          'Cтолица России, город федерального значения, административный центр Центрального федерального округа и центр Московской области, в состав которой не входит',
          latitude: 55.755864,
          longitude: 37.617698),
      MapPoint(
          name: 'Лондон',
          desc:
          "Cтолица и крупнейший город Англии и Великобритании. Административно образует регион Англии Большой Лондон.",
          img:
          "https://encrypted-tbn2.gstatic.com/licensed-image?q=tbn:ANd9GcQSslEZn6yup0IVIogZvjO1uqpCKVYVPY-i2SXFg7zARRFb3Mlvnq1LIrPilkvAUq-KLOx4ABgO_fsdLDb9hH8iJqkuGw09sDeVxNZRGg",
          latitude: 51.507351,
          longitude: -0.127696),
      MapPoint(
          name: 'Рим',
          img:
          'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcSkUUGGuDYwRSL5kQjocEJqzQ9qy-vMwobHydvx8v6Y0nPPCt2AA8cDzStuwjEUiK2S61EwYGAiorJykdiaHSi4dkqqdGChI0INvkOClQ',
          desc:
          'Основанный в 753 г. до н. э. Рим — один из старейших городов Европы, столица древней цивилизации. Ещё в античности (III век н. э.) Рим называли «Вечным городом»',
          latitude: 41.887064,
          longitude: 12.504809),
      MapPoint(
          name: 'Париж',
          desc:
          "Столица Франции Париж – один из главных европейских городов и мировой центр культуры, искусства, моды и гастрономии.",
          img:
          'https://lh6.googleusercontent.com/proxy/VSDBMeOlHFia1rVgjtrzdD42kC-HsycxOoAOJ_VCsdrf1eGyS8-438Q3d5ZNb2nr8rNFxLRn6010qqIibO88yCK8tSWGlI9c4nZ4SpC3OuHk_771MhIgkGMUPNdhXZ3ytMcfVc54246Fipdt8_4UvcyhIAcAkKg=w1080-h624-n-k-no',
          latitude: 48.856663,
          longitude: 2.351556),
      MapPoint(
          name: 'Париж',
          desc:
          "Столица Франции Париж – один из главных европейских городов и мировой центр культуры, искусства, моды и гастрономии.",
          img:
          'https://lh6.googleusercontent.com/proxy/VSDBMeOlHFia1rVgjtrzdD42kC-HsycxOoAOJ_VCsdrf1eGyS8-438Q3d5ZNb2nr8rNFxLRn6010qqIibO88yCK8tSWGlI9c4nZ4SpC3OuHk_771MhIgkGMUPNdhXZ3ytMcfVc54246Fipdt8_4UvcyhIAcAkKg=w1080-h624-n-k-no',
          latitude: 48.836663,
          longitude: 2.341556),
      MapPoint(
          name: 'Париж',
          desc:
          "Столица Франции Париж – один из главных европейских городов и мировой центр культуры, искусства, моды и гастрономии.",
          img:
          'https://lh6.googleusercontent.com/proxy/VSDBMeOlHFia1rVgjtrzdD42kC-HsycxOoAOJ_VCsdrf1eGyS8-438Q3d5ZNb2nr8rNFxLRn6010qqIibO88yCK8tSWGlI9c4nZ4SpC3OuHk_771MhIgkGMUPNdhXZ3ytMcfVc54246Fipdt8_4UvcyhIAcAkKg=w1080-h624-n-k-no',
          latitude: 48.856663,
          longitude: 2.351556),
      MapPoint(
          name: 'Париж',
          desc:
          "Столица Франции Париж – один из главных европейских городов и мировой центр культуры, искусства, моды и гастрономии.",
          img:
          'https://lh6.googleusercontent.com/proxy/VSDBMeOlHFia1rVgjtrzdD42kC-HsycxOoAOJ_VCsdrf1eGyS8-438Q3d5ZNb2nr8rNFxLRn6010qqIibO88yCK8tSWGlI9c4nZ4SpC3OuHk_771MhIgkGMUPNdhXZ3ytMcfVc54246Fipdt8_4UvcyhIAcAkKg=w1080-h624-n-k-no',
          latitude: 48.836663,
          longitude: 2.341556),
    ];
  }

//////////////////////metki///////
  late MapObjectTapListener _mapObjectTapListener;

  void addPlaceMarks(MapWindow mapWindow,BuildContext context) {
    final mapPoints = _getMapPoints();
    _mapObjectTapListener=MapObjectTapListenerImpl(mapWindow: mapWindow,context: context);
    final imageProvider = image.ImageProvider.fromImageProvider(
        const AssetImage('assets/doctors-office-2.png'));
    placemarks = mapWindow.map.mapObjects.addPlacemarks(
        imageProvider, const IconStyle(visible: true), points: [
      ... mapPoints.map((e) => Point(latitude: e.latitude, longitude: e.longitude))
    ]);
    int count = 0;
    for (var element in placemarks) {
      final mapObjectTapListener=
      MapObjectTapListenerImpl(mapWindow: mapWindow,context: context,);
      element.setText("this is metka");
      element.addTapListener(_mapObjectTapListener);
      element.userData = mapPoints[count];
      count++;
    }
    /*final placemark = mapWindow.map.mapObjects.addPlacemark()
    ..geometry = const Point(latitude: 55.751225, longitude:37.629540)
    ..setIcon(imageProvider);*/
    // placemark.addTapListener(listener);
  }

//////////poligons////
  final points = [
    Point(latitude: 59.935493, longitude: 30.327392),
    Point(latitude: 59.938185, longitude: 30.32808),
    Point(latitude: 59.937376, longitude: 30.33621),
    Point(latitude: 59.934517, longitude: 30.335059),
  ];

  final innerPoints = [
    Point(latitude: 59.937487, longitude: 30.330034),
    Point(latitude: 59.936688, longitude: 30.33127),
    Point(latitude: 59.937116, longitude: 30.33328),
    Point(latitude: 59.937704, longitude: 30.331842),
  ];

  void createPoligon(MapWindow mapWindow) {
    final polygon = Polygon(LinearRing(points), [LinearRing(innerPoints)]);
    final polygonMapObject = mapWindow.map.mapObjects.addPolygon(polygon);
  }

//polyline/////


  void createPolyline(MapWindow mapWindow) {
    final polyline = Polyline(points);
    final polylineObject =
    mapWindow.map.mapObjects.addPolylineWithGeometry(polyline);
    polylineObject
      ..strokeWidth = 15.0
      ..outlineWidth = 10.0
      ..outlineColor = Colors.red;
  }

/////////circle///////

  void createCircle(MapWindow mapWindow) {
    final circle = Circle(
      Point(latitude: 59.935493, longitude: 30.327392),
      radius: 100.0,
    );
    mapWindow.map.mapObjects.addCircle(circle)
      ..strokeWidth = 2.0
      ..strokeColor = Colors.red
      ..fillColor = Colors.redAccent;
  }

//////clusters/////////

  late MapObjectTapListener _mapObjectTapListenerCluster;
  late ClusterizedPlacemarkCollection clusterizedCollection;
  void getClusters(MapWindow mapView,BuildContext context) {
    final mapPoints = _getMapPoints();
    final clusterListener = ClusterListenerImpl(context:context);
    _mapObjectTapListenerCluster = MapObjectTapListenerCluster(mapWindow: mapView,context: context);

    clusterizedCollection = mapView.map.mapObjects
        .addClusterizedPlacemarkCollection(clusterListener);
    //clusterizedCollection.userData = dataMark;
    final points = [
      Point(latitude: 59.935493, longitude: 30.327392),
      Point(latitude: 59.938185, longitude: 30.32808),
      Point(latitude: 59.937376, longitude: 30.33621),
      Point(latitude: 59.934517, longitude: 30.335059),
      Point(latitude: 59.934514, longitude: 30.335055),
      Point(latitude: 60.934517, longitude: 30.335059),
      Point(latitude: 60.954514, longitude: 30.335055),
    ];

    var imageProvider = image.ImageProvider.fromImageProvider(
        const AssetImage('assets/doctors-office-2.png'));
    int count = 0;
    points.forEach((point) {
      //String data = dataMark[count];
      // MapObjectTapListener mapObjectTapListenerCluster =
      //MapObjectTapListenerCluster(mapWindow: mapView,context: context,data:"data");
      clusterizedCollection.addPlacemark()
        ..geometry = point//Point(latitude:mapPoints[count].latitude, longitude:mapPoints[count].longitude)
        ..setIcon(imageProvider)
        ..userData = mapPoints[count]
        ..addTapListener(_mapObjectTapListenerCluster);
      count++;
    });
    //clusterizedCollection.addTapListener(_mapObjectTapListenerCluster);
    clusterizedCollection.clusterPlacemarks(clusterRadius: 5.0, minZoom: 9);
    //  clusterizedCollection.zIndex = 2.0;
  }

//geo objects///
  late final GeoObjectTapListenerImpl  _geoObjectTapListener;

  void getGeoObg(MapWindow mapWindow, BuildContext context) {
    _geoObjectTapListener =
        GeoObjectTapListenerImpl(mapWindow: mapWindow, context: context);
    mapWindow.map.addTapListener(_geoObjectTapListener);
  }

//tap map
  late final _mapInputListener = MapInputListenerImpl();

//////////////SEARCHHHHHH//////////////


  MapObject? searchMarkObg;
  void searchData(String text,MapWindow mapWindow) {
    print("SEARCH GEO DATA $text");
    GeoObject geo;
    final searchManager =
    SearchFactory.instance.createSearchManager(SearchManagerType.Online);

    final searchOptions = SearchOptions(
      geometry: true,
      searchTypes: SearchType.Geo,
      resultPageSize: 1,
    );
    final geometry = VisibleRegionUtils.toPolygon(mapWindow!.map.visibleRegion);
    final searchListener = SearchSessionSearchListener(onSearchResponse: (SearchResponse response) {
      print("geo data: ${response}");
      final res = response.collection.children
          .map((it) => it.asGeoObject())
          .whereType<GeoObject>().toList();
      geo = res.first;
      //final dataPoint = geo!.geometry[0].asPoint();
      //final metadata = geo.metadataContainer.get(SearchBusinessObjectMetadata.factory);
      final metadata = geo.metadataContainer.get(
          SearchToponymObjectMetadata.factory);
      print(geo.name);
      print("geo data: ${metadata!.address!.formattedAddress}");
      print(geo.metadataContainer
          .get(GeoObjectSelectionMetadata.factory));
      //final metadata = geo.metadataContainer.get(SearchBusinessObjectMetadata.factory);
      //final metadata = geo.metadataContainer.get(SearchMetadata.factory);
      final dataPoint = geo!.geometry[0].asPoint();
      print("geo data ${dataPoint?.longitude}");
      if (searchMarkObg != null) {
        searchMarkObg!.removeTapListener(_mapObjectTapListener);
        mapWindow!.map.mapObjects.remove(searchMarkObg!);
      }

      var imageProvider = image.ImageProvider.fromImageProvider(
          const AssetImage('assets/mark.png'));
      final placemark = mapWindow!.map.mapObjects.addPlacemark()
        ..geometry = dataPoint!
        ..setIcon(imageProvider)
        ..addTapListener(_mapObjectTapListenerMyPose);
      mapWindow?.map.move(CameraPosition(
          Point(
              latitude: dataPoint!.latitude,
              longitude: dataPoint!.longitude),
          zoom: 19.0,
          azimuth: 150.0,
          tilt: 30.0));

      setState(() {
        _geoObjectTapListener.searchMarkObg = placemark;
        _geoObjectTapListener.listener = _mapObjectTapListener;
        searchMarkObg = placemark;
        uri = geo.metadataContainer
            .get(UriObjectMetadata.factory)
            ?.uris
            .firstOrNull;
      });

      print("uri $uri");

      if(geo.metadataContainer
          .get(GeoObjectSelectionMetadata.factory)!=null) {//всегда null,невозможно выбрать объект на карте из-за этого
        mapWindow!.map.selectGeoObject(geo.metadataContainer.get(GeoObjectSelectionMetadata.factory)!);
      }
    }, onSearchError: (Error error) {
      print("error search data");
      print(error);
    });
    final session = searchManager.submit(geometry, searchOptions, searchListener, text: text);
  }


  void searchPersonData(String text,MapWindow mapWindow,BuildContext context) {
    _mapObjectTapListenerMyPose = MapObjectTapListenerMyPos(mapWindow: mapWindow, context: context);//инициализир если еще не проинициализир в др функции
    print("SEARCH GEO DATA $text");
    GeoObject geo;
    final searchManager =
    SearchFactory.instance.createSearchManager(SearchManagerType.Online);

    final searchOptions = SearchOptions(
      geometry: true,
      searchTypes: SearchType.Geo,
      resultPageSize: 1,
    );
    final geometry = VisibleRegionUtils.toPolygon(mapWindow!.map.visibleRegion);
    final searchListener = SearchSessionSearchListener(onSearchResponse: (SearchResponse response) {
      print("geo data: ${response}");
      final res = response.collection.children
          .map((it) => it.asGeoObject())
          .whereType<GeoObject>().toList();
      geo = res.first;
      //final dataPoint = geo!.geometry[0].asPoint();
      //final metadata = geo.metadataContainer.get(SearchBusinessObjectMetadata.factory);
      final metadata = geo.metadataContainer.get(
          SearchToponymObjectMetadata.factory);
      final dataPoint = geo!.geometry[0].asPoint();
      if (searchMarkObg != null) {
        searchMarkObg!.removeTapListener(_mapObjectTapListener);
        mapWindow!.map.mapObjects.remove(searchMarkObg!);
      }

      var imageProvider = image.ImageProvider.fromImageProvider(
          const AssetImage('assets/mark.png'));
      final placemark = mapWindow!.map.mapObjects.addPlacemark()
        ..geometry = dataPoint!
        ..setIcon(imageProvider)
        ..addTapListener(_mapObjectTapListenerMyPose);
      mapWindow?.map.move(CameraPosition(
          Point(
              latitude: dataPoint!.latitude,
              longitude: dataPoint!.longitude),
          zoom: 15.0,
          azimuth: 150.0,
          tilt: 30.0));
      searchMarkObg = placemark;
      /*try{
        setState(() {
          _geoObjectTapListener.searchMarkObg = placemark;
          _geoObjectTapListener.listener = _mapObjectTapListener;
          searchMarkObg = placemark;
          uri = geo.metadataContainer
              .get(UriObjectMetadata.factory)
              ?.uris
              .firstOrNull;
        });
      }catch(e){}*/
      print("uri $uri");

     /* if(geo.metadataContainer
          .get(GeoObjectSelectionMetadata.factory)!=null) {//всегда null,невозможно выбрать объект на карте из-за этого
        mapWindow!.map.selectGeoObject(geo.metadataContainer.get(GeoObjectSelectionMetadata.factory)!);
      }*/
    }, onSearchError: (Error error) {
      print("error search data");
      print(error);
    });
    final session = searchManager.submit(geometry, searchOptions, searchListener, text: text);
  }



  Uri? uri;
  getObjectUri(){// поиск по юри
    GeoObject geo;
    final searchManager =
    SearchFactory.instance.createSearchManager(SearchManagerType.Online);

    final searchOptions = SearchOptions(
      geometry: true,
      searchTypes: SearchType.Geo,
      resultPageSize: 1,
    );
    final searchListener = SearchSessionSearchListener(onSearchResponse: (SearchResponse response) {
      final res =response.collection.children
          .map((it) => it.asGeoObject())
          .whereType<GeoObject>().toList();
      geo = res.first;
      //final dataPoint = geo!.geometry[0].asPoint();
      //final metadata = geo.metadataContainer.get(SearchBusinessObjectMetadata.factory);
      final metadata = geo.metadataContainer.get(SearchToponymObjectMetadata.factory);
      print(geo.name);
      print("geo data: ${metadata!.address!.formattedAddress}");
      print(geo.metadataContainer
          .get(GeoObjectSelectionMetadata.factory));

      //final metadata = geo.metadataContainer.get(SearchBusinessObjectMetadata.factory);
      //final metadata = geo.metadataContainer.get(SearchMetadata.factory);
      final dataPoint = geo!.geometry[0].asPoint();
      _mapWindow?.map.move(CameraPosition(
          Point(
              latitude: dataPoint!.latitude,
              longitude: dataPoint!.longitude),
          zoom: 17.0,
          azimuth: 150.0,
          tilt: 30.0));
      setState(() {
        uri = geo.metadataContainer.get(UriObjectMetadata.factory)?.uris.firstOrNull;
      });
      print("uri $uri");
      if(geo.metadataContainer
          .get(GeoObjectSelectionMetadata.factory)!=null) {//всегда null,невозможно выбрать объект на карте из-за этого
        _mapWindow!.map.selectGeoObject(geo.metadataContainer.get(GeoObjectSelectionMetadata.factory)!);
      }
    }, onSearchError: (Error error) {
      print(error);
    });
    final session1 = searchManager.resolveURI(searchOptions, searchListener, uri:uri!.value);
  }

  List<String> results = [];

//Выполнение запроса геосаджестов
  List<String>getGeoSuggest(String stringSearch){
    GeoObject geo;
    final searchManager = SearchFactory.instance.createSearchManager(SearchManagerType.Online);
    final suggestOptions = SuggestOptions(suggestTypes: SuggestType.Geo);
    final suggestSession = searchManager.createSuggestSession();
    final suggestListener = SearchSuggestSessionSuggestListener(onResponse: (SuggestResponse response) {
      final res =response.items
          .map((it) =>it.displayText!).toList();
      setState(() {
        results = res;
      });
    }, onError: (Error error) {
      print(error);
    });

    suggestSession.suggest(
      BoundingBox(_mapWindow!.map.visibleRegion.bottomLeft, _mapWindow!.map.visibleRegion.topRight),
      suggestOptions,
      suggestListener,
      text: stringSearch,
    );
    return results;
  }
  TextEditingController _controllerSuggest = TextEditingController();


  ////////current position/////////

  late MapObjectTapListener _mapObjectTapListenerMyPose;
  Future<void> _initLocationLayer(BuildContext context,MapWindow mapWindow) async {
    _mapObjectTapListenerMyPose = MapObjectTapListenerMyPos(mapWindow: mapWindow, context: context);
    final locationPermissionIsGranted =
    await Permission.location.request().isGranted;
    if (locationPermissionIsGranted) {
      final cur = await Geolocator.getCurrentPosition();
     /* Geolocator.getPositionStream().listen((event) {

      });*/
      mapWindow?.map.move(CameraPosition(
        //Point(latitude:curPos.latitude, longitude: curPos.longitude),
          Point(latitude:cur.latitude, longitude:cur.longitude),
          //  const Point(latitude: 55.75117144322471, longitude: 37.6311713796552),
          // Point(latitude: 55.751225, longitude: 37.629540),
          zoom: 11.0,
          azimuth: 150.0,
          tilt: 30.0));
      await GetIt.I<YandexCoderRepository>().getAddressByMyGeo(cur.latitude, cur.longitude, context);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Нет доступа к местоположению пользователя'),
          ),
        );
      });
    }
  }
  /////////маршруты////////////////


  createRoutes(MapWindow mapWindow){
    final drivingRouter = DirectionsFactory.
    instance.createDrivingRouter(DrivingRouterType.Combined);
    const drivingOptions = DrivingOptions(routesCount: 3);
    const vehicleOptions =
    DrivingVehicleOptions(vehicleType: DrivingVehicleType.Taxi);

    final points = [
      RequestPoint(const Point(latitude: 25.196141, longitude: 55.278543), RequestPointType.Waypoint, null, null),
      RequestPoint(const Point(latitude: 25.171148, longitude: 55.238034), RequestPointType.Waypoint, null, null),];

    final listener =
    DrivingSessionRouteListener(onDrivingRoutes: (List<DrivingRoute> routes) {
      //routes.first.geometry
      print("routes $routes");
      final randomPosition = PolylinePosition(segmentIndex: 2, segmentPosition: 0.2);

      final DrivingRoute route = routes.first;
      //route.getPosition(); только в платной версии

      print(route.metadataAt(randomPosition));///// КАК НАЙТИ POINT (КООРДИНАТЫ ДАННОЙ  ТОЧКИ НА МАРШРУТЕ)
      final polylineIndex = PolylineUtils.createPolylineIndex(route.geometry);
      final data = polylineIndex.closestPolylinePosition(Point(latitude: 25.196141, longitude: 55.278543), randomPosition, randomPosition,maxLocationBias: 1.0);
      //getRouteUri(route.metadataAt(randomPosition).uri!);
      final polylineObject =
      mapWindow.map.mapObjects.addPolylineWithGeometry(route.geometry);
      polylineObject
        ..strokeWidth = 5.0
        ..outlineWidth = 5.0
        ..outlineColor = Colors.red;
      /*for(var route in routes){
       final polylineObject =
       mapWindow.map.mapObjects.addPolylineWithGeometry(route.geometry);
       polylineObject
         ..strokeWidth = 5.0
         ..outlineWidth = 5.0
         ..outlineColor = Colors.red;
     }*/
    },
        onDrivingRoutesError: (Error error) {  });

    final drivingSession = drivingRouter.requestRoutes(
      drivingOptions,
      vehicleOptions,
      listener,
      points: points,
    );

  }

  getRouteUri(String ur){// поиск по юри
    GeoObject geo;
    final searchManager =
    SearchFactory.instance.createSearchManager(SearchManagerType.Online);

    final searchOptions = SearchOptions(
      geometry:true,
      searchTypes: SearchType.None,
      resultPageSize: 3,
    );
    final searchListener = SearchSessionSearchListener(onSearchResponse: (SearchResponse response) {
      final res =response.collection.children;
      //  .map((it) => it.asGeoObject())
      //.whereType<GeoObject>().toList();
      print(res);
      // geo = res.first;
      // final dataPoint = geo!.geometry[0].asPoint();
      //  print("PoSiTiOn::::::");
      //  print(dataPoint);
      /* _mapWindow?.map.move(CameraPosition(
          Point(
              latitude: dataPoint!.latitude,
              longitude: dataPoint!.longitude),
          zoom: 17.0,
          azimuth: 150.0,
          tilt: 30.0));*/
    }, onSearchError: (Error error) {
      print(error);
    });
    final session1 = searchManager.resolveURI(searchOptions, searchListener, uri:ur);
  }


  late Point userPosition;

  @override
  void initState() {
    mapkit.onStart();
    //_initLocationLayer();
    _controllerSuggest.text = widget.address;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    /*final bloc = context.watch<DataBloc>();
    _controllerSuggest.text = bloc.state is ChangeDataState?
    (bloc.state as ChangeDataState).data :'';*/
    // focusNode.unfocus();
    super.didChangeDependencies();
  }


  final focusNode = FocusNode();
  @override
  void dispose() {
    mapkit.onStop();
    focusNode.dispose();
    _mapWindow?.map.removeInputListener(_mapInputListener);
    _mapWindow?.map.removeTapListener(_geoObjectTapListener);
    _mapWindow?.map.removeCameraListener(_mapCameraListener);
    for (var element in placemarks) {
      element.removeTapListener(_mapObjectTapListener);
    }
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            /* Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  searchData("Набережная канала Грибоедова 13");
                  /*_mapWindow?.map.move(
                     CameraPosition(
                         Point(latitude: 59.935493, longitude: 30.327392),
                         zoom: 10.0,
                         azimuth: 150.0,
                         tilt: 30.0
                     )
                 );*/
                },
                child: Text("search geoObj")),
           ElevatedButton(onPressed:(){
             getObjectUri();
           }, child:Text("get obg uri"))
           /* ElevatedButton(
                onPressed: () {
                  print(geo!.name);
                  final dataPoint = geo!.geometry[0].asPoint();
                  _mapWindow?.map.move(CameraPosition(
                      Point(
                          latitude: dataPoint!.latitude,
                          longitude: dataPoint!.longitude),
                      zoom: 17.0,
                      azimuth: 150.0,
                      tilt: 30.0));
                  print("geo data");
                  print(geo);
                  print(geo.metadataContainer
                      .get(GeoObjectSelectionMetadata.factory));
                  if (geo != null) {
                    //  print(geo!.metadataContainer.get(GeoObjectSelectionMetadata.factory)!);
                    //_mapWindow!.map.selectGeoObject(geo!.metadataContainer.get(GeoObjectSelectionMetadata.factory)!);
                  }
                },
                child: Text('sel geo'))*/
          ],
        ),*/
            Row(
              children: [
                Expanded(child:TypeAheadField<String>(
                  focusNode: focusNode,
                  controller: _controllerSuggest,
                  //  inputType: TextInputType.streetAddress,
                  suggestionsCallback: (pattern) async {
                    print(pattern);
                    return getGeoSuggest(pattern);
                    return results
                        .where((s) => s.toLowerCase().contains(_controllerSuggest.text.toLowerCase()))
                        .toList();
                    //return [];
                  },
                  onSelected: (suggestion) {
                    if(suggestion==null) return;
                    _controllerSuggest.text = suggestion;
                    print(suggestion);
                  },
                  itemBuilder: (context, itemData) => ListTile(
                    title: Text(
                      itemData,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                          height: 1.2,fontSize: 17
                      ),
                    ),
                  ),
                )),
                const SizedBox(width:10,),
                ElevatedButton(onPressed:()async{
                  focusNode.unfocus();
                 searchData(_controllerSuggest.text,_mapWindow!);
                }, child:Icon(Icons.search))
              ],
            ),
            Expanded(child:YandexMap(onMapCreated: (mapWindow)async{
             //  _initLocationLayer(context,mapWindow);
              createRoutes(mapWindow);
              addListenerCameraPosition(mapWindow);
              addPlaceMarks(mapWindow,context);
              createPoligon(mapWindow);
              createPolyline(mapWindow);
              createCircle(mapWindow);
              getClusters(mapWindow,context);
              getGeoObg(mapWindow, context);
              searchPersonData(widget.address,mapWindow,context);
              //mapWindow.map.addInputListener(_mapInputListener);
              //final curPos = await Geolocator.getCurrentPosition();
              //print("CURRent Position:${curPos.latitude}");
              /*mapWindow?.map.move(CameraPosition(
                userPosition,
                //const Point(latitude: 25.196141, longitude: 55.278543),
                // Point(latitude:curPos.latitude, longitude: curPos.longitude),//for geoobjects
                // Point(latitude: 41.887064,
                //  longitude: 12.504809),

                 // Point(latitude: 59.937376, longitude: 30.33621),//for clusters
                  //  const Point(latitude: 55.75117144322471, longitude: 37.6311713796552),
                  // Point(latitude: 55.751225, longitude: 37.629540),
                  zoom: 5.0,
                  azimuth: 0.0,
                  tilt: 0.0));*/
              _mapWindow = mapWindow;
            }))
          ],
        ));
  }
}
