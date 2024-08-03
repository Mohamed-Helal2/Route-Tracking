import 'package:dio/dio.dart';
import 'package:routetracking/core/networking/api_constant.dart';
import 'package:routetracking/core/networking/dio_consumer.dart';
import 'package:routetracking/model/places_autocomplete_model/places_autocomplete_model.dart';
import 'package:routetracking/model/places_autocomplete_model/prediction.dart';

class PlacesService {
  DioConsumer dioConsumer = DioConsumer(dio: Dio());

  Future<List<Prediction>> getpredictions({
    required String input,
  }) async {
    final response = await dioConsumer.get('autocomplete/json',
        queryparams: {"input": input, "key": ApiConstants.ApiKey});
    PlacesAutocompleteModel placesAutocompleteModel =
        PlacesAutocompleteModel.fromJson(response);
    List<Prediction> prediction = placesAutocompleteModel.predictions!.toList();
     print("---- ${placesAutocompleteModel.status}");
    return prediction;
  }
}
