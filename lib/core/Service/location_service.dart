import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> chechRequestLocationService() async {
    var isserviceenabled = await location.serviceEnabled();
    if (!isserviceenabled) {
      isserviceenabled = await location.requestService();
      if (!isserviceenabled) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> chechRequestLocationPermissoin() async {
    var permissionstatus = await location.hasPermission();
    if (permissionstatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permissionstatus == PermissionStatus.denied) {
      permissionstatus = await location.requestPermission();
      if (permissionstatus != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  void RealTimeLocationData(
    void Function(LocationData)? onData,
  ) async {
    await chechRequestLocationService();
    await chechRequestLocationPermissoin();
    location.changeSettings(distanceFilter: 40);
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getlocation() async {
    await chechRequestLocationService();
    await chechRequestLocationPermissoin();
    LocationData locationData = await location.getLocation();
    return locationData;
  }
}

class LocationServiceException implements Exception {}
class LocationPermissionException implements Exception {}
