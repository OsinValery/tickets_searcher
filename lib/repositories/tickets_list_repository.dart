import 'package:dio/dio.dart';
import 'package:tickets_searcher/api/tickets_list_api.dart';
import 'package:tickets_searcher/models/tickets.dart';

class TicketsRepository {
  TicketsRepository({TicketsListRestClient? rest}) {
    this.rest = rest ?? TicketsListRestClient(Dio());
  }

  TicketsListRestClient? rest;
  List<Ticket>? _cache;

  Future<List<Ticket>> getSuggestions() async {
    _cache ??= (await rest?.getSuggestions())?.tickets;
    return _cache ?? [];
  }
}
