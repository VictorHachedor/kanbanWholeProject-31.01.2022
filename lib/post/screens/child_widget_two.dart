import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

class SecondTabView extends StatefulWidget {
  const SecondTabView({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  _SecondTabViewState createState() => _SecondTabViewState(repository);
}

class _SecondTabViewState extends State<SecondTabView> {
  _SecondTabViewState(this.repository);

  final Repository repository;
  @override
  Widget build(BuildContext context) {
    print(
        'from SecondTabView before context.read<MyTabBloc>'
        '().add(const EventSelectedTabChanged');
    return BlocProvider(
      create: (_) => MyTabBloc(repository: repository)
     ..add(const EventSelectedTabChanged(SelectedTab.secondTab)),
      child: 
        BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from SecondTabView:  ${state.status}');
      print('from SecondTabView:  ${state.posts}');
      if (state.status == SelectedTab.secondTab) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print('index from SecondTabView: $index');
            return PostTile(post: state.posts[index]);
          },
          itemCount: state.posts.length,
        );
      }
      return const Center(
          child: CircularProgressIndicator(color: Colors.tealAccent));
    }
    ));
  }
}
