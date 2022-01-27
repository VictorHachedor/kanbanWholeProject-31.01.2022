import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

class ChildWidgetTwo extends StatelessWidget {
  ChildWidgetTwo({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    print(
        'from ChildWidgetTwo before context.read<MyTabBloc>()'
        '.add(const EventSelectedTabChangedFromUI');
    context
        .read<MyTabBloc>()
        .add(const EventSelectedTabChanged(SelectedTab.secondTab));
    return /*RepositoryProvider.value(
      value: repository,
      child:*/
        BlocProvider(
      create: (_) => MyTabBloc(repository: repository),
      child: const SecondTabView(),
    );
    //  );
  }
}

class SecondTabView extends StatefulWidget {
  const SecondTabView({Key? key}) : super(key: key);

  @override
  _SecondTabViewState createState() => _SecondTabViewState();
}

class _SecondTabViewState extends State<SecondTabView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from SecondTabView:  ${state.status}');
      print('from SecondTabView:  ${state.posts}');
      if (state.status == SelectedTab.secondTab) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print(index);
            return PostTile(post: state.posts[index]);
          },
          itemCount: state.posts.length,
        );
      }
      return const Center(child: 
      CircularProgressIndicator(color: Colors.tealAccent));
    });
  }
}
