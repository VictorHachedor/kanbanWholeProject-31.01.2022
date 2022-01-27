import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/post.dart';
import '../repository/repo.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class MyTabBloc extends Bloc<MyTabEvent, MyTabState> {
  MyTabBloc({required Repository repository})
      : _repository = repository,
        super(const MyTabState.voidd()) {
    print('before on<EventSelectedTabChanged>(_onEventSelectedTabChanged)');

    on<EventSelectedTabChanged>(
      _onEventSelectedTabChanged,
    );
    _tabStatusSubscription = _repository.status.listen(
      (status) => add(EventSelectedTabChanged(status)),
    );
    print('after on<EventSelectedTabChanged>(_onEventSelectedTabChanged)');
  }

  final Repository _repository;
  late StreamSubscription<SelectedTab> _tabStatusSubscription;

  @override
  Future<void> close() {
    _tabStatusSubscription.cancel();
    _repository.dispose();
    return super.close();
  }

  Future<void> _onEventSelectedTabChanged(
    EventSelectedTabChanged event,
    Emitter<MyTabState> emitter,
  ) async {
    print('from start _onEventSelectedTabChanged');
    switch (event.status) {
      case SelectedTab.voidd:
        print('from _onEventSelectedTabChanged case SelectedTab.voidd');
        return;
      //    case SelectedTab.initial:
      //    print('from _onEventSelectedTabChanged case SelectedTab.initial');
      //     return;
      case SelectedTab.tab:
        try {
          final posts = await _repository.childWidgetData();
          print(
              'from _onEventSelectedTabChanged '
              'SelectedTab.tab: ${event.status}');
          print('from _onEventSelectedTabChanged SelectedTab.tab: $posts');
          await _tabStatusSubscription.cancel();
          print(
            'from _onEventSelectedTabChanged after'
            '_tabStatusSubscription.cancel');
          return emitter(MyTabState.tab(posts));
        } catch (_) {
          Error error = ArgumentError('error from _onEventSelectedTabChanged ' 
          'SelectedTab.tab');
          throw (error);
        }
      case SelectedTab.secondTab:
        try {
          final posts = await _repository.childWidgetTwoData();
          print(
              'from _onEventSelectedTabChanged SelectedTab.secondTab: $posts');
          await _tabStatusSubscription.cancel();
          return (emitter(MyTabState.secondTab(posts)));
        } catch (_) {
          Error error = ArgumentError('error from _onEventSelectedTabChanged '
          'SelectedTab.secondTab');
          throw (error);
        }
      case SelectedTab.thirdTab:
        try {
          final posts = await _repository.childWidgetThreeData();
          print('from _onEventSelectedTabChanged SelectedTab.thirdTab: $posts');
          await _tabStatusSubscription.cancel();
          return (emitter(MyTabState.thirdTab(posts)));
        } catch (_) {
          Error error = ArgumentError('error from _onEventSelectedTabChanged '
          'SelectedTab.thirdTab');
          throw (error);
        }
      case SelectedTab.fourthTab:
        try {
          final posts = await _repository.childWidgetFourData();
          print(
              'from _onEventSelectedTabChanged SelectedTab.fourthTab: $posts');
          await _tabStatusSubscription.cancel();
          return (emitter(MyTabState.fourthTab(posts)));
        } catch (_) {
          Error error = ArgumentError('error from _onEventSelectedTabChanged '
          'SelectedTab.fourthTab');
          throw (error);
        }
      default:
      Error error = ArgumentError('from _onEventSelectedTabChanged default');
        throw (error);
    }
  }
}
