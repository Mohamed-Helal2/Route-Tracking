import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routetracking/core/networking/api_constant.dart';
import 'package:routetracking/core/networking/dio_consumer.dart';
import 'package:routetracking/model/location_info_model/location_info_mode.dart';
import 'package:routetracking/model/routes_model/routes_model.dart';

class RoutesService {
  DioConsumer dioConsumer = DioConsumer(dio: Dio());
  PolylinePoints polylinePoints = PolylinePoints();

  final Map<String, dynamic> headers = {
    'Content-Type': 'application/json',
    'X-Goog-Api-Key': ApiConstants.apiKey,
    'X-Goog-FieldMask':
        'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline'
  };

  Map body0(
      {required LocationInfoModel origin,
      required LocationInfoModel destination}) {
    return {
      "origin": origin.toJson(),
      "destination": destination.toJson(),
      "travelMode": "DRIVE",
      "routingPreference": "TRAFFIC_AWARE",
      "computeAlternativeRoutes": false,
      "routeModifiers": {
        "avoidTolls": false,
        "avoidHighways": false,
        "avoidFerries": false
      },
      "languageCode": "en-US",
      "units": "IMPERIAL"
    };
  }
Set<Polyline> polyline = {};
List<LatLng> points = [];
  Future<Either<String, RoutesModel>> getRoutes(
      {required LocationInfoModel origin,
      required LocationInfoModel destination}) async {
    try {
      final response = await dioConsumer.post(
        ApiConstants.routesapi,
        options: Options(
          headers: headers,
        ),
        data: body0(origin: origin, destination: destination),
      );
      RoutesModel routesModel = RoutesModel.fromJson(response);
      return right(routesModel);
    } catch (e) {
      return left("$e");
    }

    //return routesModel;
  }

  
  Future<List<LatLng>> getrouteData(
      {required String polypoints,
      required GoogleMapController googleMapController}) async {
    List<PointLatLng> result = polylinePoints.decodePolyline(polypoints);
    List<LatLng> latLngPoints = result
        .map(
          (e) => LatLng(e.latitude, e.longitude),
        )
        .toList();
    points = latLngPoints;
    setCameraBoubds(googleMapController);
    displayroute(points: latLngPoints);

    return latLngPoints;
  }

  
  displayroute({required List<LatLng> points}) {
    Polyline route = Polyline(
      polylineId: const PolylineId('1'),
      points: points,
      width: 5,
      color: Colors.blue,
      patterns: [
        PatternItem.dash(30),
        PatternItem.gap(10),
      ],
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
    );
    polyline.add(route);
  }

  LatLngBounds getLagLngBounds() {
    var southwestlatitude = points.first.latitude; // min
    var southwestlongtitude = points.first.longitude; // min

    var nourtheastlatitude = points.first.latitude; // max
    var nourtheastLongtitude = points.first.longitude; // max

    for (var point in points) {
      if (point.latitude < southwestlatitude) {
        southwestlatitude = point.latitude;
      }

      if (point.longitude < southwestlongtitude) {
        southwestlongtitude = point.longitude;
      }

      if (point.latitude > nourtheastlatitude) {
        nourtheastlatitude = point.latitude;
      }

      if (point.longitude > nourtheastLongtitude) {
        nourtheastLongtitude = point.longitude;
      }
    }
    LatLngBounds latLngBounds = LatLngBounds(
        southwest: LatLng(southwestlatitude, southwestlongtitude),
        northeast: LatLng(nourtheastlatitude, nourtheastLongtitude));
    return latLngBounds;
  }

  void setCameraBoubds(GoogleMapController? googleMapController) {
    LatLngBounds latLngBounds = getLagLngBounds();
    googleMapController
        ?.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 50));
  }
}
