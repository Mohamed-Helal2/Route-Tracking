import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<bool> chechRequestLocationService() async {
    var isserviceenabled = await location.serviceEnabled();
    if (!isserviceenabled) {
      isserviceenabled = await location.requestService();
      if (!isserviceenabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> chechRequestLocationPermissoin() async {
    var permissionstatus = await location.hasPermission();
    if (permissionstatus == PermissionStatus.deniedForever) {
      return false;
    }
    if (permissionstatus == PermissionStatus.denied) {
      permissionstatus = await location.requestPermission();
      return permissionstatus == PermissionStatus.granted;
    }
    return true;
  }

  void getLocationData(
    void Function(LocationData)? onData,
  ) {
    location.changeSettings(distanceFilter: 40);
    location.onLocationChanged.listen(onData);
  }
}
