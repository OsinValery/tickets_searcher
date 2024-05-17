import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_searcher/models/musical_tour_suggestion.dart';
import 'package:tickets_searcher/sources/strings_cashe.dart';
import 'package:tickets_searcher/ui/main/pages_content/destination_selection.dart';

import '../bloc.dart';

class PageWithoutSelectedDestination extends StatelessWidget {
  const PageWithoutSelectedDestination({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ListView(
      shrinkWrap: false,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 33),
          child: Center(
              child: Text(
            "Поиск дешёвых \n авиабилетов",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge,
          )),
        ),
        const CitiesSelectionWidget(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text("Музыкально отлететь", style: theme.textTheme.titleLarge),
        ),
        Container(
          constraints: const BoxConstraints(maxHeight: 250),
          margin: const EdgeInsets.only(left: 16, right: 16),
          child: BlocBuilder<MainScreenBloc, BlocState>(
            buildWhen: (previous, current) =>
                current is UpdateMusicalToursState,
            builder: (context, state) {
              if (state is! UpdateMusicalToursState) return Container();
              var options = state.suggestions;
              return ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    MusicalSuggestionWidget(suggestion: options[index]),
                separatorBuilder: (__, _) => const SizedBox(width: 77),
                itemCount: options.length,
              );
            },
          ),
        )
      ],
    );
  }
}

class CitiesSelectionWidget extends StatefulWidget {
  const CitiesSelectionWidget({super.key});

  @override
  State<CitiesSelectionWidget> createState() => _CitiesSelectionWidgetState();
}

class _CitiesSelectionWidgetState extends State<CitiesSelectionWidget> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    StringsCashe.getFromCity().then((value) {
      if (mounted) _controller!.text = value;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceTint,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      margin: const EdgeInsets.all(16),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff3E3F43),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4)],
        ),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/icons/search.png',
                color: Colors.black,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: "Откуда - Москва",
                      ),
                      controller: _controller!,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[а-яА-Я ]")),
                      ],
                      onChanged: (value) => context
                          .read<MainScreenBloc>()
                          .add(ChangeFromCity(value)),
                    ),
                  ),
                  const Divider(),
                  ElevatedButton(
                    onPressed: () => showModalBottomSheet(
                      backgroundColor: Colors.blue.withAlpha(20),
                      isScrollControlled: true,
                      context: context,
                      builder: (context2) => Padding(
                        padding: const EdgeInsets.only(top: 64),
                        child: DestinationSelectionPage(
                            departure: _controller!.text,
                            bloc: context.read<MainScreenBloc>()),
                      ),
                    ).then((value) => context
                        .read<MainScreenBloc>()
                        .add(FinishDestinationEnteringEvent())),
                    child: const Text('to'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MusicalSuggestionWidget extends StatelessWidget {
  const MusicalSuggestionWidget({Key? key, required this.suggestion})
      : super(key: key);

  final Suggestion suggestion;

  @override
  Widget build(context) {
    var theme = Theme.of(context);
    var id = suggestion.id;
    if (id == null || id > 3) id = 3;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 132,
          height: 132,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage("assets/images/music$id.png"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child:
              Text(suggestion.title ?? "", style: theme.textTheme.titleSmall),
        ),
        Text(suggestion.town ?? "", style: theme.textTheme.labelMedium),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/plane.png",
                fit: BoxFit.fill,
                width: 24,
                height: 24,
                color: const Color(0xff9F9F9F),
              ),
              Text("от ${suggestion.cost} ₽",
                  style: theme.textTheme.labelMedium),
            ],
          ),
        )
      ],
    );
  }
}
