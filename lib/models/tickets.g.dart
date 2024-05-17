// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tickets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: (json['id'] as num?)?.toInt(),
      badge: json['badge'] as String?,
      price: json['price'] as Map<String, dynamic>?,
      company: json['company'] as String?,
      providerName: json['provider_name'] as String?,
      hasTransfer: json['has_transfer'] as bool?,
      hasVisaTransfer: json['has_visa_transfer'] as bool?,
      isExchangable: json['is_exchangable'] as bool?,
      isReturnable: json['is_returnable'] as bool?,
      handLuggage: json['hand_luggage'] == null
          ? null
          : HandLuggage.fromJson(json['hand_luggage']),
      luggage:
          json['luggage'] == null ? null : Luggage.fromJson(json['luggage']),
      arrival:
          json['arrival'] == null ? null : WayPoint.fromJson(json['arrival']),
      departure: json['departure'] == null
          ? null
          : WayPoint.fromJson(json['departure']),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'badge': instance.badge,
      'provider_name': instance.providerName,
      'company': instance.company,
      'price': instance.price,
      'has_transfer': instance.hasTransfer,
      'has_visa_transfer': instance.hasVisaTransfer,
      'is_returnable': instance.isReturnable,
      'is_exchangable': instance.isExchangable,
      'hand_luggage': instance.handLuggage,
      'luggage': instance.luggage,
      'arrival': instance.arrival,
      'departure': instance.departure,
    };

TicketsList _$TicketsListFromJson(Map<String, dynamic> json) => TicketsList(
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => Ticket.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketsListToJson(TicketsList instance) =>
    <String, dynamic>{
      'tickets': instance.tickets,
    };

HandLuggage _$HandLuggageFromJson(Map<String, dynamic> json) => HandLuggage(
      size: json['size'] as String?,
      hasHandLuggage: json['has_hand_luggage'] as bool?,
    );

Map<String, dynamic> _$HandLuggageToJson(HandLuggage instance) =>
    <String, dynamic>{
      'size': instance.size,
      'has_hand_luggage': instance.hasHandLuggage,
    };

Luggage _$LuggageFromJson(Map<String, dynamic> json) => Luggage(
      hasLuggage: json['HAS_LUGGAGE'] as bool?,
      price: json['PRICE'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$LuggageToJson(Luggage instance) => <String, dynamic>{
      'PRICE': instance.price,
      'HAS_LUGGAGE': instance.hasLuggage,
    };

WayPoint _$WayPointFromJson(Map<String, dynamic> json) => WayPoint(
      airport: json['airport'] as String?,
      date: json['date'] as String?,
      town: json['town'] as String?,
    );

Map<String, dynamic> _$WayPointToJson(WayPoint instance) => <String, dynamic>{
      'town': instance.town,
      'date': instance.date,
      'airport': instance.airport,
    };
