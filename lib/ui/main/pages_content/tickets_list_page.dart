import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_searcher/models/tickets.dart';
import 'package:tickets_searcher/ui/main/bloc.dart';

class TicketsListPage extends StatelessWidget {
  const TicketsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                color: theme.colorScheme.surface,
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          context.read<MainScreenBloc>().add(GoBackEvent()),
                      icon: Image.asset("assets/icons/left.png"),
                    ),
                    BlocBuilder<MainScreenBloc, BlocState>(
                        buildWhen: (previous, current) =>
                            current is TourInfoState,
                        builder: (context, state) {
                          if (state is! TourInfoState) return Container();
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${state.departure} - ${state.destination}",
                                style: theme.textTheme.titleSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${state.time.day} ${monthConverter(state.time.month)}, 1 пассажир',
                                style: theme.textTheme.displaySmall!.copyWith(
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          );
                        })
                  ],
                ),
              ),
              const SizedBox(height: 32),
              BlocBuilder<MainScreenBloc, BlocState>(
                buildWhen: (previous, current) =>
                    current is UpdateTicketsListState,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/icons/filter.png",
                    color: Colors.white,
                    width: 32,
                    height: 32,
                  ),
                  Text("Фильтр", style: theme.textTheme.displaySmall),
                  const SizedBox(width: 24),
                  Image.asset(
                    "assets/icons/graph.png",
                    color: Colors.white,
                    width: 32,
                    height: 32,
                  ),
                  Text("График цен", style: theme.textTheme.displaySmall),
                ],
              ),
            ),
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
    var theme = Theme.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Badge(
        isLabelVisible: ticket.badge != null,
        alignment: AlignmentDirectional.topStart,
        label: Text(
          ticket.badge ?? '',
          style: theme.textTheme.displaySmall,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0).copyWith(top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${ticket.cost} ₽",
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("${ticket.departureTime} - ${ticket.arrivalTime}"),
                      Text(
                        "${ticket.departure?.airport ?? ''}        ${ticket.arrival?.airport ?? ''}",
                        style: theme.textTheme.displaySmall,
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Text(
                      "${ticket.duration ?? "?"}ч. в пути${ticket.hasTransfer == false ? " / Без пересадок" : ""}"),
                ],
              )
            ],
          ),
        ),
      ),
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
