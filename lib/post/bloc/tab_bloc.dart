import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

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
    print('after on<EventSelectedTabChanged>(_onEventSelectedTabChanged)');
  }

  final Repository _repository;

  static const rowZero = '?row=0';
  static const rowOne = '?row=1';
  static const rowTwo = '?row=2';
  static const rowThree = '?row=3';

  @override
  Future<void> close() {
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
      case SelectedTab.tab:
        try {
          final posts = await _repository.fetchData(rowZero, SelectedTab.tab);
          print('from _onEventSelectedTabChanged '
              'SelectedTab.tab: ${event.status}');
          print('from _onEventSelectedTabChanged SelectedTab.tab: $posts');
          print('from _onEventSelectedTabChanged after'
              '_tabStatusSubscription.cancel');
          return emitter(MyTabState.tab(posts));
        } catch (e) {
          Error error = ArgumentError('error from _onEventSelectedTabChanged '
              'SelectedTab.tab: $e');
          throw (error);
        }
      case SelectedTab.secondTab:
        try {
          final posts =
              await _repository.fetchData(rowOne, SelectedTab.secondTab);
          print(
              'from _onEventSelectedTabChanged SelectedTab.secondTab: $posts');
          return emitter(MyTabState.secondTab(posts));
        } catch (e) {
          Error error = ArgumentError('error from _onEventSelectedTabChanged '
              'SelectedTab.secondTab: $e');
          throw (error);
        }
      case SelectedTab.thirdTab:
        try {
          final posts =
              await _repository.fetchData(rowTwo, SelectedTab.thirdTab);
          print('from _onEventSelectedTabChanged SelectedTab.thirdTab: $posts');
          return (emitter(MyTabState.thirdTab(posts)));
        } catch (e) {
          Error error = ArgumentError('error from _onEventSelectedTabChanged '
              'SelectedTab.thirdTab: $e');
          throw (error);
        }
      case SelectedTab.fourthTab:
        try {
          final posts =
              await _repository.fetchData(rowThree, SelectedTab.fourthTab);
          print(
              'from _onEventSelectedTabChanged SelectedTab.fourthTab: $posts');
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
