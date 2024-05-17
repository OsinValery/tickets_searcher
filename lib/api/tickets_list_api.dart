import "package:dio/dio.dart";
import 'package:retrofit/retrofit.dart';
import 'package:tickets_searcher/models/tickets.dart';

part "tickets_list_api.g.dart";

@RestApi(
    baseUrl: 'https://run.mocky.io/v3/670c3d56-7f03-4237-9e34-d437a9e56ebf')
abstract class TicketsListRestClient {
  factory TicketsListRestClient(Dio dio, {String baseUrl}) =
      _TicketsListRestClient;

  @GET('/')
  Future<TicketsList> getSuggestions();
}
