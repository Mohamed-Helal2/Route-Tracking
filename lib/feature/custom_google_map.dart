import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routetracking/core/Service/location_service.dart';
import 'package:routetracking/core/Service/places_service.dart';
import 'package:routetracking/core/widget/custom_text_form_field.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  late LocationService locationService;
  late PlacesService placesService;
  bool isfirstcall = false;
  Set<Marker> markers = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
        target: LatLng(30.022588668943467, 31.28486180995797), zoom: 1);
    locationService = LocationService();
    placesService = PlacesService();

    super.initState();
  }

  void updatemylocation() async {
    try {
      var locationData = await locationService.getlocation();
      LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
      setCameraPosition(latLng);
      addmarker(latLng);
    } on LocationServiceException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      // TODO
    } catch (e) {
      print(e);
    }
  }

  void setCameraPosition(LatLng latlng) {
    CameraPosition cameraPosition = CameraPosition(target: latlng, zoom: 18);
    googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void addmarker(LatLng latlng) {
    Marker mymarker = Marker(
      markerId: MarkerId("First Marker"),
      position: latlng,
    );
    markers.add(mymarker);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              onMapCreated: (controller) {
                googleMapController = controller;
                updatemylocation();
              },
            ),
            const Positioned(
              top: 16,
              left: 10,
              right: 10,
              child: AppTextFormField(
                hintText: "Search here",
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                suffixIcon: Icon(
                  Icons.mic,
                  size: 35,
                ),
                preficicon: Icon(
                  Icons.map_sharp,
                  size: 35,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 3,
              left: 3,
              child: MaterialButton(
                onPressed: () {
                  print(
                      "--- ${placesService.getpredictions(input: 'fdfdgweferf')}");
                },
                child: Text('Search'),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
