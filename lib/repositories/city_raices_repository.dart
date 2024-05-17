import 'package:dio/dio.dart';

import '../api/city_tour_suggestion_api.dart';
import '../models/city_suggestion.dart';

class CityRaicesRepository {
  CityRaicesRepository({CityRaicesSuggestionsRestClient? rest}) {
    this.rest = rest ?? CityRaicesSuggestionsRestClient(Dio());
  }

  CityRaicesSuggestionsRestClient? rest;
  List<RaiceSuggestion>? _cache;

  Future<List<RaiceSuggestion>> getSuggestions() async {
    _cache ??= (await rest?.getSuggestions())?.ticketsOffers;
    return _cache ?? [];
  }
}
