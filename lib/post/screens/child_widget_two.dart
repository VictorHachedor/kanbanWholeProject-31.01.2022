import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/post/models/post.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

/*class ChildWidgetTwo extends StatelessWidget {
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
}*/

class SecondTabView extends StatefulWidget {
  const SecondTabView({Key? key, required this.repository, 
  required this.posts}) : super(key: key);

  final Repository repository;
  final List<Post> posts;

  @override
  _SecondTabViewState createState() => _SecondTabViewState(repository, posts);
}

class _SecondTabViewState extends State<SecondTabView> {
  _SecondTabViewState(this.repository, this.posts);

  final Repository repository;
  final List<Post> posts;
  
  @override
  Widget build(BuildContext context) {
 //   context
 //       .read<MyTabBloc>()
//        .add(const EventSelectedTabChanged(SelectedTab.secondTab));
   /* return BlocProvider(
      create: (_) => MyTabBloc(repository: repository)
      ..add(const EventSelectedTabChanged(SelectedTab.secondTab)),
      child: 
            BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from SecondTabView:  ${state.status}');
      print('from SecondTabView:  ${state.posts}');
      if (state.status == SelectedTab.secondTab) {              */
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print(index);
            return posts.isEmpty ? const Center(
          child: CircularProgressIndicator(color: Colors.tealAccent)) :
            PostTile(post: posts[index]);
          },
          itemCount: posts.length,
        );
 //     } 
 //     return const Center(
 //         child: CircularProgressIndicator(color: Colors.tealAccent));
    }
  }

