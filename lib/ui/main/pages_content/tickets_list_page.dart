import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_searcher/models/tickets.dart';
import 'package:tickets_searcher/ui/main/bloc.dart';

class TicketsListPage extends StatelessWidget {
  const TicketsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<MainScreenBloc, BlocState>(
            buildWhen: (previous, current) => current is TourInfoState,
            builder: (context, state) {
              return Container(
                color: Colors.green,
                width: double.infinity,
                height: 60,
                child: (state is! TourInfoState)
                    ? null
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<MainScreenBloc>().add(GoBackEvent());
                            },
                            icon: const Icon(Icons.arrow_left),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("${state.departure} - ${state.destination}"),
                              Text(
                                '${state.time.day} ${monthConverter(state.time.month)}',
                              ),
                            ],
                          )
                        ],
                      ),
              );
            },
          ),
          const Text("tickets from api"),
          BlocBuilder<MainScreenBloc, BlocState>(
            buildWhen: (previous, current) => current is UpdateTicketsListState,
            builder: (context, state) {
              if (state is! UpdateTicketsListState) return Container();
              return Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...state.tickets.map((e) => TicketView(ticket: e))
                  ],
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}

class TicketView extends StatelessWidget {
  const TicketView({super.key, required this.ticket});

  final Ticket ticket;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Text('bla'),
    );
  }
}

String monthConverter(int month) {
  return switch (month - 1) {
    0 => "Января",
    1 => "Февраля",
    2 => "Марта",
    3 => "Апреля",
    4 => "Мая",
    5 => "Июня",
    6 => "Июля",
    7 => "Августа",
    8 => "Сентября",
    9 => "Октября",
    10 => "Ноября",
    11 => "Декабря",
    _ => "unknown"
  };
}
