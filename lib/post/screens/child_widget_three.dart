import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/post/models/post.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

/*class ChildWidgetThree extends StatelessWidget {
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
}*/

class ThirdTabView extends StatefulWidget {
  const ThirdTabView({Key? key, required this.repository, required this.posts}) 
  : super(key: key);

   final Repository repository;
   final List<Post> posts;

  @override
  _ThirdTabViewState createState() => _ThirdTabViewState(repository, posts);
}

class _ThirdTabViewState extends State<ThirdTabView> {
  _ThirdTabViewState(this.repository, this.posts);

  final Repository repository;
  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
        print(
        'from ThirdTabView before context.read<MyTabBloc>'
        '().add(const EventSelectedTabChanged');    
//    context
//        .read<MyTabBloc>()
//        .add(const EventSelectedTabChanged(SelectedTab.thirdTab)); 
  /*  return BlocProvider(
          create: (_) => MyTabBloc(repository: repository)
          ..add(const EventSelectedTabChanged(SelectedTab.thirdTab)),
          child: BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
      print('from ThirdTabView:  ${state.status}');
      print('from ThirdTabView:  ${state.posts}');
      if (state.status == SelectedTab.thirdTab) {         */
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            print(index);
            return posts.isEmpty ? const Center(child: 
      CircularProgressIndicator(color: Colors.tealAccent)) :
            PostTile(post: posts[index]);
          },
          itemCount: posts.length,
        );
  //    return const Center(child: 
 //     CircularProgressIndicator(color: Colors.tealAccent));
    }
}
