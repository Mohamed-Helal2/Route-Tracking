class LocationInfoModel {
  final LocationModel locationModel;

  LocationInfoModel({required this.locationModel});

  factory LocationInfoModel.fromJson(Map<String, dynamic> json) {
    return LocationInfoModel(
      locationModel: LocationModel.fromjson(json['location']),
    );
  }
   Map<String, dynamic> toJson() {
    return {
      'location': locationModel.toJson(),
    };
  }
}
class LocationModel {
  final LatlngModel latlngModel;

  LocationModel({required this.latlngModel});
  factory LocationModel.fromjson(Map<String, dynamic> json) {
    return LocationModel(
      latlngModel: LatlngModel.fromjson(json['location']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'latLng': latlngModel.toJson(),
    };
  }
}

class LatlngModel {
  final double latitude;
  final double longitude;

  LatlngModel({required this.latitude, required this.longitude});
  factory LatlngModel.fromjson(Map<String, double> json) {
    return LatlngModel(
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double);
  }
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
