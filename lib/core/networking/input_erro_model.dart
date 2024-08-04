class InputErroModel {
  List? predictions;
  String? status;
  InputErroModel({this.predictions, this.status});

  factory InputErroModel.fromjson(Map<String, dynamic> json) {
    return InputErroModel(
        predictions: json['predictions'], status: json['status']);
  }
  Map<String, dynamic> toJson() => {
				'predictions': predictions?.map((e) => e.toJson()).toList(),
				'status': status,
			};
}
