import "package:json_annotation/json_annotation.dart";
part "city_suggestion.g.dart";

@JsonSerializable(fieldRename: FieldRename.snake)
class RaiceSuggestion {
  const RaiceSuggestion({this.id, this.title, this.timeRange, this.price});

  factory RaiceSuggestion.fromJson(Map<String, dynamic> json) =>
      _$RaiceSuggestionFromJson(json);

  final int? id;
  final String? title;
  final List<String>? timeRange;
  final Map? price;

  int get cost => price?["value"] ?? 0;
  String get timesLine {
    String result = "";
    if (timeRange != null) {
      for (var time in timeRange!) {
        result += "$time   ";
      }
    }
    return result;
  }

  Map<String, dynamic> toJson() => _$RaiceSuggestionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class TicketsOffersList {
  const TicketsOffersList({this.ticketsOffers});

  factory TicketsOffersList.fromJson(Map<String, dynamic> json) {
    return _$TicketsOffersListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketsOffersListToJson(this);

  final List<RaiceSuggestion>? ticketsOffers;
}
