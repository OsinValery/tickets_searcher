import "package:json_annotation/json_annotation.dart";

part "tickets.g.dart";

@JsonSerializable(fieldRename: FieldRename.snake)
class Ticket {
  const Ticket({
    this.id,
    this.badge,
    this.price,
    this.company,
    this.providerName,
    this.hasTransfer,
    this.hasVisaTransfer,
    this.isExchangable,
    this.isReturnable,
    this.handLuggage,
    this.luggage,
    this.arrival,
    this.departure,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  final int? id;
  final String? badge;
  final String? providerName;
  final String? company;
  final Map? price;
  final bool? hasTransfer;
  final bool? hasVisaTransfer;
  final bool? isReturnable;
  final bool? isExchangable;
  final HandLuggage? handLuggage;
  final Luggage? luggage;
  final WayPoint? arrival;
  final WayPoint? departure;

  int get cost => price?["value"] ?? 0;

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}

@JsonSerializable()
class TicketsList {
  const TicketsList({this.tickets});

  factory TicketsList.fromJson(Map<String, dynamic> json) {
    return _$TicketsListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$TicketsListToJson(this);

  final List<Ticket>? tickets;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class HandLuggage {
  const HandLuggage({
    this.size,
    this.hasHandLuggage,
  });

  final String? size;
  final bool? hasHandLuggage;

  factory HandLuggage.fromJson(json) => _$HandLuggageFromJson(json);
  Map<String, dynamic> toJson() => _$HandLuggageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.screamingSnake)
class Luggage {
  const Luggage({
    this.hasLuggage,
    this.price,
  });

  final Map? price;
  final bool? hasLuggage;

  factory Luggage.fromJson(json) => _$LuggageFromJson(json);
  Map<String, dynamic> toJson() => _$LuggageToJson(this);

  int get cost => price?['value'] ?? 0;
}

@JsonSerializable()
class WayPoint {
  const WayPoint({this.airport, this.date, this.town});

  final String? town;
  final String? date;
  final String? airport;

  factory WayPoint.fromJson(json) => _$WayPointFromJson(json);
  Map<String, dynamic> toJson() => _$WayPointToJson(this);
}
