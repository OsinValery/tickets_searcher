// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'musical_tour_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suggestion _$SuggestionFromJson(Map<String, dynamic> json) => Suggestion(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      town: json['town'] as String?,
      price: json['price'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$SuggestionToJson(Suggestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'town': instance.town,
      'price': instance.price,
    };

Offers _$OffersFromJson(Map<String, dynamic> json) => Offers(
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => Suggestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OffersToJson(Offers instance) => <String, dynamic>{
      'offers': instance.offers,
    };
