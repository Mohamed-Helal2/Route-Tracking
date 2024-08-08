import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:routetracking/core/networking/api_constant.dart';
import 'package:routetracking/core/networking/dio_consumer.dart';
import 'package:routetracking/model/place_details_model/place_details_model.dart';
import 'package:routetracking/model/places_autocomplete_model/places_autocomplete_model.dart';
import 'package:routetracking/model/places_autocomplete_model/prediction.dart';

class PlacesService {
  DioConsumer dioConsumer = DioConsumer(dio: Dio());

  Future<Either<PlacesAutocompleteModel, List<Prediction>>> getpredictions({
    required String input,
    required String sessionToken
  }) async {
    final response = await dioConsumer.get(ApiConstants.placeautocomplete,
        queryparams: {"input": input,
        'sessiontoken':sessionToken,
        "key": ApiConstants.apiKey});
    PlacesAutocompleteModel placesAutocompleteModel =
        PlacesAutocompleteModel.fromJson(response);
    if (placesAutocompleteModel.status == 'OK') {
      List<Prediction> prediction =
          placesAutocompleteModel.predictions!.toList();
      print("---- ${placesAutocompleteModel.status}");
      return right(prediction);
    }
    return left(placesAutocompleteModel);
  }

  Future<PlaceDetailsModel> getPlaceDetails({required String placeid}) async {
    final response = await dioConsumer.get(ApiConstants.placedetails,
        queryparams: {'key': ApiConstants.apiKey, 'place_id': placeid});
    PlaceDetailsModel placeDetailsModel = PlaceDetailsModel.fromJson(response);
    return placeDetailsModel;
  }
}
