import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

class FourthTabView extends StatefulWidget {
  const FourthTabView({ Key? key, required this.repository }) : super(key: key);

  final Repository repository;

  @override
  _FourthTabViewState createState() => _FourthTabViewState(repository);
}

class _FourthTabViewState extends State<FourthTabView> {
  _FourthTabViewState(this.repository);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
        print('from FourthTabView before context.read<MyTabBloc>()'
    '.add(const EventSelectedTabChanged'); 
    return BlocProvider(
        create: (_) => MyTabBloc(repository: repository)
        ..add(const EventSelectedTabChanged(SelectedTab.fourthTab)),
        child: BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from FourthTabView:  ${state.status}');
      print('from FourthTabView:  ${state.posts}');
      if (state.status == SelectedTab.fourthTab) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print('index from FourthTabView: $index');
            return PostTile(post: state.posts[index]);
          },
          itemCount: state.posts.length,
        );
      }
      return const Center(
          child:
              CircularProgressIndicator(color: Colors.tealAccent));
    }));
  }
}
