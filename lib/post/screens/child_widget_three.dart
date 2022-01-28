import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

class ThirdTabView extends StatefulWidget {
  const ThirdTabView({Key? key, required this.repository}) : super(key: key);

   final Repository repository;

  @override
  _ThirdTabViewState createState() => _ThirdTabViewState(repository);
}

class _ThirdTabViewState extends State<ThirdTabView> {
  _ThirdTabViewState(this.repository);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
        print(
        'from ThirdTabView before context.read<MyTabBloc>'
        '().add(const EventSelectedTabChanged');    
    return BlocProvider(
          create: (_) => MyTabBloc(repository: repository)
          ..add(const EventSelectedTabChanged(SelectedTab.thirdTab)),
          child: BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from ThirdTabView:  ${state.status}');
      print('from ThirdTabView:  ${state.posts}');
      if (state.status == SelectedTab.thirdTab) {
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
    }));
  }
}
