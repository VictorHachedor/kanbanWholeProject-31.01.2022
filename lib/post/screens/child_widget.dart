import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/post/models/post.dart';

import '../bloc/tab_bloc.dart';
import '../repository/repo.dart';
import '../screens/post_tile.dart';

class FirstTabView extends StatefulWidget {
  const FirstTabView({Key? key, required this.repository}) : super(key: key);

  final Repository repository;

  @override
  _FirstTabViewState createState() => _FirstTabViewState(repository);
}

class _FirstTabViewState extends State<FirstTabView> {
  _FirstTabViewState(this.repository);

  final Repository repository;
  @override
  Widget build(BuildContext context) {
    var firstTabPosts = <Post>[];
    print('from FirstTabView before context.read<MyTabBloc>'
        '().add(const EventSelectedTabChanged');
    return BlocProvider(
        create: (_) => MyTabBloc(repository: repository)
          ..add(const EventSelectedTabChanged(SelectedTab.tab)),
        child: BlocBuilder<MyTabBloc, MyTabState>(builder: (context, state) {
          print('from FirstTabView:  ${state.status}');
          print('from FirstTabView:  ${state.posts}');
          selectedPosts(state, firstTabPosts);

          if (state.status == SelectedTab.tab) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print('index from FirstTabView: $index');
                return PostTile(
                  post: Post(
                      id: firstTabPosts[index].id,
                      row: firstTabPosts[index].row,
                      text: firstTabPosts[index].text),
                  //state.posts[index]
                );
              },
              itemCount: firstTabPosts.length,
              //state.posts.length,
            );
          }
          return const Center(
              child: CircularProgressIndicator(color: Colors.tealAccent));
        }));
  }

  void selectedPosts(MyTabState state, List<Post> firstTabPosts) {
    for (var i = 0; i < state.posts.length; i++) {
      if (state.posts[i].row == '0') {
        firstTabPosts.add(state.posts[i]);
      }
    }
  }
}
