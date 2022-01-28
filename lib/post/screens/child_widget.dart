import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/post/models/post.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

/*class ChildWidget extends StatelessWidget {
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
}*/

class FirstTabView extends StatefulWidget {
  const FirstTabView({Key? key, required this.repository, 
  required this.posts}) : super(key: key);

  final Repository repository;
  final List<Post> posts;

  @override
  _FirstTabViewState createState() => _FirstTabViewState(repository, posts);
}

class _FirstTabViewState extends State<FirstTabView> {
  _FirstTabViewState(this.repository, this.posts);

  final Repository repository;
    final List<Post> posts;
    
  @override
  Widget build(BuildContext context) {
    print(
        'from FirstTabView before context.read<MyTabBloc>'
        '().add(const EventSelectedTabChanged');
   // context
 //       .read<MyTabBloc>()
  //      .add(const EventSelectedTabChanged(SelectedTab.tab));
 /*   return BlocProvider(
      create: (_) => MyTabBloc(repository: repository)
     ..add(const EventSelectedTabChanged(SelectedTab.tab)),
      child: 
        BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from FirstTabView:  ${state.status}');
      print('from FirstTabView:  ${state.posts}');
      if (state.status == SelectedTab.tab) {            */
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print('index from FirstTabView: $index');
            return posts.isEmpty ? const Center(
          child: CircularProgressIndicator(color: Colors.tealAccent)) :
            PostTile(post: posts[index]);
          },
          itemCount: posts.length,
        );
//      return const Center(
  //        child: CircularProgressIndicator(color: Colors.tealAccent));
  }
}
