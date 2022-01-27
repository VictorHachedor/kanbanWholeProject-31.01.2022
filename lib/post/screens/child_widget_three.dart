import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

class ChildWidgetThree extends StatelessWidget {
  ChildWidgetThree({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  Widget build(BuildContext context) {
    print(
        'from ChildWidgetThree before context.read<MyTabBloc>'
        '().add(const EventSelectedTabChangedFromUI');
    context
        .read<MyTabBloc>()
        .add(const EventSelectedTabChanged(SelectedTab.thirdTab));          
    return RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) => MyTabBloc(repository: repository),
          child: const ThirdTabView(),
        ));
  }
}

class ThirdTabView extends StatefulWidget {
  const ThirdTabView({Key? key}) : super(key: key);

  @override
  _ThirdTabViewState createState() => _ThirdTabViewState();
}

class _ThirdTabViewState extends State<ThirdTabView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
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
    });
  }
}
