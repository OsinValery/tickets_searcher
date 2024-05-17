import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/city_suggestion.dart';

part 'city_tour_suggestion_api.g.dart';

@RestApi(
    baseUrl: 'https://run.mocky.io/v3/7e55bf02-89ff-4847-9eb7-7d83ef884017')
abstract class CityRaicesSuggestionsRestClient {
  factory CityRaicesSuggestionsRestClient(Dio dio, {String baseUrl}) =
      _CityRaicesSuggestionsRestClient;

  @GET('/')
  Future<TicketsOffersList> getSuggestions();
}
