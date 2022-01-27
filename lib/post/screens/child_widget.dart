import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

class ChildWidget extends StatelessWidget {
  ChildWidget({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    print(
        'from ChildWidget before context.read<MyTabBloc>'
        '().add(const EventSelectedTabChangedFromUI');
    context
        .read<MyTabBloc>()
        .add(const EventSelectedTabChanged(SelectedTab.tab));
    return /*RepositoryProvider.value(
        value: repository,
        child:*/
        BlocProvider(
      create: (_) => MyTabBloc(repository: repository),
      child: const FirstTabView(),
    );
    //);
  }
}

class FirstTabView extends StatefulWidget {
  const FirstTabView({Key? key}) : super(key: key);

  @override
  _FirstTabViewState createState() => _FirstTabViewState();
}

class _FirstTabViewState extends State<FirstTabView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from FirstTabView:  ${state.status}');
      print('from FirstTabView:  ${state.posts}');
      if (state.status == SelectedTab.tab) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print('index from FirstTabView: $index');
            return PostTile(post: state.posts[index]);
          },
          itemCount: state.posts.length,
        );
      }
      return const Center(
          child: CircularProgressIndicator(color: Colors.tealAccent));
    });
  }
}
