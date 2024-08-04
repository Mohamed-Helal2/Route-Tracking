import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:routetracking/core/Service/location_service.dart';
import 'package:routetracking/core/Service/places_service.dart';
import 'package:routetracking/model/places_autocomplete_model/prediction.dart';

import '../../../../model/places_autocomplete_model/places_autocomplete_model.dart';

part 'googlemap_state.dart';

class GooglemapCubit extends Cubit<GooglemapState> {
  GooglemapCubit() : super(GooglemapInitial());
  CameraPosition initialCameraPosition = const CameraPosition(
      target: LatLng(30.022588668943467, 31.28486180995797), zoom: 1);
  PlacesService placesService = PlacesService();
  LocationService locationService = LocationService();
  TextEditingController textEditingController = TextEditingController();
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  List<Prediction> prediction_resulrt = [];
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
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void addmarker(LatLng latlng) {
    Marker mymarker = Marker(
      markerId: MarkerId("First Marker"),
      position: latlng,
    );
    markers.add(mymarker);
    emit(addmarkersucess());
  }

  getprediction() async {
    clearPredictions();
    emit(placeloading());
    final response =
        await placesService.getpredictions(input: textEditingController.text);
    response.fold(
      (l) {
        clearPredictions();
        emit(placefailure(placeauto: l));
      },
      (r) {
        prediction_resulrt.addAll(r);
        emit(placesucess(prediction: r));
      },
    );
  }

  void clearPredictions() {
    prediction_resulrt.clear();
    emit(placesucess(prediction: [])); // Emit an empty list to update the UI
  }
}
