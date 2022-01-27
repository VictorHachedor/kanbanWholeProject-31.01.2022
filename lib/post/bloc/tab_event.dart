part of 'tab_bloc.dart';

abstract class MyTabEvent extends Equatable {
  const MyTabEvent();

  @override
  List<Object> get props => [];
}

class EventSelectedTabChanged extends MyTabEvent {
  const EventSelectedTabChanged(this.status);

  

  final SelectedTab status;

  @override
  List<Object> get props => [status];
}

class EventSelectedTabChangedFromUI extends MyTabEvent {
  const EventSelectedTabChangedFromUI(this.status);

  final SelectedTab status;

  @override
  List<Object> get props => [status];
}
