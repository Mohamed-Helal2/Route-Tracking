import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:routetracking/core/Service/location_service.dart';
import 'package:routetracking/core/Service/places_service.dart';
import 'package:routetracking/core/helper/douce.dart';
import 'package:routetracking/model/places_autocomplete_model/prediction.dart';
import 'package:uuid/uuid.dart';

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
  final debouncer = Debouncer(delay: const Duration(milliseconds: 1000));
  Uuid uuid = const Uuid();
  String fe = const Uuid().v4();

  void updatemylocation() async {
    try {
      var locationData = await locationService.getlocation();
      LatLng latLng = LatLng(locationData.latitude!, locationData.longitude!);
      setCameraPosition(latLng, 15);
      addmarker(latLng);
    } on LocationServiceException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      // TODO
    } catch (e) {
      print(e);
    }
  }

  void setCameraPosition(LatLng latlng, double zoom) {
    CameraPosition cameraPosition = CameraPosition(target: latlng, zoom: zoom);
    googleMapController
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void addmarker(LatLng latlng) {
    Marker mymarker = Marker(
      markerId: const MarkerId("First Marker"),
      position: latlng,
    );
    markers.add(mymarker);
    emit(addmarkersucess());
  }

  getprediction() async {
    clearPredictions();
    emit(placeloading());
    final response = await placesService.getpredictions(
        input: textEditingController.text, sessionToken: fe);
    response.fold(
      (l) {
        //clearPredictions();
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

  Future<void> updatetonewsearchlocation({required String placeid}) async {
    clearPredictions();
    textEditingController.clear();
    emit(placeDetailsLoading());

    final response = await placesService.getPlaceDetails(placeid: placeid);
    LatLng latLng = LatLng(response.result!.geometry!.location!.lat!,
        response.result!.geometry!.location!.lng!);
    await updatesearchlocation(latLng: latLng);
    fe = uuid.v4();
    emit(placeDetailsSucess());
  }

  Future<void> updatesearchlocation({required LatLng latLng}) async {
    try {
      setCameraPosition(latLng, 12);
      addmarker(latLng);
      clearPredictions();
    } on LocationServiceException catch (e) {
      // TODO
    } on LocationPermissionException catch (e) {
      // TODO
    } catch (e) {
      print(e);
    }
  }
}
