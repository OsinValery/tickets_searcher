import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tickets_searcher/ui/main/pages_content/destination_selected_page.dart';
import 'package:tickets_searcher/ui/main/pages_content/tickets_list_page.dart';
import './pages_content/page_without_destination.dart';
import 'bloc.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  var bloc = MainScreenBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainScreenBloc>(
      create: (_) => bloc,
      child: const EventsListener(child: ViewContent()),
    );
  }
}

class EventsListener extends StatelessWidget {
  const EventsListener({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MainScreenBloc, BlocState>(
      listener: (_, __) {},
      listenWhen: (previous, current) => false,
      child: child,
    );
  }
}

class ViewContent extends StatelessWidget {
  const ViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, BlocState>(
      buildWhen: (previous, current) => current is SelectPageState,
      builder: (context, state) {
        if (state is InitialState) return Container();
        int page = (state as SelectPageState).page;
        return Scaffold(
          body: page == 0 ? const AviaTicketsPage() : MockPage(page: page),
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: page,
            onTap: (v) =>
                context.read<MainScreenBloc>().add(SelectPageEvent(v)),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/aviaticket.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                    color: page == 0 ? Colors.blue : Colors.white,
                  ),
                  label: "Авиабилеты"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/hotel.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                    color: page == 1 ? Colors.blue : Colors.white,
                  ),
                  label: "Отели"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/shorter.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                    color: page == 2 ? Colors.blue : Colors.white,
                  ),
                  label: "Короче"),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/subscription.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.fill,
                    color: page == 3 ? Colors.blue : Colors.white,
                  ),
                  label: "Подписки"),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/icons/profile.png",
                  width: 24,
                  height: 24,
                  fit: BoxFit.fill,
                  color: page == 4 ? Colors.blue : Colors.white,
                ),
                label: "Профиль",
              ),
            ],
          ),
        );
      },
    );
  }
}

class AviaTicketsPage extends StatelessWidget {
  const AviaTicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, BlocState>(
      buildWhen: (previous, current) => current is ChangePageStageState,
      builder: (context, state) {
        if (state is! ChangePageStageState) {
          return const PageWithoutSelectedDestination();
        }
        return switch (state.stage) {
          NavigationStage.withoutDestination =>
            const PageWithoutSelectedDestination(),
          NavigationStage.showDestination => const DestinationPresenterPage(),
          NavigationStage.showTickets => const TicketsListPage(),
          // _ => Container(),
        };
      },
    );
  }
}

// ------------------------------------------
// mock
// ------------------------------------------

class MockPage extends StatelessWidget {
  const MockPage({super.key, required this.page});

  final int page;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        switch (page) {
          1 => "Мок для отелей",
          2 => "Мок для короче",
          3 => "Мок для подписок",
          4 => "Мок для профиля",
          _ => "unknown page",
        },
      ),
    );
  }
}
