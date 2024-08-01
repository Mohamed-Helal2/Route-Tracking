import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routetracking/service/location_service.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController? googleMapController;
  late LocationService locationService;
  bool isfirstcall = false;
  Set<Marker> markers = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        target: LatLng(30.022588668943467, 31.28486180995797), zoom: 12);
    locationService = LocationService();
    updatemylocation();
    super.initState();
  }

  void updatemylocation() async {
    await locationService.chechRequestLocationService();
    var haspermission = await locationService.chechRequestLocationPermissoin();
    if (haspermission) {
      locationService.getLocationData(
        (locationData) {
          LatLng latLng =
              LatLng(locationData.latitude!, locationData.longitude!);
          setCameraPosition(latLng);
          addmarker(latLng);
        },
      );
    }
  }

  void setCameraPosition(LatLng latlng) {
    if (isfirstcall) {
      CameraPosition cameraPosition = CameraPosition(target: latlng, zoom: 18);
      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    } else {
      googleMapController?.animateCamera(CameraUpdate.newLatLng(latlng));
    }
  }

  void addmarker(LatLng latlng) {
    Marker mymarker =
        Marker(markerId: MarkerId("First Marker"), position: latlng);
    markers.add(mymarker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("googlr map"),
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
        onMapCreated: (controller) {
          googleMapController = controller;
        },
      ),
    );
  }
}
