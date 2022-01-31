part of 'tab_bloc.dart';

class MyTabState extends Equatable {
  const MyTabState._({
    this.status =  SelectedTab.voidd,
    this.posts = const <Post>[],
  });

const MyTabState.voidd() 
  : this._();

  const MyTabState.tab(List<Post> posts) 
  : this._(status: SelectedTab.tab, posts: posts);

  const MyTabState.secondTab(List<Post> posts) 
  : this._(status: SelectedTab.secondTab, posts: posts);

  const MyTabState.thirdTab(List<Post> posts) 
  : this._(status: SelectedTab.thirdTab, posts: posts);

  const MyTabState.fourthTab(List<Post> posts) 
  : this._(status: SelectedTab.fourthTab, posts: posts);

  final SelectedTab status;
  final List<Post> posts;

  @override
  List<Object> get props => [status, posts];
}
