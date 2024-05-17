import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/musical_tour_suggestion.dart';

part 'musical_suggestions_tour_api.g.dart';

@RestApi(
    baseUrl: 'https://run.mocky.io/v3/214a1713-bac0-4853-907c-a1dfc3cd05fd')
abstract class MusicalSuggestionsRestClient {
  factory MusicalSuggestionsRestClient(Dio dio, {String baseUrl}) =
      _MusicalSuggestionsRestClient;

  @GET('/')
  Future<Offers> getSuggestions();
}
