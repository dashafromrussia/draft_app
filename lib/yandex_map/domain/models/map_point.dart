class MapPoint {
  const MapPoint(
      {required this.name,
        required this.latitude,
        required this.longitude,
        required this.img,
        required this.desc});

  final String desc;

  /// Название населенного пункта
  final String name;

  /// Широта
  final double latitude;

  /// Долгота
  final double longitude;

  final String img;
}