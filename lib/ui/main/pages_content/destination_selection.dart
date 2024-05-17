import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tickets_searcher/ui/main/bloc.dart';

class DestinationSelectionPage extends StatefulWidget {
  const DestinationSelectionPage({
    super.key,
    required this.departure,
    required this.bloc,
  });

  final String departure;
  final MainScreenBloc bloc;

  @override
  State<DestinationSelectionPage> createState() =>
      _DestinationSelectionPageState();
}

class _DestinationSelectionPageState extends State<DestinationSelectionPage> {
  TextEditingController? _controller;
  int page = 0;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void selectCity(String city) {
    _controller?.text = city;
    widget.bloc.add(DestinationChangedEvent(city));
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    if (page != 0) {
      return Container(
        color: theme.colorScheme.surface,
        child: MockWidget(index: page, onBack: () => setState(() => page = 0)),
      );
    }
    ;
    var colors = [
      const Color(0xff3A633B),
      theme.colorScheme.primary,
      const Color(0xff00427D),
      Colors.red
    ];
    var texts = [
      "Сложный\nмаршрут",
      "Куда угодно\n",
      "Выходные\n",
      "Горячие\nБилеты"
    ];
    var callbacs = [
      () => setState(() => page = 1),
      () => selectCity("Куда угодно"),
      () => setState(() => page = 2),
      () => setState(() => page = 3),
    ];

    var icons = [
      "assets/icons/command.png",
      "assets/icons/globus.png",
      "assets/icons/holidays.png",
      "assets/icons/fire.png",
    ];

    var popilarCities = ['Стамбул', "Сочи", "Пхукет"];

    return Material(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          const Text("blebleble"),
          Container(
            padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [const Icon(Icons.place), Text(widget.departure)],
                ),
                const Divider(),
                TextField(
                  controller: _controller,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[а-яА-Я ]")),
                  ],
                  onChanged: (value) =>
                      widget.bloc.add(DestinationChangedEvent(value)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => GestureDetector(
                  onTap: () => callbacs[index](),
                  child: Container(
                    color: Colors.blue.withAlpha(5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: colors[index],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(icons[index]),
                        ),
                        const SizedBox(height: 8),
                        Text(texts[index], style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceTint,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => selectCity(popilarCities[index]),
                child: Container(
                  color: Colors.white.withAlpha(1),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/${[
                                'stambool',
                                'sochi',
                                'phuket'
                              ][index]}.png")),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popilarCities[index],
                            style: theme.textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Популярное направление",
                            style: theme.textTheme.labelMedium!
                                .copyWith(color: const Color(0xff5E5F61)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              separatorBuilder: (_, __) => const Divider(),
              itemCount: 3,
            ),
          )
        ],
      ),
    );
  }
}

class MockWidget extends StatelessWidget {
  const MockWidget({super.key, required this.index, required this.onBack});

  final int index;
  final Function() onBack;

  @override
  Widget build(BuildContext context) {
    var texts = {1: "сложного маршрута", 2: "выходных", 3: "горячих билетов"};
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Заглушка для ${texts[index]}"),
          ElevatedButton(onPressed: onBack, child: const Text("Назад"))
        ],
      ),
    );
  }
}
