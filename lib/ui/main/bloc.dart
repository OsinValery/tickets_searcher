import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_searcher/models/city_suggestion.dart';
import 'package:tickets_searcher/models/tickets.dart';
import 'package:tickets_searcher/repositories/city_raices_repository.dart';
import 'package:tickets_searcher/repositories/musical_tour_repository.dart';
import 'package:tickets_searcher/sources/strings_cashe.dart';

import "package:tickets_searcher/models/musical_tour_suggestion.dart"
    as musical_tours;

import '../../repositories/tickets_list_repository.dart';

part 'events_and_states.dart';

class MainScreenBloc extends Bloc<BlocEvent, BlocState> {
  int currentPage = 0;
  String destination = "";
  String departure = "";
  DateTime selectedTime = DateTime.now();
  DateTime? returnTime;
  var stage = NavigationStage.withoutDestination;

  final _musicalSuggestionRepository = MusicalTourRepository();
  final _cityToursRepository = CityRaicesRepository();
  final _ticketsRepository = TicketsRepository();

  MainScreenBloc() : super(InitialState()) {
    Future.delayed(const Duration(milliseconds: 1),
        () => add(SelectPageEvent(currentPage)));

    on<SelectPageEvent>(_onChangePage);
    on<ChangeFromCity>(_onChangeFromCity);
    on<DestinationChangedEvent>(_onDestinationChanged);
    on<FinishDestinationEnteringEvent>(_onFinishDestinationEntering);
    on<SeeTicketsEvent>(_onSeeTickestList);
    on<GoBackEvent>(_onGoBack);
    on<WorkNewStageEvent>(_getDataForPageEvent);
    on<WayPointsExchange>(_onWayPointsExchange);
    on<PickFromDateEvent>(_onPickFromTime);
    on<PickToDateEvent>(_onPickToTime);
    on<FinishDepartureEntering>(_onFinishDepartureEntering);

    StringsCashe.getFromCity().then((value) => departure = value);
  }

  _onChangePage(SelectPageEvent event, emitter) {
    currentPage = event.page;
    emitter(SelectPageState(currentPage));
    if (currentPage == 0) {
      emitter(ChangePageStageState(stage));
      add(WorkNewStageEvent());
    }
  }

  _onChangeFromCity(ChangeFromCity event, _) {
    StringsCashe.saveFromCity(event.city);
    departure = event.city;
  }

  _onDestinationChanged(DestinationChangedEvent event, _) {
    destination = event.text;
  }

  _onFinishDestinationEntering(event, emitter) {
    if (destination.isNotEmpty) {
      if (departure.isNotEmpty) stage = NavigationStage.showDestination;
      emitter(ChangePageStageState(stage));
      add(WorkNewStageEvent());
    }
  }

  _onSeeTickestList(event, emitter) async {
    stage = NavigationStage.showTickets;
    emitter(ChangePageStageState(stage));
    add(WorkNewStageEvent());
  }

  void _onGoBack(event, emitter) {
    if (stage == NavigationStage.showTickets) {
      stage = NavigationStage.showDestination;
    } else if (stage == NavigationStage.showDestination) {
      stage = NavigationStage.withoutDestination;
    }
    emitter(ChangePageStageState(stage));
    add(WorkNewStageEvent());
  }

  void _getDataForPageEvent(event, emitter) async {
    await Future.delayed(const Duration(milliseconds: 16));
    switch (stage) {
      case NavigationStage.showTickets:
        emitter(TourInfoState(departure, destination, selectedTime));
        var tickets = await _ticketsRepository.getSuggestions();
        emitter(UpdateTicketsListState(tickets));
        break;
      case NavigationStage.showDestination:
        emitter(SetWayPointsState(departure, destination));
        var suggestions = await _cityToursRepository.getSuggestions();
        emitter(UpdateRaicesListState(suggestions));
        break;
      case NavigationStage.withoutDestination:
        var musicalSuggestions =
            await _musicalSuggestionRepository.getMusicalSuggestions();
        emitter(UpdateMusicalToursState(musicalSuggestions));
        break;
    }
  }

  _onWayPointsExchange(event, emitter) {
    String tmp = destination;
    destination = departure;
    departure = tmp;
    emitter(SetWayPointsState(departure, destination));
  }

  _onPickFromTime(PickFromDateEvent event, Emitter emitter) {
    returnTime = event.time ?? returnTime;
    emitter(RaiseTimeState(selectedTime, returnTime));
  }

  _onPickToTime(PickToDateEvent event, Emitter emitter) {
    if (event.time == null) return;
    selectedTime = event.time!;
    emitter(RaiseTimeState(selectedTime, returnTime));
  }

  _onFinishDepartureEntering(event, Emitter emitter) {
    add(FinishDestinationEnteringEvent());
  }
}

enum NavigationStage {
  withoutDestination,
  showDestination,
  showTickets,
}
