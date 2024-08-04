part of 'googlemap_cubit.dart';

@immutable
sealed class GooglemapState {}

final class GooglemapInitial extends GooglemapState {}
final class addmarkersucess extends GooglemapState {}

final class placeloading extends GooglemapState {}

final class placesucess extends GooglemapState {
  final List<Prediction> prediction;
  placesucess({required this.prediction});
}

final class placefailure extends GooglemapState {
  final  PlacesAutocompleteModel placeauto;
  placefailure({required this.placeauto});
  
}
final class teststate extends GooglemapState {}

