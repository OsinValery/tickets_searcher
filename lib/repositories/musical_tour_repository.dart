import 'package:dio/dio.dart';
import 'package:tickets_searcher/api/musical_suggestions_tour_api.dart';
import 'package:tickets_searcher/models/musical_tour_suggestion.dart';

class MusicalTourRepository {
  MusicalTourRepository({MusicalSuggestionsRestClient? rest}) {
    this.rest = rest ?? MusicalSuggestionsRestClient(Dio());
  }

  MusicalSuggestionsRestClient? rest;
  List<Suggestion>? _cache;

  Future<List<Suggestion>> getMusicalSuggestions() async {
    _cache ??= (await rest?.getSuggestions())?.offers;
    return _cache ?? [];
  }
}
