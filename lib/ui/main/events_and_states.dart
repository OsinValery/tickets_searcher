part of 'bloc.dart';

abstract class BlocState {}

abstract class BlocEvent {}

// ----------------------------------------
//  states
// ----------------------------------------

class InitialState extends BlocState {}

class SelectPageState extends BlocState {
  SelectPageState(this.page);
  int page;
}

class UpdateMusicalToursState extends BlocState {
  UpdateMusicalToursState(this.suggestions);
  List<musical_tours.Suggestion> suggestions;
}

class ChangePageStageState extends BlocState {
  ChangePageStageState(this.stage);
  NavigationStage stage;
}

class TourInfoState extends BlocState {
  TourInfoState(this.departure, this.destination, this.time);
  String destination;
  String departure;
  DateTime time;
}

class UpdateTicketsListState extends BlocState {
  UpdateTicketsListState(this.tickets);
  List<Ticket> tickets;
}

class UpdateRaicesListState extends BlocState {
  UpdateRaicesListState(this.raices);
  List<RaiceSuggestion> raices;
}

class SetWayPointsState extends BlocState {
  SetWayPointsState(this.departure, this.destination);
  String destination;
  String departure;
}

// ----------------------------------------
//  events
// ----------------------------------------

class SelectPageEvent extends BlocEvent {
  SelectPageEvent(this.page);
  int page;
}

class ChangeFromCity extends BlocEvent {
  ChangeFromCity(this.city);
  String city;
}

class DestinationChangedEvent extends BlocEvent {
  DestinationChangedEvent(this.text);
  String text;
}

class FinishDestinationEnteringEvent extends BlocEvent {}

class SeeTicketsEvent extends BlocEvent {}

class GoBackEvent extends BlocEvent {}

class WorkNewStageEvent extends BlocEvent {}

class WayPointsExchange extends BlocEvent {}
