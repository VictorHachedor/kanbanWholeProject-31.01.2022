import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/authentication.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import 'screens.dart';

class MyAppoo extends StatelessWidget {
  const MyAppoo({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    print('MyAppoo build');
    return RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) => MyTabBloc(repository: repository),
          child: MyAppooView(
            repository: repository,
          ),
        ));
  }
}

const List<Tab> tabs = <Tab>[
  Tab(text: 'On hold'),
  Tab(text: 'In progress'),
  Tab(text: 'Needs review'),
  Tab(text: 'Approved'),
];

class MyAppooView extends StatefulWidget {
  MyAppooView({Key? key, required this.repository}) : super(key: key);
  final Repository repository;

  @override
  _MyAppooViewState createState() => _MyAppooViewState(repository);
}

class _MyAppooViewState extends State<MyAppooView>
    with SingleTickerProviderStateMixin {
  _MyAppooViewState(this.repository);

  final Repository repository;

  late TabController _controller;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print('Selected Index: ${_controller.index}');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('from MyAppooView');
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          actions: [
            FloatingActionButton(
              mini: true,
              backgroundColor: Colors.tealAccent,
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.tealAccent,
            indicatorWeight: 3,
            controller: _controller,
            tabs: tabs,
          ),
        ),
        body: TabBarView(controller: _controller, children: [
          //TODO one child!
          buildPageController(_selectedIndex, repository),
          buildPageController(_selectedIndex, repository),
          buildPageController(_selectedIndex, repository),
          buildPageController(_selectedIndex, repository),
        ]),
      );
    });
    //  );
  }
}

Widget buildPageController(int selectedIndex, Repository repository) {
  switch (selectedIndex) {
    case 0:
      return ChildWidget(repository: repository);
    case 1:
      return ChildWidgetTwo(repository: repository);
    case 2:
      return ChildWidgetThree(repository: repository);
    case 3:
      return ChildWidgetFour(repository: repository);
    default:
      ChildWidget(repository: repository);
  }
  Error error = ArgumentError('smth wrong in buildPageController');
  return throw (error);
}
