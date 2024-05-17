import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_searcher/models/city_suggestion.dart';
import 'package:tickets_searcher/ui/main/bloc.dart';

class DestinationPresenterPage extends StatelessWidget {
  const DestinationPresenterPage({super.key});

  Future<DateTime?> pickTime(BuildContext context) async {
    var time = DateTime.now();
    return showDatePicker(
      context: context,
      firstDate: time,
      initialDate: time,
      lastDate: time.add(const Duration(days: 3653)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          BlocBuilder<MainScreenBloc, BlocState>(
              buildWhen: (previous, current) => current is SetWayPointsState,
              builder: (context, state) {
                var from = "from", to = "to";
                if (state is SetWayPointsState) {
                  from = state.departure;
                  to = state.destination;
                }

                return Container(
                  margin: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                  padding:
                      const EdgeInsets.only(top: 18, bottom: 18, right: 16),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceTint,
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () =>
                              context.read<MainScreenBloc>().add(GoBackEvent()),
                          icon: Image.asset("assets/icons/left.png")),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(from, style: theme.textTheme.labelLarge),
                                IconButton(
                                  onPressed: () => context
                                      .read<MainScreenBloc>()
                                      .add(WayPointsExchange()),
                                  icon: Image.asset(
                                    "assets/icons/change.png",
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(to, style: theme.textTheme.labelLarge),
                                const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text("X"),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),

          // date and time
          BlocBuilder<MainScreenBloc, BlocState>(
            buildWhen: (previous, current) => current is RaiseTimeState,
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  pickTime(context).then((value) => context
                      .read<MainScreenBloc>()
                      .add(PickFromDateEvent(value)));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, bottom: 16),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceTint,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(8),
                          child: state is! RaiseTimeState || state.from == null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      "Обратно",
                                      style: theme.textTheme.displaySmall,
                                    )
                                  ],
                                )
                              : DatePresenter(time: state.from!),
                        ),
                        GestureDetector(
                          onTap: () {
                            pickTime(context).then((value) => context
                                .read<MainScreenBloc>()
                                .add(PickToDateEvent(value)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceTint,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.all(8),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: DatePresenter(
                              time: state is RaiseTimeState
                                  ? state.to
                                  : DateTime.now(),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceTint,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/profile.png",
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "1, эконом",
                                style: theme.textTheme.displaySmall,
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceTint,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/filter.png",
                                width: 16,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              Text("Фильтры",
                                  style: theme.textTheme.displaySmall)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // all raises from api
          BlocBuilder<MainScreenBloc, BlocState>(
            buildWhen: (previous, current) => current is UpdateRaicesListState,
            builder: (context, state) {
              if (state is! UpdateRaicesListState) return Container();
              return Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Прямые рейсы", style: theme.textTheme.titleLarge),
                    const SizedBox(height: 8),
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, i) =>
                          RaiseView(index: i, suggestion: state.raices[i]),
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: min(3, state.raices.length),
                    ),
                  ],
                ),
              );
            },
          ),
          // show all tickets
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                context.read<MainScreenBloc>().add(SeeTicketsEvent());
              },
              child: Text(
                "Посмотреть все билеты",
                style: theme.textTheme.labelLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DatePresenter extends StatelessWidget {
  const DatePresenter({
    super.key,
    required this.time,
  });

  final DateTime time;

  @override
  Widget build(BuildContext context) {
    var text =
        "${time.day}  ${monthConverter(time.month)},  ${weekday(time.weekday)}.";
    return Text(text, style: Theme.of(context).textTheme.displaySmall);
  }
}

class RaiseView extends StatelessWidget {
  const RaiseView({
    super.key,
    required this.index,
    required this.suggestion,
  });

  final int index;
  final RaiceSuggestion suggestion;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: switch (index) {
              0 => Colors.red,
              1 => const Color(0xff2261BC),
              _ => Colors.white,
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(suggestion.title ?? "",
                      style: theme.textTheme.displaySmall),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${suggestion.cost} ₽",
                        style: theme.textTheme.displaySmall!
                            .copyWith(color: const Color(0xff2261BC)),
                      ),
                      const Icon(Icons.keyboard_arrow_right,
                          color: Color(0xff2261BC))
                    ],
                  )
                ],
              ),
              Text(
                suggestion.timesLine,
                style: theme.textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}

String weekday(int day) {
  return switch (day - 1) {
    0 => "пн",
    1 => "вт",
    2 => "ср",
    3 => "чт",
    4 => "пт",
    5 => "сб",
    6 => "вс",
    _ => "unknown"
  };
}

String monthConverter(int month) {
  return switch (month - 1) {
    0 => "Янв",
    1 => "Фев",
    2 => "Мар",
    3 => "Апр",
    4 => "Мая",
    5 => "Июня",
    6 => "Июля",
    7 => "Авг",
    8 => "Сен",
    9 => "Окт",
    10 => "Ноя",
    11 => "Дек",
    _ => "unknown"
  };
}
