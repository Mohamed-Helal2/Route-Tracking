class MatchedSubstring {
  final int? length;
  final int? offset;
  MatchedSubstring({this.length, this.offset});

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) {
    return MatchedSubstring(length: json['length'], offset: json['offset']);
  }

  Map<String, dynamic> toJson() => {
        'length': length,
        'offset': offset,
      };
}
