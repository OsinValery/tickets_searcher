import 'package:json_annotation/json_annotation.dart';

part 'musical_tour_suggestion.g.dart';

@JsonSerializable()
class Suggestion {
  const Suggestion({this.id, this.title, this.town, this.price});

  factory Suggestion.fromJson(Map<String, dynamic> json) =>
      _$SuggestionFromJson(json);

  final int? id;
  final String? title;
  final String? town;
  final Map? price;

  int get cost => price?["value"] ?? 0;

  Map<String, dynamic> toJson() => _$SuggestionToJson(this);
}

@JsonSerializable()
class Offers {
  const Offers({this.offers});

  factory Offers.fromJson(Map<String, dynamic> json) => _$OffersFromJson(json);

  Map<String, dynamic> toJson() => _$OffersToJson(this);

  final List<Suggestion>? offers;
}
