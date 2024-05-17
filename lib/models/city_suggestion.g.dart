// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RaiceSuggestion _$RaiceSuggestionFromJson(Map<String, dynamic> json) =>
    RaiceSuggestion(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      timeRange: (json['time_range'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      price: json['price'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RaiceSuggestionToJson(RaiceSuggestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'time_range': instance.timeRange,
      'price': instance.price,
    };

TicketsOffersList _$TicketsOffersListFromJson(Map<String, dynamic> json) =>
    TicketsOffersList(
      ticketsOffers: (json['tickets_offers'] as List<dynamic>?)
          ?.map((e) => RaiceSuggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TicketsOffersListToJson(TicketsOffersList instance) =>
    <String, dynamic>{
      'tickets_offers': instance.ticketsOffers,
    };
